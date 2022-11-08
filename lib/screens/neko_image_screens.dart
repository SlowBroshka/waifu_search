import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waifu_searcher/api/image_category.dart';
import 'package:share_plus/share_plus.dart';

import '../model/neko_image_model.dart';

class NekoImageView extends StatelessWidget {
  const NekoImageView({super.key});

  @override
  Widget build(BuildContext context) {
    UrlModel urlModel = context.watch<UrlModel>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  urlModel.url,
                  frameBuilder: (BuildContext context, Widget child, int? frame,
                      bool wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(seconds: 4),
                      curve: Curves.easeOut,
                      child: child,
                    );
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: urlModel.url.isEmpty
                        ? null
                        : () => _onShare(context, urlModel.url),
                    child: Text('Share')),
              ),
              SizedBox(
                height: 51,
                child: ListView.builder(
                    itemCount: ImageCategory.values.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return _createUpdateImageButton(
                          urlModel, ImageCategory.values[index]);
                    }),
              ),
              SizedBox(
                height: 51,
                child: ListView.builder(
                    itemCount: GifCategory.values.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return _createUpdateGifButton(
                          urlModel, GifCategory.values[index]);
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onShare(BuildContext context, String link) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share('Share with friends',
        subject: link,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  Widget _createUpdateImageButton(UrlModel model, ImageCategory category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(100, 35),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            textStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        onPressed: () {
          model.updateImg(category);
        },
        child: Text(category.name),
      ),
    );
  }

  Widget _createUpdateGifButton(UrlModel model, GifCategory category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(100, 35),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            textStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        onPressed: () {
          model.updateGif(category);
        },
        child: Text(category.name),
      ),
    );
  }
}
