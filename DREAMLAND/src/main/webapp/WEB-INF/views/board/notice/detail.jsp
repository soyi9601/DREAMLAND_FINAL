<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />


<!-- Content wrapper -->
<div class="content-wrapper">
		<!-- Content -->

		<div class="container-xxl flex-grow-1 container-p-y">
				<div class="sd-title sd-point">공지사항</div>

				<!-- Basic Layout & Basic with Icons -->
				<div class="row">
						<!-- Basic Layout -->
						<div class="col-xxl">
								<div class="card mb-4 sd-notice-detail">

										<div class="card-body">
												<!-- Form 시작 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
												<form id="frm-faq-register" method="POST"
														enctype="multipart/form-data"
														action="${contextPath}/board/notice/registerNotice.do">
														<div class="row mb-3">
																<input type="hidden" name="empNo"
																		value="${loginEmployee.empNo}"> <label
																		class="col-sm-2 col-form-label"
																		for="basic-default-name">제목</label>
																<div class="col-sm-10">
																		${notice.boardTitle}
																</div>
														</div>
														<div class="row mb-3">
																<label class="col-sm-2 col-form-label">체크</label>
														</div>
														<div class="row mb-3">
																<label class="col-sm-2 col-form-label"
																		for="basic-default-name">작성자</label>
																<div class="col-sm-10">
																		${notice.employee.empName}
																</div>
														</div>
														
														<div class="row mb-3">
																<label class="col-sm-2 col-form-label"
																		for="basic-default-name">조회수</label>
																<div class="col-sm-10">
																		${notice.hit}
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
																	  	<c:if test="${not empty attachList}">
																	  		<a id="download-all" href="${contextPath}/board/notice/downloadAll.do?noticeNo=${notice.noticeNo}">모두 다운로드</a>
																	  	</c:if>
																    </div>
																</div>
														</div>
														
														
														<div class="row mb-3">
																<label class="col-sm-2 col-form-label"
																		for="basic-default-message"></label>
																<div class="col-sm-10">
																		${notice.boardContents }
																</div>
														</div>
													
												</form>
												
										</div>
								</div>
						</div>


				</div>
		</div>
		<!-- / Content -->

		<script>
		
//첨부파일 다운로드
/*
const fnDownload = () => {
  $('.bx-download').on('click', (evt) => {
    if(confirm('해당 첨부 파일을 다운로드 할까요?')) {
      location.href = '${contextPath}/board/notice/download.do?attachNo=' + $(evt.currentTarget).parent().dataset.attachNo;
    }
  })
}
*/
const fnDownload = () => {
  $('.bx-download').on('click', (evt) => {
    if (confirm('해당 첨부 파일을 다운로드 할까요?')) {
      const attachNo = $(evt.currentTarget).parent().data('attach-no');
      // alert(attachNo);
      location.href = '${contextPath}/board/notice/download.do?attachNo='+attachNo;
    }
  });
};





		var frmBtn = document.getElementById('frm-btn');

		const fnEditUpload = () => {
		  document.getElementById('btn-edit').addEventListener('click', (evt) => {
		    frmBtn.action = '${contextPath}/board/notice/edit.do';
		    frmBtn.submit();
		  })
		}
		
		const fnRemoveUpload = () => {
		  document.getElementById('btn-remove').addEventListener('click', (evt) => {
		    if(confirm('해당 게시글을 삭제할까요?')){
		      frmBtn.action = '${contextPath}/board/notice/removeNotice.do';
		      frmBtn.submit();
		    }
		  })
		}
		
		
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

		<%@ include file="../../layout/footer.jsp"%>