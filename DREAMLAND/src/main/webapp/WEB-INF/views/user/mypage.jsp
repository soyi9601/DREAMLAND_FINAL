<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<!-- 이미지 경로 확인 -->
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
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">설정 /</span> 마이페이지</h4>

              <div class="row">
                <div class="col-md-12">
                  <div class="card mb-4">
                    <h5 class="card-header">정보수정 - 이미지 수정 후 반드시 저장을 눌러주세요.</h5>
                    
                    <!-- Account -->
                    <form id="frm-modify-info" method="POST" action="${contextPath}/user/modify.do" enctype="multipart/form-data">
                    <div class="card-body">
                      <div class="d-flex align-items-start align-items-sm-center gap-4">
						            <img
						                src="${profilePath}" 
						                alt="user-avatar"
						                class="d-block rounded"
						                height="100"
						                width="100"
						                id="uploadedAvatar"
						            />
                        <input
                          type="text"
                          id="beforeProfilePath"
                          name="beforeProfilePath"
                          class="form-control"
                          hidden
                          value="${loginEmployee.profilePath}"
                        />
                        <div class="button-wrapper">
                          <label for="profilePath" class="btn btn-primary me-2 mb-4" tabindex="0">
                            <span class="d-none d-sm-block">사진등록</span>
                            <i class="bx bx-upload d-block d-sm-none"></i>
                            <input
                              type="file"
                              id="profilePath"
                              name="profilePath"
                              class="account-file-input"
                              hidden
                              accept="image/png, image/jpeg, image/gif"
                            />
                          </label>
                          <button type="button" class="btn btn-outline-secondary account-image-reset mb-4">
                            <i class="bx bx-reset d-block d-sm-none"></i>
                            <span class="d-none d-sm-block">초기화</span>
                          </button>
                          <p class="text-muted mb-0">JPG, GIF, PNG 가능. 최대 800KB</p>
                        </div>
                      </div>

                   </div>
                   <hr class="my-0" />
                   <div class="card-body">
                     
                       <div class="row">
                         <div class="mb-3 col-md-6">
                           <label for="empName" class="form-label">이름</label>
                           <input
                             class="form-control"
                             type="text"
                             id="emp-name"
                             name="empName"
                             value="${loginEmployee.empName}" 
                             oninput="fnCheckName()"
                           />
	                         <div id="name-result"></div>
                         </div>
                         <div class="mb-3 col-md-6">
                           <label for="birth" class="form-label">생년월일</label>
                           <input
                             class="form-control"
                             type="date"
                             id="birth"
                             name="birth"
                             value="${loginEmployee.birth}"
                           />
                         </div>
                         <div class="mb-3 col-md-6">
                           <label class="form-label" for="mobile">휴대전화</label>
                             <input
                               type="tel"
                               id="emp-mobile"
                               name="mobile"
                               class="form-control"
                               value="${loginEmployee.mobile}"
                               oninput="fnCheckMobile()"
                             />
	                         <div id="result-mobile"></div>
                         </div>
                         <div class="mb-3 col-md-6">
                           <label for="email" class="form-label">E-mail</label>
                           <input
                             class="form-control"
                             type="text"
                             id="email"
                             name="email"
                             value="${loginEmployee.email}"
                             placeholder="example@example.com"
                             readOnly
                           />
                         </div>
                         <div class="mb-3 col-md-3">
                           <label class="form-label" for="deptNo">소속부서</label>
                            <input
                             class="form-control"
                             type="text"
                             id="deptName"
                             name="deptName"
                             value="<c:choose><c:when test="${fn:startsWith(emp.deptNo, '5')}">시설관리</c:when><c:otherwise>${emp.deptName}[${emp.deptNo}]</c:otherwise></c:choose>"
                             readOnly
                           />
                            <input
                             class="form-control"
                             type="hidden"
                             id="deptNo"
                             name="deptNo"
                             value="${loginEmployee.deptNo}"
                           />
                         </div>
                         <div class="mb-3 col-md-3">
                           <label class="form-label" for="deptNo">세부소속</label>
                            <input
                             class="form-control"
                             type="text"
                             id="deptDetailName"
                             name="deptDetailName"
                             value="<c:choose><c:when test="${fn:startsWith(emp.deptNo, '5')}">${emp.deptName}[${emp.deptNo}]</c:when><c:otherwise></c:otherwise></c:choose>"
                             readOnly
                           />
                         </div>
                         <div class="mb-3 col-md-6">
                           <label for="posNo" class="form-label">직급</label>
                             <input
                             class="form-control"
                             type="text"
                             id="posName"
                             name="posName"
                             value="${emp.posName}"
                             readOnly
                           />
                           <input
                             class="form-control"
                             type="hidden"
                             id="posNo"
                             name="posNo"
                             value="${loginEmployee.posNo}"
                           />
                         </div>
                         <div class="mb-3 col-md-6">
                           <label class="form-label" for="deptNo">입사일</label>
                            <input
                             class="form-control"
                             type="date"
                             id="enterDate"
                             name="enterDate"
                             value="${loginEmployee.enterDate}"
                             readOnly
                           />
                         </div>
                         <div class="mb-3 col-md-6">
                         </div>
                    <div class="mb-3 col-md-2">
                      <label for="postcode" class="form-label">우편번호</label>
                      <input type="text" id="postcode" name="postcode" class="form-control" value="${loginEmployee.postcode}" readOnly>
                    </div>
                    <div class="mb-3 col-md-10" style="display:flex;flex-direction: column;">
                      <label for="postcode" class="form-label" style="color:transparent"> ddd</label>
                      <input type="button" onclick="fnExecDaumPostcode()" class="btn btn-primary me-2" value="우편번호 찾기" 
                        style="width:130px;">
                    </div>
                      <div class="mb-3 col-md-5">
                        <label for="address" class="form-label">주소</label>
                        <input type="text" id="address" name="address" class="form-control" placeholder="주소" value="${loginEmployee.address}">
                      </div>
                      <div class="mb-3 col-md-7">
                        <label for="detailAddress" class="form-label">상세주소</label>
                        <input type="text" id="detailAddress" name="detailAddress" class="form-control" placeholder="상세주소" value="${loginEmployee.detailAddress}">
                      </div>
                    </div>
                  
                  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                   <hr class="my-0" />
                   <div class="pt-4">
                       <div class="mt-2">
                         <button type="submit" class="btn btn-primary me-2">저장</button>
                         <button type="button" class="btn btn-warning me-2" id="modify-password" >비밀번호변경</button>
                         <button type="reset" class="btn btn-outline-secondary" id="move-before">취소</button>
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

<script src="../assets/js/pages-account-mypage.js"></script>
<%@ include file="../layout/footer.jsp" %>
    