import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photodiary/components/button.dart';
import 'package:photodiary/components/icon_text.dart';
import 'package:photodiary/util/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exif/exif.dart';

class ExifInfo {
  // 拍摄时间
  String imageDatetime;
  // 镜头型号
  String lensModel;
  // 设备型号
  String imageModel;
  // 光圈
  String fNumber;
  // ISO
  String iso;
  // 快门
  String exposureTime;
}

class NewPhotoPage extends StatefulWidget {
  static const routeName = RoutesName.newPhotoPage;

  NewPhotoPage({Key key}) : super(key: key);

  @override
  _NewPhotoPageState createState() => _NewPhotoPageState();
}

class _NewPhotoPageState extends State<NewPhotoPage> {
  //记录选择的照片
  File _image;

  //当图片上传成功后，记录当前上传的图片在服务器中的位置
  String _imgServerPath;

  ExifInfo _exif = new ExifInfo();

  final picker = ImagePicker();

  //拍照
  Future _getImageFromCamera() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      Permission.camera.request();
    }

    final pickedFile = await picker.getImage(source: ImageSource.camera, maxWidth: 400);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        getExifOf(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //相册选择
  Future _getImageFromGallery() async {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      Permission.photos.request();
    }

    final pickedFile = await picker.getImage(source: ImageSource.gallery, maxWidth: 400);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        getExifOf(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //上传图片到服务器
  _uploadImage() async {
    print('------------------');
    print(_image.absolute);
    FormData formData = FormData.fromMap({
      //"": "", //这里写其他需要传递的参数
      "file": {_image, "imageName.png"},
    });
    var response = await Dio().post("http://xx.xxx.com/imgupload", data: formData);
    print(response);
    if (response.statusCode == 200) {
      Map responseMap = response.data;
      print("http://xx.xxx.com${responseMap["path"]}");
      setState(() {
        _imgServerPath = "http://xx.xxx.com${responseMap["path"]}";
      });
      print(_imgServerPath);
    } else {
      print('failed');
    }
  }

  // 获取照片参数
  getExifOf(String path) async {
    Map<String, IfdTag> tags = await readExifFromBytes(await new File(path).readAsBytes());
    tags.forEach((String key, IfdTag value) {
      switch (key) {
        case "EXIF DateTimeOriginal":
          {
            _exif.imageDatetime = value.toString();
          }
          break;
        case "EXIF LensModel":
          {
            _exif.lensModel = value.toString();
          }
          break;
        case "Image Model":
          {
            _exif.imageModel = value.toString();
          }
          break;
        case "EXIF FNumber":
          {
            _exif.fNumber = value.toString();
          }
          break;
        case "EXIF ExposureTime":
          {
            _exif.exposureTime = value.toString();
          }
          break;
        case "EXIF ISOSpeedRatings":
          {
            _exif.iso = value.toString();
          }
          break;
        case "EXIF LensModel":
          {
            _exif.lensModel = value.toString();
          }
          break;
      }
    });
  }

  Future _openModalBottomSheet() async {
    final option = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: ScreenUtil().setHeight(200),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('拍照', textAlign: TextAlign.center),
                  onTap: () {
                    Navigator.pop(context);
                    _getImageFromCamera();
                  },
                ),
                ListTile(
                  title: Text('相册', textAlign: TextAlign.center),
                  onTap: () {
                    Navigator.pop(context);
                    _getImageFromGallery();
                  },
                ),
                ListTile(
                  title: Text('取消', textAlign: TextAlign.center),
                  onTap: () {
                    Navigator.pop(context, '取消');
                  },
                ),
              ],
            ),
          );
        });

    print(option);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      // allowFontScaling: false,
      builder: () => Scaffold(
        appBar: AppBar(
          title: Text('上传照片'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
          child: ListView(
            children: [
              GestureDetector(
                onTap: _openModalBottomSheet,
                child: Card(
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    height: 200,
                    child: _image == null
                        ? Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 30,
                            ),
                          )
                        : Image.file(
                            _image,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              _image == null
                  ? SizedBox(height: ScreenUtil().setHeight(10))
                  : Container(
                      // color: Colors.black,
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10.0),
                        children: <Widget>[
                          // 时间
                          IconText(
                            _exif.imageDatetime == null ? " " : " " + _exif.imageDatetime,
                            icon: Icon(Icons.schedule, color: Colors.white),
                            iconSize: 16,
                            style: TextStyle(color: Colors.white),
                          ),
                          // 设备型号
                          IconText(
                            _exif.imageModel == null ? " " : " " + _exif.imageModel,
                            icon: Icon(Icons.photo_camera, color: Colors.white),
                            iconSize: 16,
                            style: TextStyle(color: Colors.white),
                          ),
                          // 镜头型号
                          IconText(
                            _exif.lensModel == null ? " " : " " + _exif.lensModel,
                            icon: Icon(Icons.camera_outlined, color: Colors.white),
                            iconSize: 16,
                            style: TextStyle(color: Colors.white),
                          ),
                          // 光圈
                          IconText(
                            _exif.fNumber == null ? " " : " " + _exif.fNumber,
                            icon: Icon(Icons.camera, color: Colors.white),
                            iconSize: 16,
                            style: TextStyle(color: Colors.white),
                          ),
                          // 快门
                          IconText(
                            _exif.exposureTime == null ? " " : " " + _exif.exposureTime + " s",
                            icon: Icon(Icons.shutter_speed, color: Colors.white),
                            iconSize: 16,
                            style: TextStyle(color: Colors.white),
                          ),
                          // iso
                          IconText(
                            _exif.iso == null ? " " : " " + _exif.iso,
                            icon: Icon(Icons.iso, color: Colors.white),
                            iconSize: 16,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      // margin: EdgeInsets.all(5.0),
                      width: ScreenUtil().screenWidth,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                        // backgroundBlendMode: BlendMode.clear,
                      ),
                    ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              TextFormField(),
              SizedBox(height: ScreenUtil().setHeight(10)),
              button(context, '上传照片', _uploadImage),
            ],
          ),
        ),
      ),
    );
  }
}
