# hairapp

- 헤어 디자이너 전용 어플 개발
- bold체로 되어있는 부분은 개발예정

## 기능 요구사항
 1. 계산기
    > 할인율 버튼을 누르면 바로 할인율이 적용가능하게(5%, 10%, 15% .. 50%)
 2. 손님들 정보 저장
       > SharedPreferences사용해서 데이터 내부저장소에 저장
       >  사진, 방문날짜, 간단 메모 등
       > 최근 방문날짜 알기위해 수정완료되면 자동으로 방문날짜 변경되게 설정
3. 검색 기능
       > 손님 이름이나 번호 검색하면 저장한 정보들 볼 수 있게
       > 글자를 쓸때마다 onChanged실행되어 글자마다 정보 띄우기
4. 메인페이지 배너
       > 이벤트 등 바로 손님에게 보여주기 편하게 하기 위함.
       > 사진 상세보기 및 삭제 추가
       > 갤러리에서 배너 추가기능
5. 스타일북
   > 각 헤어스타일별로 사진을 저장하게
    > SQFlite DB를 사용해서 데이터 저장
## 디자인
 - 메인 컬러 Color(0XffC2E1E7)
 - 폰트 - 규리의 일기체


## 코드 설명

- (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.30, :
       Container의 높이를 전체화면의 30% 로 설정합니다. 높이 설정은 핸드폰 마다 화면사이즈가
       틀리기 때문에 핸드폰의 세로값을 불러와서 세로값의 30% 의 크기로 자동 생성됩니다.
-  images.insert(0,Image.asset("assets/images/home.png"))
    > 광고를 넣을때 최근에 추가한 것을 맨처음 보여주기 위한 코드
- onTap: (){
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ImageViewer(path: images[index],)),
  );
  },
    > 클릭 시 디테일 화면으로 전환
- onChanged: (value){
  setState(() {
  name = value;
  });
  },
  > 한글자 한글자 변경이 일어날 때마다 setState를 통해 name변수에 값 저장
- 검색창에 글자를 입력하게 되면 onChanged함수가 실행되어 Overlay를 통해서 검색창 바로 밑, 화면에 중첩으로
- 검색결과를 보여지게 만들었다.
    > 검색창에 포커스가 맞춰지게 되면 'overlay'를 표시하고, 벗어나면 'overlay' 제거
- 검색창 바로 밑에 결과 나오게 하기
  > OverlayEntry의 위치 조정 필요 : CompositedTransformTarget위젯을 활용해서 'overlay'위치에 정렬
- 날짜형식 변경
    >DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
- return ListTile(
  title: ClipRRect(
  borderRadius: BorderRadius.circular(15.0), // 여기서 원하는 반경으로 조절하세요
  child: Image.file(File(imagePaths[index])),
  ),
    > 사진 테두리 동그랗게
- overflow: TextOverflow.ellipsis,
    > 문자열의 길이가 overflow가 날경우 ...으로 대체
- theme: ThemeData(fontFamily: 'gyuri'),
    > 전체 앱의 폰트를 변경


## 사용 dependencies
- image_picker: 0.6.7 sdk31버전
-   assets: 이미지 추가
    - assets/images/logo.png
    - assets/images/home.png 
- shared_preferences: ^2.0.8 사용
- intl: ^0.17.0 사용 -> DateFormat을 하는데 필요
- sqflite: ^2.2.0+2 를 사용해서 DB관리
- flutter-native-splash -> 스플래쉬 화면 만들기

## 만났던 오류

- Cannot run with sound null safety, because the following dependencies
 > 해결방법 run-> edit configuration -> additional run args에 --no-sound-null-safety입력
- 앱바의 debug 없애기
 > debugShowCheckedModeBanner: false
- ListView가 scroll이 안되는 증상
 > Container로 감싸고 height를 지정해주었다, 추가 : scrollDirection: Axis.vertical
- .dart_tool\flutter_build\277fa573f22288941d03eec5c189f5fc\kernel_snapshot.d 오류
  > flutter clean -> flutter pub get
- keyboard overflow
  > /* lib/main.dart */
  (생략)
  return Scaffold(
  resizeToAvoidBottomInset: false,
  appBar: AppBar()
  body: ~
  );
- getSharedPreferences에 데이터를 수정할때마다 이 전 데이터가 삭제되는 현상
 > indexUpdate값을 -1로 선언하고 값이 같은 데이터가 존재하면 이 값을 바꿔서 로직을 구현했다.
- *데이터를 저장하고 다시 화면으로 돌아왔을 때 데이터가 업데이트가 안되는 현상*
    > Navigator.pop(context, true)로 pop을 하고 원래 Widget에서 value == true면 데이터를 업데이트하는 함수를 실행한다.
- statefulwidget의 인자로 받은 변수를 사용하려면 widget.변수이름 으로 접근해야 한다
    > 클래스의 상태에서는 직접적으로 상위위젯의 프로퍼티에 접근하기 위해 'widget'이라는 프리픽스를 사용해야 한다.
- 이미지 형식이 안맞아서 띄우는 데 생기는 오류
    >ImageProvider을 사용해 전달하면 이미지를 전달한다.
- 텍스트가 계속 추가되면서 ListView.builder크기가 한없이 커지는 경우
    > Container와 SingleChildScrollView를 조합해서 변경
    > Container의 높이 속성을 조절하여 설정할 수 있다.

## 공부한 내용
- SQFlite : 관계형 데이터베이스 관리 시스템
  1. 서버용이 아닌 클라이언트 사이드 데이터 관리 시스템이라 비교적 가벼운 형태로 관리
  2. 장점
     1. 로컬 기반 DB로 네트워크 사용이 필요없어 비용걱정 X
     2. 휘발성데이터가 아니기에 데이터손실이 없다.
     3. 쿼리를 지원하여 복잡한 데이터를 조회할 수 있다.
  3. 단점
     1. 다른 로컬 기반의 데이터 저장 라이브러리에 비해 속도가 떨어진다.
  4. CREATE TABLE $tableImages(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imagePath TEXT,
        category TEXT
        ) 테이블 생성

## 해결해야할 문제
1. 등록부분 키보드 올라오는거(해결)
2. 전화번호 필드 추가(해결)
3. 번호뒷자리로 검색가능하게(해결)
4. 카테고리별로 사진 저장(해결)
5. 카테고리별로 맨 처음 사지만 나오게하기(해결)
6. 카테고리를 추가하게되면 다른 카테고리에 있는 사진들이 나온다. -> 아예 카테고리를 다 넣어놓을까?(해결)
7. 각 카테고리에 들어가 사진을 클릭하면 오류(해결)
8. 특징저장하게되면 그 텍스트 옆에 수정날짜(해결)
9. 처음특징을 적어넣으면 그게 저장이 안됨
10. 검색을 해서 정보를 들어가게되면 수정완료랑 뒤로 나가면 아예 팅김(해결)
    onActivityFinishing(): calling cancelLocked()
    -> Navigator.push하기전에 Navigator.pop()를 사용해서 돌아올 위젯이 없어서 오류남.
11. 검색결과창이 안없어짐 -> 백그라운드 터치 시 없애지게 하기( 해결)