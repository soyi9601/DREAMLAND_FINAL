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
<div class="content-wrapper sd-board" id="faq-edit">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
    <div class="title sd-point">FAQ 수정</div>

    <!-- Basic Layout & Basic with Icons -->
    <div class="row">
      <!-- Basic Layout -->
      <div class="col-xxl">
        <div class="card mb-4">
         
          <div class="card-body">
            <!-- Form 시작 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
            <form id="frm-faq-register" method="POST"
              action="${contextPath}/board/faq/modify.do">
              <input class="faqno" name="faqNo" type="hidden"
                value="${faq.faqNo}">
              <div class="row mb-3">
                <label class="col-sm-2 col-form-label" for="basic-default-name">FAQ 제목</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="basic-default-name"
                    name="boardTitle" value="${faq.boardTitle}">
                </div>
              </div>
              <div class="row mb-3">
                <label for="defaultSelect" class="form-label col-sm-2"
                  name="category"> 분류 </label>
                <div class="col-sm-10">
                  <select id="defaultSelect" class="form-select col-sm-10"
                    name="category">
                    <option value="${faq.category}">
                      <c:if test="${faq.category==1}">인사</c:if>
                      <c:if test="${faq.category==2}">경영지원</c:if>
                      <c:if test="${faq.category==3}">안전관리</c:if>
                      <c:if test="${faq.category==4}">시설운영</c:if>
                      <c:if test="${faq.category==5}">마케팅</c:if>
                      <c:if test="${faq.category==6}">기타</c:if>
                    </option>
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
                    aria-label="Hi, Do you have a moment to talk Joe?"
                    aria-describedby="basic-icon-default-message2"
                    name="boardContents">${faq.boardContents}</textarea>
                </div>
              </div>
              <div class="row justify-content-end">
                <input type="hidden" name="userNo"
                  value="${sessionScope.user.userNo}">
                <button type="submit" class="btn-reset sd-btn sd-point-bg">수정</button>
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

/* 필수*/
const fnRegister = () =>{
  document.getElementById('frm-faq-register').addEventListener('submit', (e) => {
    
    if(document.getElementById('basic-default-name').value === '') {
      alert('제목은 필수입니다.');
      e.preventDefault();
      return;
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
