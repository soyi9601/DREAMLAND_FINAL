<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />

<!-- 이미지 경로 확인 -->
<c:set var="signPath" value="${loginEmployee.signPath}"/>
<c:set var="profilePath" value="${loginEmployee.profilePath}"/>
<c:if test="${signPath == null}">
   <c:set var="signPath" value="../assets/img/logo/logo2.png" />
</c:if>
<c:if test="${profilePath == null}">
   <c:set var="profilePath" value="../assets/img/user-solid.png" />
</c:if>

<jsp:include page="../layout/header.jsp" /> 


          <!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">설정 / 마이페이지 /</span> 비밀번호변경</h4>

              <div class="row">
                <div class="col-md-12">
                  <div class="card mb-4">
                    <h5 class="card-header">비밀번호 변경</h5>
                    
                    <!-- Account -->
                    <form id="frm-modify-password" method="POST" action="${contextPath}/user/modifyPassword.do">
                    <div class="card-body">
                      <div class="row">
                         <div class="mb-3 col-md-12">
                           <label for="now-password" class="form-label">현재 비밀번호</label>
                           <input
                             class="form-control"
                             type="password"
                             id="now-password"
                             name="currentPw"
                             maxlength="30"
                           />
                         </div>
                         <div class="mb-3 col-md-12">
                           <label for="new-password" class="form-label">새로운 비밀번호</label>
                           <input
                             class="form-control"
                             type="password"
                             id="new-password"
                             name="newPw"
                             maxlength="30"
                             placeholder="비밀번호 4~12자, 영문/숫자/특수문자 중 2개 이상 포함"
                           />
                           <div id="new-password-result"></div>
                         </div>
                         <div class="mb-3 col-md-12">
                           <label for="new-password2" class="form-label">새로운 비밀번호 확인</label>
                           <input
                             class="form-control"
                             type="password"
                             id="new-password2"
                             maxlength="30"
                           />
                           <div id="password-check-result"></div>
                         </div>
                   </div>
 
                   <hr class="my-0" />
                   <div class="card-body">
                       <div class="mt-2">
                         <button type="submit" class="btn btn-primary me-2">변경</button>
                         <button type="reset" class="btn btn-outline-secondary">취소</button>
                         </div>
                       </div>
                   </div>
                     </form>
                   
                   <!-- /Account -->
                 </div>
               </div>
             </div>
           </div>
           </div>
           <!-- / Content -->
<script src="../assets/js/pages-modify-password.js"></script>
<%@ include file="../layout/footer.jsp" %>
    