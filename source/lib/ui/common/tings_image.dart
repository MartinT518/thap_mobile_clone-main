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
      // Performance optimization: Calculate memory cache dimensions
      // Limit memory usage by decoding images at appropriate size
      int? memCacheWidth;
      int? memCacheHeight;
      
      if (width != null && height != null) {
        // For fixed dimensions, use them directly (accounting for device pixel ratio)
        memCacheWidth = (width! * 2).round(); // 2x for high-DPI screens
        memCacheHeight = (height! * 2).round();
      } else if (width != null) {
        memCacheWidth = (width! * 2).round();
      } else if (height != null) {
        memCacheHeight = (height! * 2).round();
      } else {
        // Default: limit to 600px width for thumbnails/grid items
        memCacheWidth = 600;
      }

      return CachedNetworkImage(
        fadeInDuration: const Duration(),
        fadeOutDuration: const Duration(),
        imageUrl: imageUrl!,
        fit: fit,
        alignment: alignment,
        height: height,
        width: width,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        colorBlendMode: colorBlendMode,
        color: color,
        errorWidget: (context, url, error) {
          // Gracefully handle network errors (e.g., DNS failures, timeouts)
          // Show a placeholder icon instead of breaking the UI
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: Icon(
              Icons.image_not_supported,
              size: (width != null && height != null)
                  ? (width! < height! ? width! * 0.4 : height! * 0.4)
                  : 48,
              color: Colors.grey[400],
            ),
          );
        },
        placeholder: (context, url) {
          // Show loading indicator while image loads
          return Container(
            width: width,
            height: height,
            color: Colors.grey[100],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      );
    }

    return Image.network(
      imageUrl!,
      fit: fit,
      alignment: alignment,
      height: height,
      width: width,
      cacheWidth: width != null ? (width! * 2).round() : 600,
      cacheHeight: height != null ? (height! * 2).round() : null,
      colorBlendMode: colorBlendMode,
      color: color,
      errorBuilder: (context, error, stackTrace) {
        // Gracefully handle network errors (e.g., DNS failures, timeouts)
        // Show a placeholder icon instead of breaking the UI
        return Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: Icon(
            Icons.image_not_supported,
            size: (width != null && height != null)
                ? (width! < height! ? width! * 0.4 : height! * 0.4)
                : 48,
            color: Colors.grey[400],
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        // Show loading indicator while image loads
        if (loadingProgress == null) {
          return child;
        }
        return Container(
          width: width,
          height: height,
          color: Colors.grey[100],
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    );
  }
}
