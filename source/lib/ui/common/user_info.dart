import 'package:flutter/material.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tings_image.dart';
import 'package:thap/ui/common/typography.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    this.backgroundColor = TingsColors.white,
    this.photoUrl,
    required this.name,
    required this.email,
  });

  final String? photoUrl;
  final String name;
  final String email;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child:
                photoUrl.isNotBlank
                    ? TingsImage(
                      photoUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                    : Image.asset(
                      'assets/dummy-profile-pic.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
          ),
          const SizedBox(height: 10),
          Heading4(name),
          ContentSmall(email),
        ],
      ),
    );
  }
}
