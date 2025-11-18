import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thap/extensions/string_extensions.dart';

class TingsImage extends StatelessWidget {
  const TingsImage(
    this.imageUrl, {
    super.key,
    this.fit,
    this.height,
    this.width,
    this.cache = true,
    this.alignment = Alignment.center,
    this.colorBlendMode,
    this.color,
  });

  final String? imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final bool cache;
  final Alignment alignment;
  final BlendMode? colorBlendMode;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    if (imageUrl.isBlank) return Container();

    bool shouldCache =
        cache &&
        !imageUrl!.startsWith(
          'https://tingsapi.test.mindworks.ee/images',
        ); // Don't cache our own images for now

    if (shouldCache) {
      return CachedNetworkImage(
        fadeInDuration: const Duration(),
        fadeOutDuration: const Duration(),
        imageUrl: imageUrl!,
        fit: fit,
        alignment: alignment,
        height: height,
        width: width,
        colorBlendMode: colorBlendMode,
        color: color,
      );
    }

    return Image.network(
      imageUrl!,
      fit: fit,
      alignment: alignment,
      height: height,
      width: width,
      colorBlendMode: colorBlendMode,
      color: color,
    );
  }
}
