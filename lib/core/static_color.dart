import 'package:flutter/material.dart';

class StaticColors {
  static const Color black1 = Color(0xFF25282B);
  static const Color black2 = Color(0xFF52575C);
  static const Color black3 = Color(0xFFA0A4A8);
  static const Color black4 = Color(0xFFCACCCF);
  static const Color black5 = Color(0xFFE8E8E8);
  static const Color black6 = Color(0xFFFAFAFA);
  static const Color greyLight = Color(0xFFEBEBEB);
  static const Color red = Color(0xFFFF6160);
  static const Color blue = Color(0xFF2F9CF1);
  static const Color orange = Color(0xFFF2994A);
  static const Color greySubTitle = Color(0xFF999999);
  static const Color green = Color(0xFF44AB4A);
  static const Color badgeColor = Color(0xFF2C2C2E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFFB7BDCA);
  static const Color blueDark = Color(0xFF354570);
  static const Color errorOutOfStock = Color(0xFFFF3333);
  static const Color errorColor = Color(0xFFED7662);
  static const Color appColor = Color(0xFF03174C);
  static const Color darkBlue = Color(0xFF202E5B);
  static const Color subGray = Color(0xFF9A9BA6);
  static const Color subTitleColorDisableDark = Color(0xFF718096);
  static const Color subTitleColorDisableLight = Color(0xFFA0AEC0);
  static const Color subTitleColorLight = Color(0xFFFFFFFF);
  static const Color subTitleColorDark = Color(0xFFFFFFFF);
  static const Color dividerColorLight = Color(0xFFB9C1D9);
  static const Color dividerColorDark = Color(0xFF718096);
  static const Color subTitleColorPrimaryLight = Color(0xFF12788F);
  static const Color subTitleColorPrimaryDark = Color(0xFF137E89);
  static const Color purple = Color(0xFF8E97FD);
  static const Color keyPad = Color(0xFF082539);
  static const Color cancelGray = Color(0xFFC4C4C4);
  static const Color priceGray = Color(0xFFA9A9A9);
  static const Color subTitleColor = Color(0x3C3C4399);
  static const Color inactiveIcon = Color(0xFFA1A4B2);
  static const Color activeIcon = Color(0xFFEF5858);
  static const Color actionColor = Color(0xFFFFFFFF);
  static const Color colorIconStar = Color(0xFFF5B63F);
  static const Color colorSkip = Color(0xFFB3B9C9);
  static const Color colorSup = Color(0xFFD1D1D6);
  static const Color bgSetting = Color(0x33F2F1FF);
  static const Color borderGray = Color(0xFFDDDDDD);
  static const Color titleColor = Color(0xFF0D0B26);
  static const Color bgColor = Color(0xFFF2F1FF);
  static const Color disableBtn = Color(0xFFA4A4B1);
  static const Color bgGray2 = Color(0xFFE0E2EE);
  static const Color dividerColor = Color(0xFFF2F2F2);
  static const Color liveBg = Color(0x9903174C);
  static const Color descColor = Color(0xFFAAAAAA);
  static const Color cardGreen = Color(0xFF50BE87);
  static const Color cardPink = Color(0xFFFFB4E6);
  static const Color cardBlue = Color(0xFF4BB4E6);
  static const Color cardPurple = Color(0xFFA885D8);
  static const Color pink = Color(0xFFFDEEEE);
  static const Color grayPrice = Color(0xFF8A8A8F);
  static const Color nextBg = Color(0xFFF6F6F6);
  static const Color colorBg = Color(0xFFD8D8D8);
  static const Color liveBtn = Color(0x8003174C);
  static const Color gray5 = Color(0xFFC5CEE0);
  static const Color gray6 = Color(0xFFF1F2F7);
  static const Color blue4 = Color(0xFF363853);
  static const Color blue3 = Color(0xB803174C);
  static const Color gray9 = Color(0xFF9D9DA8);
  static const Color red3 = Color(0xFFFF3333);
  static const LinearGradient linearGradient = LinearGradient(colors: [
    gradient1,
    gradient2,
  ]);
  static const LinearGradient linearGradientBlack = LinearGradient(
    colors: [
      gradientBlack1,
      gradientBlack2,
    ],
  );

  static getSubTitleColor(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return lightMode ? subTitleColorLight : subTitleColorDark;
  }

  static getCardColor(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return lightMode ? Colors.white : const Color(0xFF314048);
  }

  static getSubTitleDisabledColor(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return lightMode ? subTitleColorDisableLight : subTitleColorDisableDark;
  }

  static getDividerColor(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return lightMode ? dividerColorLight : dividerColorDark;
  }

  static getSubTitleColorPrimary(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return lightMode ? subTitleColorPrimaryLight : subTitleColorPrimaryDark;
  }

  static baseColorLoadingIndicator(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return lightMode ? subTitleColorLight : subTitleColorDark;
  }

  //Gradient
  static const Color gradient1 = StaticColors.activeIcon;
  static const Color gradient2 = Color(0xFFFFBABA);
  static const Color gradient5 = Color(0xFFFFD9D9);
  static const Color gradient4 = Color(0x78FD6969);
  static const Color gradient3 = Color(0x4DEF5858);
  static const Color gradientBlack1 = Color(0x00000000);
  static const Color gradientBlack2 = Color(0x80000000);
  static const Color gradientTag = Color(0x80363740);
  static const Color gradientName = Color(0xB3FFFFFF);
  static const Color gray8 = Color(0x33FFFFFF);
  static const Color gradientWhite1 = Color(0x00ffffff);
  static const Color gradientWhite2 = Color(0xA3FFFFFF);
  static const Color live2 = Color(0x0003174c);
  static const Color dialogBg = Color(0x8A000000);
}
