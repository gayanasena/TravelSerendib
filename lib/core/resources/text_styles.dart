import 'package:flutter/material.dart';
import 'package:travelapp/core/resources/colors.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  late TextStyle appBarText = TextStyle(
    fontFamily: 'graphik_medium_500',
    fontSize: 20,
    color: ApplicationColors(context).black,
  );

  late TextStyle snackBarText = TextStyle(
    fontFamily: 'graphik_semibold_600',
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    color: ApplicationColors(context).white,
  );

  late TextStyle homeScreenUserNameText = TextStyle(
    fontFamily: 'graphik_regular_400',
    color: ApplicationColors(context).black,
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
  );

  late TextStyle homeCarouselHeaderText = TextStyle(
    fontFamily: 'graphik_regular_600',
    color: ApplicationColors(context).black,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
  );
}
