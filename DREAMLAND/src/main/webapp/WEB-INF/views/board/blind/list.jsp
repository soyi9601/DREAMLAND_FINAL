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
                            <th style="width: 8%">번호</th>
                            <c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
                                <th style="width: 8%">선택</th>
                            </c:if>
                            <th style="width: 45%" class="blindTitle1">제목</th>
                            <th style="width: 15%">작성일자</th>
                            <th style="width: 10%">댓글</th>
                            <th style="width: 10%">조회수</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0" id="blind-list">
                      
                    
                      <!-- 게시글 목록 ajax로 불러옴 -->
                    </tbody>
                </table>
                <div class="loadingArea">
                  <div class="loading">
                    <span></span>
                    <span></span>
                    <span></span>
                  </div>
                </div>
            </div>
        </div>
        
        <div class="fixed-btn-area">
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
		    </div>
        
    </div>
    
   

    <!-- / Content -->
</div>


<script>

const fnGetBlindHotList = () =>{
  $.ajax({
    type:'GET',
    url:'${contextPath}/board/blind/getBlindHotList.do',
    data:'page='+page,
    dataType:'json',
    success:(resData) =>{
      
      $.each(resData.blindHotList, (i,blindHot) => {
      
        //시간 표시
        const publishTime = moment(blindHot.boardCreateDt);
        const now = moment();
        const diffHours = now.diff(publishTime, 'hours');

        let str = '<tr>';
        str += '<td></td>';
        
        if (userRole === 'ROLE_ADMIN') {
          str += '<td></td>'
        }
        
        if (diffHours <= 24) {
          str += '<td data-blind-no="'+blindHot.blindNo+'" class="blindTitle"><span class="new rounded-pill bg-label-success">new</span><span class="new rounded-pill bg-label-danger">hot</span>'+blindHot.boardTitle+'</td>';
        }else {
          str += '<td data-blind-no="'+blindHot.blindNo+'" class="blindTitle"><span class="new rounded-pill bg-label-danger">hot</span>'+blindHot.boardTitle+'</td>';
          }
        
        str += '<td class="publish-time">' + publishTime.locale('ko').fromNow() + '</td>';
        str += '<td>'+blindHot.commentCount+'</td>';
        str += '<td>'+blindHot.hit+'</td>'
        
          $('#blind-list').append(str);
      }) //each끝
      
    }, //success끝
    error:(jqXHR) => {
      alert(jqXHR.statusText+'('+jqXHR.status+')');
    }
  })//ajax끝
}//함수끝

  
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
      totalItems = resData.totalItems;  // 전체 항목 수를 서버에서 받음
      
      if(totalItems < 16){
        $('.loadingArea').hide();
      }
      
      // 최신 글의 전체 개수를 기반으로 인덱스 부여
      let startIndex = totalItems - (page - 1) * resData.pageSize;    

      $.each(resData.blindList, (i, blind) => {
        
         let reversedIndex = startIndex - i;
        
        //본인삭제시, 완전삭제X , 삭제된 게시글 남겨둠 
        if(blind.delYn==='Y'){
          let context = '<tr><td>'+reversedIndex+'</td>';
          
          if (userRole === 'ROLE_ADMIN') {
            context += '<td><input type="checkbox" name="blindChk" data-idx="'+reversedIndex+'" value="' + blind.blindNo + '"/></td>'
          }
          context += '<td colspan="4" style="text-align:left;padding-left:20px;font-style:italic;">삭제된 게시글입니다.</td></tr>'
          $('#blind-list').append(context);
          return; 
        }
          
        let context = '';
        let str = '';
        str = '<tr><td>' + reversedIndex + '</td>'; 
            
          if (userRole === 'ROLE_ADMIN') {
            str += '<td><input type="checkbox" name="blindChk" data-idx="'+reversedIndex+'" value="' + blind.blindNo + '"/></td>'
          }
        
        //시간 표시
        const publishTime = moment(blind.boardCreateDt);
        const now = moment();
        const diffHours = now.diff(publishTime, 'hours');
        
        let titleClass = "";
        
        if(diffHours <= 24 && blind.commentCount >= 5) {
          // 24시간 이내면서 댓글수가 5개 이상인 경우
          str += '<td data-blind-no="'+ blind.blindNo+'" class="blindTitle"><span class="new rounded-pill bg-label-success">new</span><span class="new rounded-pill bg-label-danger">hot</span>'+  blind.boardTitle + '</td>';
        } else if(diffHours <= 24){
           str += '<td data-blind-no="'+ blind.blindNo+'"  class="blindTitle"><span class="new rounded-pill bg-label-success">new</span>'+  blind.boardTitle + '</td>';
        }else if(blind.commentCount >= 5) {
          // 댓글수가 5개 이상인 경우
          str += '<td data-blind-no="'+ blind.blindNo+'" class="blindTitle"><span class="new rounded-pill bg-label-danger">hot</span>'+  blind.boardTitle + '</td>';
        }else{
           str += '<td data-blind-no="'+ blind.blindNo+'"  class="blindTitle">'+  blind.boardTitle + '</td>';
        }
        str += '<td class="publish-time">' + publishTime.locale('ko').fromNow() + '</td>';
        str += '<td>'+blind.commentCount+'</td>';
        str += '<td>'+blind.hit+'</td></tr>'
        
        context += str;
        $('#blind-list').append(context);
        
      });
     
  },
    error:(jqXHR) => {
      alert(jqXHR.statusText+'('+jqXHR.status+')');
    }
  });
}
  
