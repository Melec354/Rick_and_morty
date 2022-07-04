import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PersonCacheImage extends StatelessWidget {
  final String imageUrl;
  final double width, heigth;

  const PersonCacheImage({Key? key,
    required this.imageUrl,
    required this.width,
    required this.heigth})
      : super(key: key);

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl.isNotEmpty ? imageUrl : '',
      width: width,
      height: heigth,
      imageBuilder: (context, imageProvider) {
        return _imageWidget(imageProvider);
      },
      placeholder: (context, url) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      errorWidget: (context, url, error) {
        return _imageWidget(
            AssetImage('assets/images/noimage.jpg')
        );
      },
    );
  }
}
