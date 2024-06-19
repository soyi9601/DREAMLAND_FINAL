<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee"
    value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../layout/header.jsp" />

<!-- link -->                                                         
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />

<Style>
	input[type="radio"] {
    pointer-events: none; /* 마우스 이벤트를 비활성화하여 클릭이 무시되도록 함 */
    cursor: not-allowed; /* 마우스 커서를 바꾸어 클릭이 불가능한 상태임을 나타냄 */
	}
	.notice-list {
		display:flex;
		justify-content: center; 
	}
	.sd-notice-detail .sd-btn1 {
		margin-left: auto;  
	}
	.sd-btn1 {
		width:70px;
		height:36px;
		border-radius:4px;
		display:flex;
    align-items:center;
    justify-content:center;
		color:#fff;
		font-size:16px;
	}
</Style>


<!-- Content wrapper -->
<div class="content-wrapper sd-board">

    <!-- Content -->

    <div class="container-xxl flex-grow-1 container-p-y">
        <div class="title sd-point">시설점검</div>

        <!-- Basic Layout & Basic with Icons -->
        <div class="row">
            <!-- Basic Layout -->
            <div class="col-xxl">
                <div class="card mb-4 sd-notice-detail">

                    <div class="card-body">
                        <!-- Form 시작 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
                        <form id="frm-faq-register" method="POST"
                            enctype="multipart/form-data"
                            action="${contextPath}/facility//register.do">
                            <div class="row mb-3">
                                <input type="hidden" name="empNo"
                                    value="${loginEmployee.empNo}"> <label
                                    class="col-sm-2 col-form-label"
                                    for="basic-default-name">시설</label>
                                <div class="col-sm-10">
                                    ${facility.facilityName}
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label"
                                    for="basic-default-name">점검일자</label>
                                <div class="col-sm-10">
                                    ${facility.facilityDate}
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label"
                                    for="basic-default-name">관리유무</label>
                                <div class="col-sm-10">
                                    <c:if test="${facility.management eq 1}">
    																	<input type="radio" checked="checked">
																		</c:if>
																		<c:if test="${facility.management eq 0}">
    																	<input type="radio">
																		</c:if>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label"
                                    for="basic-default-name">비고</label>
                                <div class="col-sm-10">
                                    ${facility.remarks}
                                </div>
                            </div>
                            

                            <div class="row mb-3">
                                <label for="formFileMultiple"
                                    class="col-sm-2 col-form-label"> 파일첨부 </label>
                                <div class="col-sm-10 notice-input-area">
                                    <c:forEach items="${attachList}" var="attach">
                                      <div class="attach"   data-attach-no="${attach.attachNo}">
                                        ${attach.originalFilename} <i class='bx bx-download'></i>
                                      </div>
                                    </c:forEach>
                                    <div>
                                      <c:if test="${empty attachList}">
                                        <div>첨부 없음</div>
                                      </c:if>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div class="notice-list">
                        <c:if test="${loginEmployee.role eq 'ROLE_MANAGER' }">
                          <form id="frm-btn" method="POST">  
                            <input type="hidden" name="facilityNo" value="${facility.facilityNo}">
                            <button type="button" id="btn-edit" class="btn btn-warning btn-sm">편집</button>
                            <button type="button" id="btn-remove" class="btn btn-danger btn-sm">삭제</button>
                          </form>
                        </c:if>
                          <div class="sd-btn1 sd-point-bg">
                            <a href="${contextPath}/facility/list.do" class="notice-list-btn" style="color:white">목록</a>
                          </div>
                        </div>
                        
                    </div>
                </div>
            </div>


        </div>
    </div>
    <!-- / Content -->

    <script>

// 파일 다운로드 처리 함수
const fnDownload = () => {
  $('.attach').on('click', (evt) => {
    if (confirm('해당 첨부 파일을 다운로드 할까요?')) {
      const attachNo = $(evt.currentTarget).data('attach-no');
      location.href = '${contextPath}/facility/download.do?attachNo='+attachNo;
    }
  });
};





    var frmBtn = document.getElementById('frm-btn');
		
 		// 수정 폼 제출 처리 함수
    const fnEditUpload = () => {
      document.getElementById('btn-edit').addEventListener('click', (evt) => {
        frmBtn.action = '${contextPath}/facility/edit.do';
        frmBtn.submit();
      })
    }
    
 		// 시설물 삭제 처리 함수
    const fnRemoveUpload = () => {
      document.getElementById('btn-remove').addEventListener('click', (evt) => {
        if(confirm('해당 게시글을 삭제할까요?')){
          frmBtn.action = '${contextPath}/facility/removeFacility.do';
          frmBtn.submit();
        }
      })
    }
    
 		// 수정 후 처리 함수
    const fnAfterModifyUpload = () => {
      const modifyResult = '${modifyResult}';
      if(modifyResult !== '') {
        alert(modifyResult);
      }
    }
  
    fnDownload();
    fnEditUpload();
    fnRemoveUpload();
    fnAfterModifyUpload();
  </script>

    <%@ include file="../layout/footer.jsp"%>