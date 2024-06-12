<!-- notie/list.jsp -->
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
<link rel="stylesheet" href="/resources/assets/vendor/fonts/boxicons.css" />
<!-- include moment.js -->
<script src="/resources/assets/moment/moment-with-locales.min.js"></script>

<!-- Content wrapper -->
<div class="content-wrapper sd-board" id="notice-board">
    <!-- Content -->

    <div class="container-xxl flex-grow-1 container-p-y">
      <div class="title sd-point">공지사항</div>
        
      <!-- Hoverable Table rows -->
      <div class="card sd-table-wrapper">
        <div class="table-responsive text-nowrap">
          <table class="table table-hover sd-table">
            <thead>
              <tr>
                <th>번호</th>
                <c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
                  <th>선택</th>
                </c:if>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일자</th>
                <th>조회수</th>
              </tr>
            </thead>
            <tbody class="table-border-bottom-0">
              <c:forEach items="${noticeBoardList}" var="notice" varStatus="vs">
                <tr>
                  <td>
                    <i class="fab fa-angular fa-lg text-danger me-3"></i>
                    ${beginNo - vs.index}
                  </td>
                  <c:if test="${loginEmployee.role eq 'ROLE_ADMIN'}">
                    <td><input type="checkbox" name="noticeChk" value="${notice.noticeNo}" data-idx="${beginNo - vs.index}"/></td>
                  </c:if>
                  <td data-notice-no="${notice.noticeNo}" class="noticeTitle">
                    <span data-notice-no="${notice.noticeNo}" class="noticeTitle">
                      <c:if test="${notice.signal eq 1}">
	                      <span class="important badge rounded-pill bg-label-danger" data-notice-no="${notice.noticeNo}" >
	                        중요
	                      </span>
	                    </c:if>
                    ${notice.boardTitle}
                      <c:if test="${notice.attachCount!=0}">
	                      <i class='bx bxs-file' data-notice-no="${notice.noticeNo}" ></i>
	                    </c:if>
                    </span> 
                  </td>
                  <td>${notice.employee.empName}</td>
                  <td>${notice.boardCreateDt }</td>
                  <td>${notice.hit}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
      <!--/ Hoverable Table rows -->
      
      <div class="sd-btns-area">
        <div>
          <c:if test="${loginEmployee.role eq 'ROLE_ADMIN'}">
            <button id="list-edit-btn" class="btn-reset sd-btn sd-gray-bg">편집</button>
            <button id="list-del-btn" class="btn-reset sd-btn sd-danger-bg">삭제</button>
          </c:if>
        </div>
        <c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
	        <div class="btn-reset sd-btn sd-point-bg" >
	          <a href="${contextPath}/board/notice/write.page">작성</a>
	        </div>
	      </c:if>
      </div>
      
      <div class="pagination">${paging}</div>
      <!-- 
      <div class="pg-btn-area">${paging}</div>-->
      
  </div>
    <!-- / Content -->
</div>


<script>

// 조회수
const fnNoticeDetail = () =>{
  $(document).on('click', '.noticeTitle', (evt)=>{
    //관리자의 경우, 조회수 증가 X
    if(${loginEmployee.empNo}===1 ){
      location.href = '${contextPath}/board/notice/detail.do?noticeNo='+evt.target.dataset.noticeNo;
    }else{
      //관리자가 아닌 경우 조회수 증가 O
      location.href = '${contextPath}/board/notice/updateHit.do?noticeNo='+evt.target.dataset.noticeNo;
    }
  })
}

// list목록 체크박스-편집
const fnNoticeListEdit = () =>{
  $(document).on('click','#list-edit-btn', (evt)=>{
    let checked = $("input[name='noticeChk']:checked");
    if(checked.length == 1){
      let noticeNo = checked.val();
      let form = $('<form action="${contextPath}/board/notice/edit.do" method="post">' +
                    '<input type="hidden" name="noticeNo" value="'+noticeNo + '"></input>'+'</form>');
      $('body').append(form);
      form.submit();
    }else{
      alert("편집할 게시글을 하나만 선택하세요");
    }
  })
}


// list목록 체크박스-삭제
const fnNoticeListDel = () =>{
  $(document).on('click','#list-del-btn',(evt)=>{

    let checked = $("input[name='noticeChk']:checked");
    
    if(checked.length > 0){
      
      let no = [];   // 게시글 진짜 no(DB상)
      let idx = [];  // 목록상 게시글 index
      
      checked.each(function(){
        no.push($(this).val());
        idx.push($(this).data("idx"));
      });
      
      //게시글 거꾸로 나와서 제대로 나오게
      idx.sort((a, b) => a - b);
      
      let msg = checked.length == 1 ? 
          idx+'번 게시글을 삭제할까요?' : 
          idx.join(",")+'번 게시글을 삭제할까요?';
      if(confirm(msg)){
        $.ajax({
          url:"${contextPath}/board/notice/removeNo.do",
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

//삭제 후 메시지
const fnRemoveResult = () => {
  const removeResult = '${removeResult}';
  if(removeResult !== '') {
    alert(removeResult);
  }
}

//함수목록
fnNoticeDetail();
fnNoticeListEdit();
fnNoticeListDel();
fnRemoveResult();

</script>

<%@ include file="../../layout/footer.jsp"%>