<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/sd_css.css" />
<!-- Content wrapper -->
<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="fw-bold py-3 mb-4">
      <span class="text-muted fw-light">Forms/</span> Horizontal Layouts
    </h4>

    <!-- Basic Layout & Basic with Icons -->
    <div class="row">
      <!-- Basic Layout -->
      <div class="col-xxl">
        <div class="card mb-4">
          <div
            class="card-header d-flex align-items-center justify-content-between">
            <h5 class="mb-0">Basic Layout</h5>
            <small class="text-muted float-end">Default label</small>
          </div>
          <div class="card-body">
            <!-- Form 시작 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
            <form id="frm-faq-register" method="POST"
              action="${contextPath}/board/faq/modify.do">
              <input class="faqno" name="faqNo" type="hidden"
                value="${faq.faqNo}">
              <div class="row mb-3">
                <label class="col-sm-2 col-form-label" for="basic-default-name">질문제목</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="basic-default-name"
                    placeholder="제목을 입력해주세요. Q란에 들어갈 부분입니다." name="boardTitle"
                    /
                             value="${faq.boardTitle}">
                </div>
              </div>
              <div class="row mb-3">
                <label for="defaultSelect" class="form-label col-sm-2"
                  name="category"> 분류 </label>
                <div class="col-sm-10">
                  <select id="defaultSelect" class="form-select col-sm-10"
                    name="category">
                    <option>${faq.category}</option>
                    <option value="1">인사</option>
                    <option value="2">경영지원</option>
                    <option value="3">안전관리</option>
                    <option value="4">시설운영</option>
                    <option value="5">마케팅</option>
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
                <div class="col-sm-10">
                  <input type="hidden" name="userNo"
                    value="${sessionScope.user.userNo}">
                  <button type="submit" class="btn btn-primary"></button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>


    </div>
  </div>
  <!-- / Content -->

<%@ include file="../../layout/footer.jsp"%>
