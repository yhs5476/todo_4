// 필요한 패키지 및 모듈 가져오기
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase 기능 사용을 위한 패키지
import 'package:get/get.dart'; // GetX 상태 관리 및 라우팅 라이브러리
import 'package:get_storage/get_storage.dart'; // 로컬 스토리지 관리 패키지
import 'package:todo/services/auth_service.dart'; // 사용자 인증 서비스
import 'package:todo/services/theme_services.dart'; // 테마 관리 서비스
import 'package:todo/ui/theme.dart'; // 앱 테마 설정
import 'package:todo/ui/pages/login_page.dart'; // 로그인 페이지
import 'package:todo/controllers/script_controller.dart'; // 스크립트 컨트롤러

// 내부 모듈 임포트
import 'firebase_options.dart'; // Firebase 설정 옵션

// 앱 실행의 진입점
void main() async {
  // Flutter 위젯 바인딩 초기화 - Flutter 엔진과 위젯 레이어 연결
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화 - 인증, 데이터베이스 등의 Firebase 서비스 사용 준비
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // GetStorage 초기화 - GetX의 로컬 스토리지 접근 준비
  await GetStorage.init();

  // GetX의 의존성 주입(Dependency Injection) 시스템 활용
  // Get.put()을 사용하여 앱 전체에서 접근 가능한 서비스 인스턴스 등록
  // 이렇게 등록된 서비스는 Get.find<ServiceType>()로 어디서든 접근 가능
  Get.put(AuthService()); // 인증 서비스 등록
  Get.put(ScriptController()); // 스크립트 컨트롤러 등록

  // 앱 시작
  runApp(const MyApp());
}

// 애플리케이션의 루트 위젯 - 앱의 기본 구조와 테마 설정
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GetMaterialApp: GetX의 네비게이션, 라우팅, 상태 관리 기능을 활용하기 위한 MaterialApp 확장 위젯
    // 일반 MaterialApp 대신 사용하여 GetX의 모든 기능(라우팅, 스낵바, 다이얼로그, 바텀시트 등)을 활용 가능
    return GetMaterialApp(
      // 라이트 테마 설정 - 밝은 모드일 때 사용할 테마
      theme: Themes.light,

      // 다크 테마 설정 - 어두운 모드일 때 사용할 테마
      darkTheme: Themes.dark,

      // 현재 사용할 테마 모드 결정 (시스템, 라이트, 다크)
      // ThemeServices 클래스에서 GetX의 반응형 상태 관리를 통해 테마 변경 시 UI 자동 업데이트
      themeMode: ThemeServices().theme,

      // 앱 이름 설정
      title: '할 일 관리',

      // 디버그 표시 배너 숨기기
      debugShowCheckedModeBanner: false,

      // 시작 화면으로 로그인 페이지 설정
      // GetX 라우팅 시스템에서 초기 화면 설정
      // 이후 Get.to(), Get.off(), Get.offAll() 등의 네비게이션 메소드로 화면 전환 가능
      home: const LoginPage(),
    );
  }
}