//스크롤시 목록생성
const fnScrollHandler = () => {
  $('.loadingArea').show(); //로딩화면 
  
  var timerId;  
  
  $(window).on('scroll', (evt) => {
    
    if(timerId) { 
      clearTimeout(timerId);
    }
    
    timerId = setTimeout(() => {
      
      let scrollTop = window.scrollY;  
      let windowHeight = window.innerHeight;  
      let documentHeight =  $(document).height();
      
      if( (scrollTop + windowHeight + 50) >= documentHeight ) { 
        if(page > totalPage) {
          return;
        }
        page++;
        fnGetBlindList();
        $('.loadingArea').hide();
        
      }else{
        
      }
    }, 500);
  })
}  


let fixedBtn =$('.fixed-btn-area');

// 스크롤시 작성삭제버튼 보이게 
$(window).scroll(function(){
	if($(this).scrollTop()>200){
		fixedBtn.fadeIn('slow');
	}else{
		fixedBtn.fadeOut('slow');
	}
})

  
// 조회수 쿠키 설정함수
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

      // 조회수 증가 
      location.href = '${contextPath}/board/blind/updateHit.do?blindNo=' + blindNo;
  } else {
      // 조회수 증가 없이 바로 상세보기
      location.href = '${contextPath}/board/blind/detail.do?blindNo=' + blindNo;
  }
});

// list목록페이지에서 체크박스이용해서 게시글 삭제 
const fnNoticeListDel = () =>{
  $(document).on('click','#list-del-btn',(evt)=>{

    let checked = $("input[name='blindChk']:checked");

    if(checked.length > 0){
      let no = [];   // 게시글 진짜 no(DB상)
      let idx = [];  // 목록상 게시글 index
      checked.each(function(){
        no.push($(this).val());
        idx.push($(this).data("idx"));
      });
      
      idx.sort((a, b) => a - b);
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


//삭제 후 문구 
const fnRemoveResult = () => {
  const removeResult = '${removeResult}';
  if(removeResult !== '') {
    alert(removeResult);
  }
}

fnGetBlindHotList();
fnGetBlindList();
fnScrollHandler();
fnNoticeListDel();
fnRemoveResult();




</script>

<%@ include file="../../layout/footer.jsp"%>