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
- 

## 만났던 오류

- Cannot run with sound null safety, because the following dependencies
 > 해결방법 run-> edit configuration -> additional run args에 --no-sound-null-safety입력
- 앱바의 debug 없애기
 > debugShowCheckedModeBanner: false