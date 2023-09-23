import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_config.dart';

class SocialCircle extends StatelessWidget {
  const SocialCircle({
    super.key,
    required this.icon,
    required this.press,
    required this.color,
  });

  final String icon;
  final dynamic press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
        ),
        padding: EdgeInsets.all(
          getProportionateScreenWidth(12),
        ),
        height: getProportionateScreenHeight(70),
        width: getProportionateScreenWidth(70),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Image.asset(icon,fit: BoxFit.fill,),
      ),
    );
  }
}
