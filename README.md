## GDJ77 Final Project - 놀이공원 그룹웨어 프로젝트(DREAMLAND)
---


### 프로젝트 개요

이 프로젝트는 구디아카데미에서 진행한 파이널 프로젝트로 **드림랜드**라는 놀이공원에서 사용될 그룹웨어 설계 및 개발하는 것에 중점을 두었습니다.
<br/>
그룹웨어의 기능으로는 관리자가 부여한 사원정보를 토대로 결재, 쪽지 보내기, 조직도 확인, 일정 확인이 가능합니다.

<br/>

#### 구성원
+ 이소이 [https://github.com/soyi9601]
+ 박모빈 [https://github.com/mobin1015]
+ 신동우 [https://github.com/ted4010]
+ 고은정 [https://github.com/2unjung94]
+ 강산들 [https://github.com/san-deul]
+ 민수지 [https://github.com/qqsuzy]


#### 사용기술

+ **프론트엔드**: HTML5, CSS, JS, jQuery, Bootstrap, JSTree
+ **API**: FullCalendar API, OpenWeatherMap API
+ **백엔드**: Java, Spring Boot Framework, Mybatis Framework
+ **데이터베이스**: Oracle SQL Developer
+ **서버**: Tomcat
+ **버전관리**: Git, GitHub
+ **협업**: Slack

#### 담당 기능 구현
```
메인페이지와 조직/인사 관리, 조직도 기능을 구현했습니다.
```

<br/>

+ 메인 페이지 <br/>

```
1. 로그인한 사원 정보 표시
2. 출근 / 퇴근 근태 시간 입력
3. openweather API를 이용한 현재 날씨 표시
4. FullCalendar API 달력 표시
5. Ajax를 이용한 공지사항, 결재 페이지 이동
```
![main_user](https://github.com/user-attachments/assets/a7e765ee-f094-435f-a166-556c9efbfbc3)

<br>

+ 유저 조직도 <br/>

```
1. OrgChart 를 이용하여 유저가 확인하는 조직도 구현
```
![depart_user](https://github.com/user-attachments/assets/f332d709-b2a2-4059-a7fc-443da75f84f0)

<br>

+ 관리자 부서 등록 / 인사, 부서 관리 <br/>

```
1. jsTree 를 이용하여 사원들 표시
2. 동일 페이지에서 부서명, 부서번호, 소속부서 변경
```

![depart_admin](https://github.com/user-attachments/assets/a15eaa02-6400-4d72-ab5e-f18dd10a54c9)


#### 제작 기간

2024년 5월 7일부터 2024년 6월 19일까지, 총 6주간 진행되었습니다.
