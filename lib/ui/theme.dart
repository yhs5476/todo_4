import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color brownishClr = Color(0xd5e8bc4e); // 갈색 계열 색상
const Color orangeClr = Color(0xCFFF8746); // 주황 계열 색상
const Color pinkClr = Color(0xFFff4667); // 분홍 계열 색상
const Color white = Colors.white; // 흰색
const primaryClr = brownishClr; // 기본 색상
const Color darkGreyClr = Color(0xFF121212); // 어두운 회색
const Color darkHeaderClr = Color(0xFF424242); // 어두운 헤더 색상

// 앱의 라이트/다크 테마를 정의하는 클래스
class Themes {
    // 라이트 모드 테마
  static final light = ThemeData(
    primaryColor: primaryClr,
    // ignore: deprecated_member_use
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
  );

    // 다크 모드 테마
  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    // ignore: deprecated_member_use
    scaffoldBackgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

// 제목 텍스트 스타일 (예: 페이지 제목)
TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ));
}

// 부제목 텍스트 스타일
TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ));
}

// 일반 제목 텍스트 스타일 (예: 카드 제목)
TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ));
}

// 일반 부제목 텍스트 스타일
TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ));
}

// 본문 텍스트 스타일
TextStyle get bodyStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ));
}

// 두 번째 본문 텍스트 스타일 (예: 약간 흐린 텍스트)
TextStyle get body2Style {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.grey : Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ));
}
