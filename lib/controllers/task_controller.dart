import 'package:get/get.dart'; // GetX 상태 관리 라이브러리 임포트
import 'package:intl/intl.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

/// TaskController: GetX 상태 관리를 위한 컨트롤러 클래스
/// GetxController를 상속받아 GetX의 상태 관리 기능을 활용
/// 할 일 목록의 CRUD 작업과 상태 관리를 담당
class TaskController extends GetxController {
  /// taskList: 할 일 목록을 저장하는 Observable 리스트 (RxList)
  /// .obs 확장자를 사용하여 반응형(reactive) 상태로 만들어 UI가 자동으로 업데이트되도록 함
  final RxList<Task> taskList = <Task>[].obs;
  
  /// selectedDate: 현재 선택된 날짜를 추적하는 Observable 변수 (Rx)
  /// DateTime 객체를 .obs로 래핑하여 반응형 상태로 만듦
  /// 이 값이 변경되면 이 값을 사용하는 모든 UI 요소가 자동으로 업데이트됨
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  /// 할 일 추가 메소드
  /// GetX의 상태 관리: 데이터베이스에 작업 추가 후 taskList를 갱신하여 UI 자동 업데이트
  Future<int> addTask({Task? task}) async {
    int result = await DBHelper.insert(task);
    await getTasks(); // 작업 추가 후 목록 갱신 - taskList.obs가 업데이트되어 UI도 자동 갱신됨
    return result;
  }

  /// 모든 할 일 목록 조회 메소드
  /// GetX의 상태 관리: taskList.assignAll()을 사용하여 Observable 리스트 갱신
  /// 이 메소드가 호출되면 taskList가 업데이트되고, 이를 사용하는 모든 UI가 자동으로 갱신됨
  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }
  
  /// 특정 날짜의 할일만 가져오는 메소드
  /// GetX의 상태 관리:
  /// 1. selectedDate.value로 Observable 변수 값 변경 - 이 값을 사용하는 모든 UI 요소가 자동 갱신됨
  /// 2. taskList.assignAll()로 Observable 리스트 갱신 - 목록을 표시하는 UI가 자동으로 업데이트됨
  Future<void> getTasksByDate(DateTime date) async {
    // 날짜 형식 변환 (yMd)
    String formattedDate = DateFormat.yMd().format(date);
    
    // 선택된 날짜 업데이트 - Rx 변수의 .value 속성으로 값 변경
    selectedDate.value = date;
    
    // DB에서 해당 날짜의 할일 가져오기
    final List<Map<String, dynamic>> tasks = await DBHelper.queryByDate(formattedDate);
    // Observable 리스트 갱신 - UI 자동 업데이트
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
    
    print('필터링된 할일 개수: ${taskList.length}');
  }

  /// 특정 할 일 삭제 메소드
  /// GetX의 상태 관리: 삭제 후 getTasks()를 호출하여 taskList Observable을 갱신하고 UI 자동 업데이트
  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks(); // Observable 리스트 갱신을 위해 getTasks 호출
  }

  /// 모든 할 일 삭제 메소드
  /// GetX의 상태 관리: 모든 작업 삭제 후 getTasks()로 taskList Observable 갱신 및 UI 자동 업데이트
  void deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks(); // Observable 리스트 갱신을 위해 getTasks 호출
  }

  /// 할 일을 완료 상태로 표시하는 메소드
  /// GetX의 상태 관리: 작업 상태 변경 후 getTasks()로 taskList Observable 갱신 및 UI 자동 업데이트
  void markTaskAsCompleted(int id) async {
    await DBHelper.update(id);
    getTasks(); // Observable 리스트 갱신을 위해 getTasks 호출
  }
}
