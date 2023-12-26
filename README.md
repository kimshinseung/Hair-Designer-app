# hairapp

- 헤어 디자이너 전용 어플 개발

## 기능 요구사항
 1. 계산기
    > 할인율 버튼을 누르면 바로 할인율이 적용가능하게(5%, 10%, 15% .. 50%)
 2. 손님들 정보 저장
       > Firebase DB이용
       >  사진, 방문날짜, 간단 메모 등
3. 검색 기능
       > 손님 성함 검색하면 저장한 정보들 볼 수 있게
4. 메인페이지 배너
       > 이벤트 등 바로 손님에게 보여주기 편하게 하기 위함.

## 디자인
 - 메인 컬러 #BD9DCF
 - 폰트 - 나눔손글씨 암스테르담


## 코드 설명

- (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.30, :
       Container의 높이를 전체화면의 30% 로 설정합니다. 높이 설정은 핸드폰 마다 화면사이즈가
       틀리기 때문에 핸드폰의 세로값을 불러와서 세로값의 30% 의 크기로 자동 생성됩니다.
-  images.insert(0,Image.asset("assets/images/home.png"))
    > 광고를 넣을때 최근에 추가한 것을 맨처음 보여주기 위한 코드

## 사용 dependencies
- image_picker: 0.6.7 sdk31버전
-   assets: 이미지 추가
    - assets/images/logo.png
    - assets/images/home.png 


## 만났던 오류

- Cannot run with sound null safety, because the following dependencies
 > 해결방법 run-> edit configuration -> additional run args에 --no-sound-null-safety입력
- 앱바의 debug 없애기
 > debugShowCheckedModeBanner: false
- ListView가 scroll이 안되는 증상
 > Container로 감싸고 height를 지정해주었다, 추가 : scrollDirection: Axis.vertical
- .dart_tool\flutter_build\277fa573f22288941d03eec5c189f5fc\kernel_snapshot.d 오류
  > flutter clean -> flutter pub get