
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee"
		value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />


<!-- Content wrapper -->
<div class="content-wrapper sd-board">
		<!-- Content -->

		<div class="container-xxl flex-grow-1 container-p-y">
				<div class="title sd-point">공지사항</div>

				<!-- Basic Layout & Basic with Icons -->
				<div class="row">
						<!-- Basic Layout -->
						<div class="col-xxl board-detail">
								<div class="card mb-4 sd-notice-detail">

										<div class="card-body">
												<div class="board-title-area">
													<div class="board-title">
														<c:if test="${notice.signal==1}">
															<span class="important badge rounded-pill bg-label-danger">중요</span>
														</c:if>
														${notice.boardTitle}
													</div>
													<div class="board-title-etc-area">
														<div class="board-title-etc">
															<p>
																	<span>${notice.employee.empName}</span>
															</p>
															<p>
																	<i class='bx bx-show'></i> <span>${notice.hit}</span>
															</p>
															<p>
																	<i class='bx bx-time-five'></i>
																	<c:if
																			test="${notice.boardCreateDt eq notice.boardModifyDt}">
																			<span>${notice.boardCreateDt}</span>
																	</c:if>
																	<c:if
																			test="${notice.boardCreateDt ne notice.boardModifyDt}">
                                      수정일자 : <span>${notice.boardModifyDt}</span>
																	</c:if>
															</p>
														</div>

														<div class="board-title-btns">
															<c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
																<form id="frm-btn" method="POST">
																	<input type="hidden" name="noticeNo"
																			value="${notice.noticeNo}">
																	<button type="button" id="btn-edit"
																			class="btn btn-warning btn-sm">편집</button>
																	<button type="button" id="btn-remove"
																			class="btn btn-danger btn-sm">삭제</button>
																</form>
															</c:if>
														</div>
															
													</div>
												</div>

												<div class="board-contents">${notice.boardContents}</div>

												<div class="attached-file-area">
														<p>
																첨부파일 <i class='bx bx-paperclip'></i>
														</p>
														<div class="list">
																<c:forEach items="${attachList}" var="attach">
																		<div class="attach"
																				data-attach-no="${attach.attachNo}">
																				${attach.originalFilename} <i class='bx bx-download'></i>
																		</div>
																</c:forEach>
																<c:if test="${empty attachList}">
																		<div>첨부 없음</div>
																</c:if>
																<c:if test="${not empty attachList}">
																		<p class="all">
																				<a id="download-all"
																						href="${contextPath}/board/notice/downloadAll.do?noticeNo=${notice.noticeNo}">
																						모두 다운로드
																				</a>
																		</p>
																</c:if>
														</div>
												</div>

												<div class="notice-list">
														<div class="sd-btn sd-point-bg">
																<a href="${contextPath}/board/notice/list.do"
																		class="notice-list-btn" style="color: white">목록</a>
														</div>
												</div>
										</div>
								</div>
						</div>
				</div>
				<!-- / Content -->
			</div>
</div>
				<script>
    
//첨부파일 다운로드
const fnDownload = () => {
  $('.attach').on('click', (evt) => {
    if (confirm('해당 첨부 파일을 다운로드 할까요?')) {
      const attachNo = $(evt.currentTarget).data('attach-no');
      location.href = '${contextPath}/board/notice/download.do?attachNo='+attachNo;
    }
  });
};


var frmBtn = document.getElementById('frm-btn');

// 수정 버튼
const fnEditUpload = () => {
  document.getElementById('btn-edit').addEventListener('click', (evt) => {
    frmBtn.action = '${contextPath}/board/notice/edit.do';
    frmBtn.submit();
  })
}
   
// 삭제 버튼
const fnRemoveUpload = () => {
  document.getElementById('btn-remove').addEventListener('click', (evt) => {
    if(confirm('해당 게시글을 삭제할까요?')){
      frmBtn.action = '${contextPath}/board/notice/removeNotice.do';
      frmBtn.submit();
    }
  })
}

//수정완료메시지
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