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
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">쪽지함 /</span> 상세보기</h4>
              
              <div class="row">
                <div class="card">
                  <form id="frm-send-detail" method="POST">
                   <div class="card-header">
                    <div class="send-btns-area">
                      <div></div>
                      <div>
                        <button type="button" class="btn btn-warning" id="btn-save">보관</button>
                        <button type="button" class="btn btn-danger" id="btn-delete">삭제</button>
                      </div>
                    </div>
                  </div>
                    <div class="card-body">
                      <div class="row mb-3" >
                        <label for="receiver" class="col-sm-2 col-form-label">받는사람</label>
                        <div class="col-sm-10">
	                        <input
	                          type="text"
	                          class="form-control"
	                          id="receiver"
	                          value="${msgDetail.receiverName}[${msgDetail.receiverDeptName}-${msgDetail.receiverPosName}]"
	                          readOnly
	                        />
                        </div>
                      </div>
                      <div class="row mb-3" >
                        <label for="create-dt" class="col-sm-2 col-form-label">받은시간</label>
                        <div class="col-sm-10">
                          <input
                            type="text"
                            class="form-control"
                            id="create-dt"
                            value="${msgDetail.msgCreateDt}"
                            readOnly
                          />
                          <input class="form-emp-no" type="hidden" value="${loginEmployee.empNo}" id="empNo" name="empNo"/> 
                          <input class="form-emp-no" type="hidden" value="${msgDetail.msgNo}" id="msgNo" name="checkYn"/> 
                        </div>
                      </div>
                      <hr></hr>
                      <div class="row mb-3">
                        <pre class="font-detail">${msgDetail.msgContents}</pre>
                      </div>
                    </div>
                    </form>
                  </div>
                </div>
                </div>

            <!-- / Content -->
<script src="../assets/js/pages-send-detail.js"></script>
<%@ include file="../layout/footer.jsp" %>
