<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<jsp:include page="../layout/header.jsp" /> 
<link rel="stylesheet" href="/resources/assets/css/message.css" />

            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">쪽지함 /</span> 답장보내기</h4>

              
              <div class="row">
                <div class="card">
                  <form id="frm-reply-message" method="POST" action="${contextPath}/message/send.do">
                    <div class="card-header">
                      <div class="send-btns-area"> 
                        <button type="submit" class="btn btn-primary" id="btn-send-message">보내기</button>
                        <div>
                          <button type="reset" class='btn btn-secondary' id="btn-reset">초기화</button>
                          <button type="button" class='btn btn-outline-secondary' id="btn-cancel">취소</button>
                        </div>
                      </div>
                    </div>
                    <div class="card-body">
                    <div class="row mb-3" >
                        <div class=""></div>
                        <input type="hidden" id="sender" name="sender" value="${loginEmployee.empNo}">
                        <label for="receiver" class="col-sm-2 form-label">받는사람</label>
                        <div id="receiver-container" class="col-sm-9 input-container">
                          <button type="button" class="btn btn-coutline-secondary">"${sender.empName}[${sender.deptName}-${sender.posName}]"</button>
	                        <input type="hidden" id="receiver" name="receiver" value="${sender.empNo}">
                        </div>
                        <div id="auto-complete"></div>
                      </div>
                      <div>
                        <label for="contents" class="form-label">내용</label>
                        <textarea class="form-control" id="contents" name="contents" rows="5"></textarea>
                      </div>
                      <div>
                        <sup><span id="nowByte">0</span> / 1000자</sup>
                      </div>
                    </div>
                    </form>
                  </div>
                </div>
                </div>

            <!-- / Content -->
<script src="../assets/js/pages-reply-message.js"></script>
<%@ include file="../layout/footer.jsp" %>
