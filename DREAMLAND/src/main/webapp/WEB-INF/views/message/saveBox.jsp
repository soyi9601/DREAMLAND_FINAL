<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<jsp:include page="../layout/message-header.jsp" /> 

            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">쪽지함 /</span> 중요보관함</h4>

              
              <div class="row">
	              <!-- Hoverable Table rows -->
	              <div class="card">
	                <h5 class="card-header">중요보관함</h5>
                  <div class="table-responsive text-nowrap">
                    <table class="table table-hover">
                      <thead>
                        <tr>
                          <th></th>
                          <th>번호</th>
                          <th>쪽지내용</th>
                          <th>받은시간</th>
                          <th>보낸사람</th>
                        </tr>
                      </thead>

                        <tbody class="table-border-bottom-0" id="receive-list">
                          <c:if test="${empty saveList}">
                            <tr>
                              <td colspan="5">받은 쪽지함이 없습니다</td>
                            </tr>
                          </c:if>
                          <c:if test="${not empty saveList}">
                            <c:forEach items="${saveList}" var="save" varStatus="vs">
                              <tr>
                                <td><input class="form-check-input" type="checkbox" value="${save.msgNo}" id="star-no" name="starYn"/></td>
                                <td>${beginNo - vs.index}</td>
                                <td><a href="${contextPath}/user/msgRecDetail?msgNo=${save.msgNo}">${save.msgContents}</a></td>
                                <td>${save.msgCreateDt}</td>
                                <td>${save.senderName}</td>
                              </tr>
                            </c:forEach>
                          </c:if>
                        </tbody>
                    </table>
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
<!-- <script src="../assets/js/pages-account-mypage.js"></script> -->
<%@ include file="../layout/footer.jsp" %>
