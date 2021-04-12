import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photodiary/util/const.dart';

class NewPhotoPage extends StatefulWidget {
  static const routeName = RoutesName.newPhotoPage;

  NewPhotoPage({Key key}) : super(key: key);

  @override
  _NewPhotoPageState createState() => _NewPhotoPageState();
}

class _NewPhotoPageState extends State<NewPhotoPage> {
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
            Card(
              child: Container(
                width: ScreenUtil().screenWidth,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
