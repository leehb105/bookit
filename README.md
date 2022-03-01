# README.md

## Book It!
중고 도서 거래 및 회원 간 대여를 할 수 있는 웹 서비스입니다.

### 서비스 이용 방법
회원 가입 후 자신의 도서를 등록하여 이웃 주민에게 대여해주거나 대여를 할 수 있습니다.
도서 정보는 알라딘을 통해 자동으로 가져옵니다.

## 서버 구축 시 할 것
### 결제시스템 이용 방법

1. [아이엠포트](https://www.iamport.kr/) 가입
2. [관리자 콘솔](https://admin.iamport.kr/users/login)로 로그인
3. [시스템 설정](https://admin.iamport.kr/settings#tab_pg)의 PG설정(일반 결제 및 정기결제) 탭에서 아래 와 같이 설정
![iamport 그림](/guide/image1.png)
4. 같은 페이지의 [내정보](https://admin.iamport.kr/settings#tab_profile)탭에서 가맹점 식별코드, REST API 키, REST API secret을 복사하여 
[datasource.properties](/src/main/resources/)와 같은  경로에 iamport.properties라는 파일명으로 다음과 같은 형식으로 작성
```properties
iamport.uid=impXXXXXXXX
iamport.apiKey=XXXXXXXXXXXXXXXX
iamport.apiSecret=XXXXXXXXXXXXXXXXX......
```

### 카카오 지도 이용 방법
1. [카카오 디벨로퍼](https://developers.kakao.com/console/app)에 가입 후 애플리케이션 추가하기
2. 조금 전 추가한 앱을 선택 후 앱 키 항목에서 Javascript 키를 복사하여 기존의 지도를 사용하는 .jsp 파일에 찾아가(memberEnroll.jsp, editProfile.jsp 등) appkey='기존의 앱키'를 대체해줍니다.
3. 마지막으로 내 애플리케이션 > 앱 설정 > 플랫폼에서 아래 그림처럼 필요에 따라 도메인을 변경하여 등록해줍니다.
   ![kakao지도 그림](/guide/image2.png)
