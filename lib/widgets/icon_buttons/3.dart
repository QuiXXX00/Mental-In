import 'package:flutter/material.dart';
import '../../utils/colors2.dart';
import '../../utils/fonts.dart';

class RecommendationImage extends StatelessWidget {
  const RecommendationImage({
    super.key,
    required this.text,
    required this.imageUrl,
  });

  final String text;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      height: 95,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        image: DecorationImage(image: AssetImage(imageUrl)),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 63, bottom: 5),
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 85,
          height: 27,
          decoration: ShapeDecoration(
            color: Color(0x54131313),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: SizedBox(
              width: 74,
              child: Text(
                text,
                style: AppFonts.font8w700,
              )),
        ),
      ),
    );
  }
}
