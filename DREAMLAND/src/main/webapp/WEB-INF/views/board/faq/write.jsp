<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<jsp:include page="../../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />


<!-- Content wrapper -->
<div class="content-wrapper sd-board" id="faq-write">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
    <div class="title sd-point">FAQ 작성</div>

    <!-- Basic Layout & Basic with Icons -->
    <div class="row">
      <!-- Basic Layout -->
      <div class="col-xxl">
        <div class="card mb-4">
          
          <div class="card-body">
            <!-- Form 시작 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
            <form id="frm-faq-register" method="POST"
              action="${contextPath}/board/faq/registerFaq.do">
              <div class="row mb-3">
                <input type="hidden" name="empNo" value="${loginEmployee.empNo}">
                <label class="col-sm-2 col-form-label" for="basic-default-name">FAQ 제목</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="basic-default-name" 
                    placeholder="제목을 입력해주세요. Q칸에 들어갈 부분입니다." name="boardTitle" />
                </div>
              </div>
              <div class="row mb-3">
                <label for="defaultSelect" class="form-label col-sm-2" name="category"> 분류 </label>

                <div class="col-sm-10">
                  <select id="defaultSelect" class="form-select col-sm-10"
                    name="category">
                    <option value="">분류는 필수 선택사항입니다.</option>
                    <option value="1">인사</option>
                    <option value="2">경영지원</option>
                    <option value="3">안전관리</option>
                    <option value="4">시설운영</option>
                    <option value="5">마케팅</option>
                    <option value="6">기타</option>
                  </select>
                </div>
              </div>

              <div class="row mb-3">
                <label class="col-sm-2 col-form-label"
                  for="basic-default-message">답변</label>
                <div class="col-sm-10">
                  <textarea id="basic-default-message" class="form-control"
                    placeholder="A칸에 들어갈 부분입니다.답변을 입력해주세요."
                    aria-label="Hi, Do you have a moment to talk Joe?"
                    aria-describedby="basic-icon-default-message2"
                    name="boardContents"></textarea>
                </div>
              </div>
              <div class="row btn-area">
                <button type="submit" class="btn-reset sd-btn sd-point-bg">작성</button>
                <button type="button" class="btn-reset sd-btn sd-point-bg" style="margin-left:7px;">
                  <a href="${contextPath}/board/faq/list.do">목록</a>
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- / Content -->
</div>

<script>


/* 등록 필수*/
const fnRegister = () =>{
	document.getElementById('frm-faq-register').addEventListener('submit', (e) => {
		
	  let inpTitle= document.getElementById('basic-default-name');
	  let title = inpTitle.value;
		
		if(document.getElementById('basic-default-name').value === '') {
      alert('제목은 필수입니다.');
      e.preventDefault();
      return;
    }
		
		// 글자수제한
		if(title.length > 30){
      e.preventDefault();
      alert('제목의 글자수는 30자 이내로 설정해주십시오');
		}
			
		if(document.getElementById('defaultSelect').value === '') {
			alert('분류는 필수선택입니다.')
			e.preventDefault();
			return;
		}
		
    if(document.getElementById('basic-default-message').value === '') {
      alert('답변을 입력해주세요.');
      e.preventDefault();
      return;
    }

	})
}
  
  
fnRegister();

  
</script>

<%@ include file="../../layout/footer.jsp"%>

