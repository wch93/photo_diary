import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Photo {
  const Photo({
    @required this.assetName,
    @required this.title,
    @required this.description,
    @required this.city,
    @required this.location,
  })  : assert(assetName != null),
        assert(title != null),
        assert(description != null),
        assert(city != null),
        assert(location != null);

  final String assetName;
  final String title;
  final String description;
  final String city;
  final String location;
}

List<Photo> photos(BuildContext context) => [
      Photo(
        assetName: 'assets/IMG_0001.JPG',
        title: "十三陵水库旁边的小泰迪",
        description: "晴天,阳光明媚",
        city: "北京",
        location: "十三陵",
      ),
      Photo(
        assetName: 'assets/IMG_0002.JPG',
        title: "公园盛开的粉色花朵",
        description: "蓝天白云心情好",
        city: "Beijing",
        location: "Chaoyang",
      ),
      Photo(
        assetName: 'assets/IMG_0003.JPG',
        title: "假装在日本之福神店",
        description: "就看看,买不起",
        city: "北京市昌平区",
        location: "奥特莱斯",
      ),
      Photo(
        assetName: 'assets/IMG_0004.JPG',
        title: "奶茶店对着墙发呆",
        description: "也没啥好喝的",
        city: "北京市西城区",
        location: "西单大悦城",
      ),
      Photo(
        assetName: 'assets/IMG_0005.JPG',
        title: "假装在日本之居酒屋",
        description: "其实在村里",
        city: "北京市海淀区",
        location: "大马路边上",
      ),
      Photo(
        assetName: 'assets/IMG_0006.JPG',
        title: "这车真帅",
        description: "可惜这车牌了",
        city: "北京市朝阳区",
        location: "798艺术区",
      ),
      Photo(
        assetName: 'assets/IMG_0007.JPG',
        title: "海滩之旅",
        description: "一堆遮阳的",
        city: "海南省三亚市",
        location: "就在大海边",
      ),
      Photo(
        assetName: 'assets/IMG_0008.JPG',
        title: "你幸福么?",
        description: "在屯里挺幸福",
        city: "北京市朝阳区",
        location: "三里屯",
      ),
      Photo(
        assetName: 'assets/IMG_0009.JPG',
        title: "静谧午后",
        description: "疫情期间 - 空无一人的操场",
        city: "北京市朝阳区",
        location: "三里屯",
      ),
    ];

class PhotoCardItem extends StatelessWidget {
  const PhotoCardItem({Key key, @required this.photo, this.shape})
      : assert(photo != null),
        super(key: key);

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 360.0;
  final Photo photo;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: PhotoContent(photo: photo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TappablePhotoCardItem extends StatelessWidget {
  const TappablePhotoCardItem({Key key, @required this.photo, this.shape})
      : assert(photo != null),
        super(key: key);

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 298.0;
  final Photo photo;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onTap: () => print('Card was tapped'),
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: PhotoContent(photo: photo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoContent extends StatelessWidget {
  const PhotoContent({Key key, @required this.photo})
      : assert(photo != null),
        super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5.copyWith(color: Colors.white);
    final descriptionStyle = theme.textTheme.subtitle1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 184,
          child: Stack(
            children: [
              Positioned.fill(
                child: Ink.image(
                  image: AssetImage(photo.assetName),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    photo.title,
                    style: titleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: DefaultTextStyle(
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: descriptionStyle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // This array contains the three line description on each card
                // demo.
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    photo.description,
                    style: descriptionStyle.copyWith(color: Colors.black54),
                  ),
                ),
                Text(photo.city),
                Text(photo.location),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardsDemo extends StatefulWidget {
  const CardsDemo();

  @override
  _CardsDemoState createState() => _CardsDemoState();
}

class _CardsDemoState extends State<CardsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        children: [
          for (final photo in photos(context))
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: TappablePhotoCardItem(photo: photo),
            ),
        ],
      ),
    );
  }
}
