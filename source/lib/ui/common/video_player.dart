import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/tings_image.dart';
import 'package:thap/ui/common/typography.dart';

class VideoPreviewLink extends HookWidget {
  const VideoPreviewLink({
    super.key,
    this.previewImage,
    this.title,
    required this.videoUrl,
  });
  final String? previewImage;
  final String? title;
  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    final openerService = locator<OpenerService>();

    final previewImageInternal = useState(previewImage);

    useEffect(
      () {
        var isYoutubeVideo = videoUrl.contains(RegExp(r'youtu.?be'));

        if (isYoutubeVideo && previewImage.isBlank) {
          previewImageInternal.value = _getYoutubeThumbnail(videoUrl);
        }
        return null;
      },
      [
        [previewImage, videoUrl],
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: TingsColors.white,
          child: InkWell(
            onTap: () {
              openerService.openInternalBrowser(videoUrl);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (previewImageInternal.value.isNotBlank)
                  TingsImage(
                    previewImageInternal.value,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    color: TingsColors.black.withOpacity(0.3),
                    colorBlendMode: BlendMode.darken,
                  )
                else
                  Container(height: 180, color: TingsColors.grayMedium),
                const TingIcon(
                  'play-circle',
                  height: 68,
                  color: TingsColors.white,
                ),
                if (title.isNotBlank)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 32,
                      padding: const EdgeInsets.all(16.0),
                      child: ContentBig(
                        title!,
                        color: TingsColors.white,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? _getYoutubeThumbnail(String videoUrl) {
  final videoId = _extractYoutubeVideoId(videoUrl);

  if (videoId.isBlank) return null;

  return 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
}

String? _extractYoutubeVideoId(String videoUrl) {
  for (var exp in [
    RegExp(
      r'^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$',
    ),
    RegExp(
      r'^https:\/\/(?:music\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$',
    ),
    RegExp(r'^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$'),
  ]) {
    Match? match = exp.firstMatch(videoUrl);
    if (match != null && match.groupCount >= 1) return match.group(1);
  }

  return null;
}
