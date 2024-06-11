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
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">쪽지함 /</span> 받은쪽지함</h4>

              <div class="row">
	              <!-- Hoverable Table rows -->
	              <div class="card">
	                <h5 class="card-header">받은쪽지함 <small id="receive-count"></small></h5>
	                  <form id="frm-receive-box" method="POST">
	                  <div>
	                    <button type="button" class="btn btn-warning" id="btn-save">보관하기</button>
	                    <button type="button" class="btn btn-danger" id="btn-delete">삭제하기</button>
	                  </div>
	                <div class="table-responsive text-nowrap">
	                  <table class="table table-hover">
	                    <thead>
	                      <tr>
	                        <th><input class="form-check-input" type="checkbox" id="check-all"/></th>
	                        <th>보낸사람</th>
	                        <th>쪽지내용</th>
	                        <th>받은시간</th>
	                      </tr>
	                    </thead>

												<tbody class="table-border-bottom-0" id="receive-list">
											    <c:if test="${empty receiveList}">
										        <tr>
									            <td colspan="5">받은 쪽지함이 없습니다</td>
										        </tr>
											    </c:if>
											    <c:if test="${not empty receiveList}">
										        <c:forEach items="${receiveList}" var="receive" varStatus="vs">
									            <tr>
								                <td><input class="form-check-input" type="checkbox" value="${receive.msgNo}" name="checkYn"/></td>
											            <c:choose>
											                <c:when test="${receive.readYn == 'Y'}">
											                    <td style="color: lightgray;">${receive.senderName}</td>
											                    <td style="color: lightgray;">
											                      <a style="color: lightgray;" href="${contextPath}/user/msgRecDetail?msgNo=${receive.msgNo}">${receive.msgContents}
											                      </a>
											                    </td>
											                    <td style="color: lightgray;">${receive.msgCreateDt}</td>
											                </c:when>
											                <c:otherwise>
											                    <td>${receive.senderName}</td>
											                    <td><a href="${contextPath}/user/msgRecDetail?msgNo=${receive.msgNo}">${receive.msgContents}</a></td>
											                    <td>${receive.msgCreateDt}</td>
											                </c:otherwise>
											            </c:choose>
									            </tr>
										        </c:forEach>
											    </c:if>
										    </tbody>
                    </table>
										<input class="form-emp-no" type="hidden" value="${loginEmployee.empNo}" id="empNo" name="empNo"/>  
                    </div>
										</form>
                    <div class="tab-content">
                     <nav aria-label="Page navigation">
                         <ul class="pagination justify-content-center">${paging}</ul>
                       </nav>
                       </div>
                      </div>
                    </div>
                        <!--/ Hoverable Table rows -->
                   </div>

            <!-- / Content -->
<script>var empNo = '${loginEmployee.empNo}';</script>
<script src="/resources/assets/js/pages-receivebox.js"></script>
<%@ include file="../layout/footer.jsp" %>
