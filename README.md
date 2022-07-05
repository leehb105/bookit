# Bookit    
> 스프링으로 만든 회원간 도서대여 사이트     
> 가까운 동네 주민들과 원하는 책을 빌려 볼 수 있고 중고거래를 할 수 있습니다.    
> 도서 정보는 알라딘API를 통해 가져옵니다.      
> http://www.boookit.site/    

## 사용한 기술 스택     
- JAVA 8
- Spring
- Spring Security
- Oracle Cloud
- Mybatis
- Maven
- JSP    
- Tomcat 8.0

## 사용 API    
- 알라딘 도서정보    
- 인터파크 도서정보     
- 카카오 지도     
- 카카오 페이     

## 주요 기능
> 회원
- 로그인, 회원가입: 스프링 시큐리티를 통한 로그인/회원가입 구현    
- 마이페이지: 정보수정, 결제/거래내역, 게시글 작성내역, 문의/신고 내역 조회    
- 카카오지도 api를 활용하여 주소 설정  
> 도서대여              
- 가까운 동네 주민의 대여가능 도서를 조회, 대여신청         
- 도서요청게시판을 통해 원하는 도서목록 신청 
- 거래후기를 통해 회원간 평가가능      
> 도서검색
- 알라딘api를 활용해 도서 정보 조회
- 평점 및 리뷰를 작성해 회원간 리뷰 공유
> 중고거래     
- 중고 도서 거래 게시판
> 커뮤니티     
- 회원 커뮤니티 게시판 CRUD 구현
> 도서컬렉션  
- 특정 주제의 도서 목록을 회원이 직접 만들어 공유

## ERD
<details>
<summary>이미지 펼치기</summary>
<div markdown="1">
<img src="https://github.com/leehb105/bookit/blob/master/img/erd.png">
</div>
</details>
<hr>

## 서버 구축 시 할 것
### 결제시스템 이용 방법

1. [아이엠포트](https://www.iamport.kr/) 가입
2. [관리자 콘솔](https://admin.iamport.kr/users/login)로 로그인
3. [시스템 설정](https://admin.iamport.kr/settings#tab_pg)의 PG설정     
   <details>
   <summary>(일반 결제 및 정기결제) 탭에서 아래 와 같이 설정</summary>
   <div markdown="1">
   <img src="https://github.com/leehb105/bookit/blob/master/img/image1.png">
   </div>
   </details>     

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
   <details>
   <summary>이미지 열기</summary>
   <div markdown="1">
   <img src="https://github.com/leehb105/bookit/blob/master/img/image2.png">
   </div>
   </details>  
