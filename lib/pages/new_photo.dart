import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photodiary/util/const.dart';
import 'package:image_picker/image_picker.dart';

class NewPhotoPage extends StatefulWidget {
  static const routeName = RoutesName.newPhotoPage;

  NewPhotoPage({Key key}) : super(key: key);

  @override
  _NewPhotoPageState createState() => _NewPhotoPageState();
}

class _NewPhotoPageState extends State<NewPhotoPage> {
  //记录选择的照片
  File _image;
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
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
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
            ),
          ],
        ),
      ),
    );
  }
}
