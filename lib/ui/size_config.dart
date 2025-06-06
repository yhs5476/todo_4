import 'package:flutter/material.dart';

// 화면 크기 및 방향 정보를 관리하는 클래스
class SizeConfig {
    static late MediaQueryData _mediaQueryData; // 미디어 쿼리 데이터
    static late double screenWidth; // 화면 너비
    static late double screenHeight; // 화면 높이
  //static late double defaultSize;
    static Orientation? orientation; // 화면 방향 (세로 또는 가로)

    // SizeConfig를 초기화하고 화면 크기 및 방향 정보를 설정합니다.
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    print('$screenWidth');
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// 화면 크기에 비례하는 높이를 반환합니다.
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
    // 812.0은 디자이너가 사용하는 레이아웃 기준 높이입니다.
  return (inputHeight / 812.0) * screenHeight;
}

// 화면 크기에 비례하는 너비를 반환합니다.
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
    // 375.0은 디자이너가 사용하는 레이아웃 기준 너비입니다.
  return (inputWidth / 375.0) * screenWidth;
}
