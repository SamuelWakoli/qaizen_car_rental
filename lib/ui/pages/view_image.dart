import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatefulWidget {
  const ViewImage({Key? key}) : super(key: key);

  @override
  State<ViewImage> createState() => _ViewImageState();
}

String currentImageUrl = '';

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: currentImageUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                ),
              ),
              imageBuilder: (context, imageProvider) => PhotoView(
                imageProvider: imageProvider,
              ),
              errorWidget: (context, url, error) => const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
