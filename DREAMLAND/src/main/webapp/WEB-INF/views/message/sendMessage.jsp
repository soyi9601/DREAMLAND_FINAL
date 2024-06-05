<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<jsp:include page="../layout/message-header.jsp" /> 
<link rel="stylesheet" href="/resources/assets/css/message.css" />

            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">쪽지함 /</span> 쪽지보내기</h4>

              
              <div class="row">
                <div class="card">
                  <h5 class="card-header">쪽지보내기</h5>
                  <form id="frm-modify-info" method="POST" action="${contextPath}/message/send.do">
                    <div class="card-body">
                    <div>
                      <button type="submit" class="btn btn-primary" id="btn-send-message">보내기</button>
                      <button type="reset" class='btn btn-secondary' id="btn-reset">초기화</button>
                      <button type="button" class='btn btn-secondary' id="btn-cancel">취소</button>
                    </div>
                      <div class="mb-3" >
                        <input type="hidden" id="sender" name="sender" value="${loginEmployee.empNo}">
                        <label for="receiver" class="form-label">받는사람</label>
                        <div id="receiver-container" class="input-container">
	                        <input
	                          type="text"
	                          class="form-control"
	                          id="receiver"
	                        />
                        </div>
                        <div id="auto-complete"></div>
                      </div>
                      <div>
                        <label for="contents" class="form-label">내용</label>
                        <textarea class="form-control" id="contents" name="contents" rows="10"></textarea>
                      </div>
                      <div>
                        <sup><span id="nowByte">0</span>/4000byte</sup>
                      </div>
                    </div>
                    </form>
                  </div>
                </div>
                </div>

            <!-- / Content -->
<script src="../assets/js/pages-send-message.js"></script>
<%@ include file="../layout/footer.jsp" %>
