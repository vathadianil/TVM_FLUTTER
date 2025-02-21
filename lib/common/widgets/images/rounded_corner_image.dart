import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RoundedCornerImage extends StatelessWidget {
  const RoundedCornerImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = true,
    this.onPressed,
    this.applyBoxShadow = false,
    this.boxShadowColor,
    this.borderRadius = TSizes.md,
    this.blurRadius = TSizes.md,
    this.applyImageColor = false,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final bool? applyBoxShadow;
  final Color? boxShadowColor;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final double blurRadius;
  final bool applyImageColor;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: border,
            color: backgroundColor,
            boxShadow: applyBoxShadow!
                ? [
                    BoxShadow(
                      color: boxShadowColor != null
                          ? boxShadowColor!
                          : TColors.accent,
                      blurRadius: blurRadius,
                    )
                  ]
                : []),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Center(
            child: isNetworkImage
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: fit,
                    placeholder: (context, url) => ShimmerEffect(
                      width: double.infinity,
                      height: 155,
                      radius: borderRadius,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image(
                    color: applyImageColor
                        ? dark
                            ? TColors.light
                            : TColors.dark
                        : null,
                    fit: fit,
                    image: AssetImage(imageUrl),
                  ),
          ),
        ),
      ),
    );
  }
}
