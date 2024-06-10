<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee"
    value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />


<jsp:include page="../../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />
<!-- include moment.js -->
<script src="/resources/assets/moment/moment-with-locales.min.js"></script> 


<!-- Content wrapper -->
<div class="content-wrapper sd-board" id="blind-board">
    
    
    <!-- Content -->
    <div class="container-xxl flex-grow-1 container-p-y ">
        <div class="title sd-point">익명게시판</div>
          
          
         <div class="sd-btn-write-area">
            <c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
              <button id="list-del-btn" class="btn-reset sd-btn sd-danger-bg">삭제</button>
            </c:if>
            
            <c:if test="${not empty loginEmployee}">
              <p class="sd-btn sd-point-bg">
                <a href="${contextPath}/board/blind/write.page">작성</a>
              </p>
            </c:if>
            
          </div>

          <div class="card sd-table-wrapper">
          

            
            <div class="table-responsive text-nowrap">
              <table class="table table-hover sd-table" id="blind-list-table">
                <thead>
                  <tr>
                    <th style="width:8%">번호</th>
                    <c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
                      <th style="width:8%">선택</th>
                    </c:if>
                    <th style="width:45%" class="blindTitle1">제목</th>
                    <th style="width:15%">작성일자</th>
                    <th style="width:10%">댓글</th>
                    <th style="width:10%">조회수</th>
                  </tr>
                </thead>
                <tbody class="table-border-bottom-0" id="blind-list">
                  
                </tbody>
              </table>
            </div>
          </div>

          
    </div>
    <!-- / Content -->
    <!-- 작성 버튼 화면 하단에 띄움 -->

    
    
</div>
  <script>

  let page = 1;
  let totalPage = 0;
  let totalItems = 0;  // 전체 항목 수
  
  userRole = '${loginEmployee.role}';
  
  const fnGetBlindList = () =>{
    $.ajax({
      type:'GET',
      url:'${contextPath}/board/blind/getBlindList.do',
      data:'page='+page,
      dataType:'json',
      success:(resData) =>{
        
        totalPage = resData.totalPage;
        totalItems = resData.totalItems;  // 전체 항목 수를 서버에서 받아
        
       // console.log("Total Items: " + totalItems)
      // 최신 글의 전체 개수를 기반으로 인덱스 부여
        let startIndex = totalItems - (page - 1) * resData.pageSize;  
       // console.log("Start Index: " + startIndex);
        //totalPage = resData.totalPage;
        
        //let lastIndex = resData.blindList.length - 1; // 최신 글의 인덱스
        
        //console.log("lastIndex:" + lastIndex)
        $.each(resData.blindList, (i, blind) => {
            
            let reversedIndex = startIndex - i; // 역순으로 된 인덱스
            //console.log("reversedIndex"+reversedIndex)
            let str = '<tr><td>' + reversedIndex + '</td>'; // 역순으로 된 인덱스 사용
            if (userRole === 'ROLE_ADMIN') {
                str += '<td><input type="checkbox" name="blindChk" data-idx="'+reversedIndex+'" value="' + blind.blindNo + '"/></td>'
            }
            // str += '<td><a href="${contextPath}/board/blind/detail.do?blindNo='+blind.blindNo+'">' +  blind.boardTitle + '</a></td>';
            str += '<td data-blind-no="'+ blind.blindNo+'"  class="blindTitle">'+  blind.boardTitle + '</td>';
            //str += '<td><a class="blindTitle" href="${contextPath}/board/blind/updateHit.do?blindNo='+blind.blindNo+'">' +  blind.boardTitle + '</a></td>';
           //${contextPath}/board/blind/updateHit.do?blindNo='+evt.target.dataset.blindNo
               
            //시간 표시
            const publishTime = moment(blind.boardCreateDt);
            const now = moment();
            const diffHours = now.diff(publishTime, 'hours');
            str += '<td class="publish-time">' + publishTime.locale('ko').fromNow() + '</td>';
            /*
            if (diffHours <= 12) {
              str += '<td class="publish-time">' + publishTime.locale('ko').fromNow() + '</td>';
            } else {
              str += '<td class="publish-time">' + publishTime.format('YYYY-MM-DD HH:mm:ss') + '</td>';
            }    
            */
              
            // str += '<td>'+blind.boardCreateDt+'</td>';
            str += '<td>'+blind.commentCount+'</td>';
            str += '<td>'+blind.hit+'</td></tr>'

            $('#blind-list').append(str);
        });
    },
      error:(jqXHR) => {
        alert(jqXHR.statusText+'('+jqXHR.status+')');
      }
    });
  }
  
  fnGetBlindList();
  
  
  // 조회수 쿠키
  // 쿠키 설정 함수
