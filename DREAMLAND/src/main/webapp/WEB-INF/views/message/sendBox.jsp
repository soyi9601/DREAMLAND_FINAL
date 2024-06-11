<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<jsp:include page="../layout/header.jsp" /> 

            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">쪽지함 /</span> 보낸쪽지함</h4>

              
              <div class="row">
	              <!-- Hoverable Table rows -->
	              <div class="card">
	                <h5 class="card-header">보낸쪽지함 <small id="send-count"></small></h5>
	                  <form id="send-form" method="POST">
                    <div>
                      <button type="button" class="btn btn-danger" id="btn-delete">삭제하기</button>
                    </div>
	                <div class="table-responsive text-nowrap">
	                  <table class="table table-hover">
	                    <thead>
	                      <tr>
                          <th></th>
                          <th>받는사람</th>
                          <th>쪽지내용</th>
                          <th>받은시간</th>
                          <th>읽음여부</th>
	                      </tr>
	                    </thead>
                        <tbody class="table-border-bottom-0" id="send-list">
                          <c:if test="${empty sendList}">
                            <tr>
                              <td colspan="4">보낸 쪽지함이 없습니다</td>
                            </tr>
                          </c:if>
                          <c:if test="${not empty sendList}">
                            <c:forEach items="${sendList}" var="send" varStatus="vs">
                              <tr>
                                <td><input class="form-check-input" type="checkbox" value="${send.msgNo}" id="star-no" name="checkYn"/></td>
                                <td>${send.receiverName}</td>
                                <td><a href="${contextPath}/user/msgSendDetail?msgNo=${send.msgNo}">${send.msgContents}</a></td>
                                <td>${send.msgCreateDt}</td>
                                <td>
															    <c:if test="${send.readYn == 'Y'}">
														        읽음
															    </c:if>
															    <c:if test="${send.readYn == 'N'}">
														        안읽음
															    </c:if>
																</td>
                              </tr>
                            </c:forEach>
                          </c:if>
                        </tbody>
	                  </table>
	                  <input class="form-emp-no" type="hidden" value="${loginEmployee.empNo}" id="empNo" name="empNo"/>  
				            <div class="tab-content">
                     <nav aria-label="Page navigation">
                         <ul class="pagination justify-content-center">${paging}</ul>
                       </nav>
                       </div>
			                </div>
			                </form>
			              </div>
					              <!--/ Hoverable Table rows -->
                   </div>
                                           
                 </div>
               



            <!-- / Content -->
<script>var empNo = '${loginEmployee.empNo}';</script>
<script src="/resources/assets/js/pages-sendbox.js"></script>
<%@ include file="../layout/footer.jsp" %>
