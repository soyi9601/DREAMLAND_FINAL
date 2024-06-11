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
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">쪽지함 /</span> 휴지통</h4>

              
              <div class="row">
	              <!-- Hoverable Table rows -->
	              <div class="card">
	                <h5 class="card-header">휴지통 <small id="delete-count"></small></h5>
	                <div class="table-responsive text-nowrap">
	                  <table class="table table-hover">
	                    <thead>
	                      <tr>
	                        <th><input class="form-check-input" type="checkbox" id="check-all"/></th>
	                        <th>보낸사람</th>
	                        <th>쪽지내용</th>
	                        <th>보낸시간</th>
	                      </tr>
	                    </thead>
                        <tbody class="table-border-bottom-0" id="receive-list">
                          <c:if test="${empty deleteList}">
                            <tr>
                              <td colspan="4">휴지통이 비었습니다</td>
                            </tr>
                          </c:if>
                          <c:if test="${not empty deleteList}">
                            <c:forEach items="${deleteList}" var="delete" varStatus="vs">
                              <tr>
                                <td><input class="form-check-input" type="checkbox" value="${delete.msgNo}" id="restore-no" name="deleteYn"/></td>
                                  <c:choose>
                                      <c:when test="${delete.readYn == 'Y'}">
                                          <td style="color: lightgray;">${delete.senderName}</td>
                                          <td style="color: lightgray;">${delete.msgContents}</td>
                                          <td style="color: lightgray;">${delete.msgCreateDt}</td>
                                      </c:when>
                                      <c:otherwise>
                                          <td>${delete.senderName}</td>
                                          <td>${delete.msgContents}</td>
                                          <td>${delete.msgCreateDt}</td>
                                      </c:otherwise>
                                  </c:choose>
                              </tr>
                            </c:forEach>
                          </c:if>
                        </tbody>
	                  </table>
                    <div class="tab-content">
                     <nav aria-label="Page navigation">
                         <ul class="pagination justify-content-center">${paging}</ul>
                       </nav>
                       </div>
			                </div>
			              </div>
					              <!--/ Hoverable Table rows -->
                   </div>
                   <small>휴지통에 있는 쪽지들은 30일 후에 자동으로 삭제됩니다.</small>          
                 </div>
               



            <!-- / Content -->
<script>var empNo = '${loginEmployee.empNo}';</script>
<script src="/resources/assets/js/pages-removebox.js"></script>
<%@ include file="../layout/footer.jsp" %>