// 쿠키 설정 함수
function setCookie(name, value, days) {
    let expires = "";
    if (days) {
        let date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = encodeURIComponent(name) + "=" + encodeURIComponent(value || "") + expires + "; path=/";
}

// 쿠키 가져오기 함수
function getCookie(name) {
    let nameEQ = encodeURIComponent(name) + "=";
    let ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return decodeURIComponent(c.substring(nameEQ.length, c.length));
    }
    return null;
}

//게시글 클릭
$(document).on('click', '.blindTitle', (evt) => {
  let blindNo = evt.target.dataset.blindNo;
  let viewedNotices = getCookie('viewedNotices');

  if (!viewedNotices || !viewedNotices.split(',').includes(blindNo)) {
      // 쿠키에 해당 글 번호가 없으면 조회수 증가 및 쿠키에 추가
      setCookie('viewedNotices', viewedNotices ? viewedNotices + ',' + blindNo : blindNo, 1);

      // 조회수 증가 요청
      location.href = '${contextPath}/board/blind/updateHit.do?blindNo=' + blindNo;
  } else {
      // 조회수 증가 없이 바로 상세보기
      location.href = '${contextPath}/board/blind/detail.do?blindNo=' + blindNo;
  }
});



// 스크롤시 새로운 목록생성

const fnScrollHandler = () => {
  
  // 스크롤이 바닥에 닿으면 page 증가(최대 totalPage 까지) 후 새로운 목록 요청

  // 타이머 id (동작한 타이머의 동작 취소를 위한 변수)
  var timerId;  // undefined, boolean 의 의미로는 false
  
  $(window).on('scroll', (evt) => {

    /*
      스크롤 이벤트 발생 → setTimeout() 함수 동작 → 목록 가져옴 → setTimeout() 함수 동작 취소
    */
    
    if(timerId) {  // timerId 가 undefined 이면 false, 아니면 true 
                   // timerId 가 undefined 이면 setTimeout() 함수가 동작한 적 없음
      clearTimeout(timerId);  // setTimeout() 함수 동작을 취소함 -> 목록을 가져오지 않는다.
    }
    
    // 500밀리초(0.5초) 후에 () => {}가 동작하는 setTimeout 함수
    timerId = setTimeout(() => {
      
      let scrollTop = window.scrollY;  // $(window).scrollTop();
      let windowHeight = window.innerHeight;  // $(window).height();
      let documentHeight =  $(document).height();
      
      if( (scrollTop + windowHeight + 50) >= documentHeight ) {  // 스크롤과 바닥 사이 길이가 50px 이하인 경우 
        if(page > totalPage) {
          return;
        }
        page++;
        fnGetBlindList();
      }
      
    }, 500);
    
  })
  
}
fnScrollHandler();


const fnNoticeListDel = () =>{
  $(document).on('click','#list-del-btn',(evt)=>{

    let checked = $("input[name='blindChk']:checked");

    if(checked.length > 0){
      
      let no = [];   // 게시글 진짜 no(DB상)
      let idx = [];  // 목록상 게시글 index
      
      checked.each(function(){
        no.push($(this).val());
        idx.push($(this).data("idx"));
        console.log(checked);
      });
      
      idx.sort((a, b) => a - b);
      
       console.log("DB "+no);
       console.log("목록상"+idx);
      
      
      let msg = checked.length == 1 ? 
          idx +'번 게시글을 삭제할까요?' : 
          idx.join(",")+'번 게시글을 삭제할까요?';
      if(confirm(msg)){
        $.ajax({
          url:"${contextPath}/board/blind/removeNo.do",
          type:"POST",
          data:{no:no},
          traditional: true,
          success:function(response){
             if (response === '삭제되었습니다.') {
                // 삭제가 성공했을 때의 동작
                alert("삭제되었습니다.");
                loadNoticeList(); // 공지사항 목록 다시 불러오기 등의 동작
            } else {
                // 삭제가 실패했거나 삭제할 게시글이 없는 경우의 동작
                alert("삭제할 게시글이 없습니다.");
            }
          }
        })
      }
    }else{
      alert("삭제할 게시글을 선택하세요.");
    }
    
    function loadNoticeList(){
      location.reload();
    }
    
  })
}


fnNoticeListDel();


//삭제 후 문구 
const fnRemoveResult = () => {
  const removeResult = '${removeResult}';
  if(removeResult !== '') {
    alert(removeResult);
  }
}
fnRemoveResult();
  </script>

    <%@ include file="../../layout/footer.jsp"%>