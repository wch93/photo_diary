import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photodiary/components/button.dart';
import 'package:photodiary/util/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exif/exif.dart';

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

  final picker = ImagePicker();

  //拍照
  Future _getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxWidth: 400);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //相册选择
  Future _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, maxWidth: 400);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //上传图片到服务器
  _uploadImage() async {
    print('------------------');
    print(_image.absolute);
    var d = await printExifOf(_image.path);
    print(d);
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

  printExifOf(String path) async {
    Map<String, IfdTag> tags = await readExifFromBytes(await new File(path).readAsBytes());
    var sb = StringBuffer();

    tags.forEach((k, v) {
      sb.write("$k: $v \n");
    });

    return sb.toString();
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
                              Icons.add,
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
