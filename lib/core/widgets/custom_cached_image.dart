import 'package:admin_dashboard/core/widgets/custom_circle_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      height: height,
      width: width,
      placeholder:
          (context, url) => const SizedBox(
            height: 200,
            child: Center(child: CustomCircularIndicator()),
          ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
