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
<link rel="stylesheet"
		href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

<!-- Content wrapper -->
<div class="content-wrapper sd-board">
		<!-- Content -->

		<div class="container-xxl flex-grow-1 container-p-y sd-notice-write">
				<div class="title sd-point">공지사항 작성</div>

				<!-- Basic Layout & Basic with Icons -->
				<div class="row">
						<!-- Basic Layout -->
						<div class="col-xxl">
								<div class="card mb-4">

										<div class="card-body">
												<!-- Form 시작 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
												<form id="frm-notice-register" method="POST"
														enctype="multipart/form-data"
														action="${contextPath}/board/notice/registerNotice.do">
														<div class="row mb-3">
																<input type="hidden" name="empNo"
																		value="${loginEmployee.empNo}"> <label
																		class="col-sm-2 col-form-label"
																		for="basic-default-name">제목</label>

																<div class="col-sm-10">
																		<input type="text" class="form-control"
																				id="board-title" placeholder="제목을 입력해주세요."
																				name="boardTitle" />
																</div>
														</div>
														<div class="row mb-3">
																<label class="col-sm-2 col-form-label">중요</label>
																<div class="col-sm-10">
																		<input type="checkbox"
																				class="chksignal form-check-input" name="signal" />
																		<span> &nbsp; 중요한 공지사항일 시 체크해주세요</span>
																</div>
														</div>
														<div class="row mb-3">
																<label class="col-sm-2 col-form-label"
																		for="basic-default-name">작성자</label>
																<div class="col-sm-10">
																		<input type="text" class="form-control"
																				id="basic-default-name" name="empName"
																				value="${loginEmployee.empName}" readonly />
																</div>
														</div>

														<div class="row mb-3">
																<label class="col-sm-2 col-form-label"
																		for="basic-default-message">내용</label>
																<div class="col-sm-10">
																		<textarea id="basic-default-message"
																				class="form-control" placeholder="내용을 입력해주세요"
																				aria-label="Hi, Do you have a moment to talk Joe?"
																				aria-describedby="basic-icon-default-message2"
																				name="boardContents"></textarea>
																</div>
														</div>

														<div class="row mb-3 file-area">
																<p>※ 첨부파일은 최대 5개까지 가능합니다</p>
																<label for="formFileMultiple"
																		class="col-sm-2 col-form-label"> 파일첨부
																		<span class="file-add-btn">추가</span>
																</label>
																<div class="col-sm-10 notice-inputs-area">
																		<div class="notice-input-area">
																				<input class="form-control" type="file" name="files" />
																		</div>
																		<div class="notice-input-area">
																				<input class="form-control" type="file" name="files" />
																		</div>
																		<div class="notice-input-area">
																				<input class="form-control" type="file" name="files" />
																		</div>
																		<div class="notice-input-area">
																				<input class="form-control" type="file" name="files" />
																		</div>
																		<div class="notice-input-area">
																				<input class="form-control" type="file" name="files" />
																		</div>
																</div>
														</div>
														<div class="btn-area">
															<button type="submit" class="btn-reset sd-btn sd-point-bg">작성</button>
															<button type="button" class="btn-reset sd-btn sd-point-bg" style="margin-left:7px;">
                                <a href="${contextPath}/board/notice/list.do">목록</a>
                              </button>
														</div>
												</form>
										</div>
								</div>
						</div>
				</div>
		</div>
		<!-- / Content -->
</div>
<script>
    
// 제목 필수 입력
const fnRegister = () => {
	
  document.getElementById('frm-notice-register').addEventListener('submit', (evt) => {
    
  	let inpTitle= document.getElementById('board-title');
    let title = inpTitle.value;
  	
  	if(document.getElementById('board-title').value === '') {
      alert('제목은 필수입니다.');
      evt.preventDefault();
      return;
    }
    
    // 글자수제한
    if(title.length > 30){
    	evt.preventDefault();
      alert('제목의 글자수는 30자 이내로 설정해주십시오');
    }
  })
}

// 첨부파일 첨부 - 5개로 제한 , 추가누를시 input창 생김
const fnAttachAdd = () => {
  $(".file-add-btn").on('click', () => {
    const inputsArea = $(".notice-inputs-area");
    const inputCount = inputsArea.children('.notice-input-area').length;

    if (inputCount < 5) { 
      const newInputArea = $('<div class="notice-input-area"><input class="form-control" type="file" name="files" /></div>');
        inputsArea.append(newInputArea);
    } else {
        alert("더 이상 파일을 추가할 수 없습니다.");
    }
  });
}

// 첨부파일 크기 체크
const fnAttachCheck = () => {
  $(document).on('change', '.form-control', (e) => { 
    const limitPerSize = 1024 * 1024 * 10; // 10MB
    const limitTotalSize = 1024 * 1024 * 10; // 10MB
    let totalSize = 0;
    const files = e.target.files[0];

    const inputArea = $(e.target).closest(".notice-input-area");
    
    if (!inputArea.find('.del-btn').length) {
      const delBtn = $('<span class="del-btn"><span class="material-symbols-outlined">cancel</span></span>');
      inputArea.append(delBtn);
    }
    
    if (files) {
      if (files.size > limitPerSize) {
          alert('첨부파일의 최대 크기는 10MB입니다.');
          e.target.value = '';
          return;
      }
      totalSize += files.size;
    }

  });
}


// 첨부파일 input창 삭제
const fnAttachDel = () => {
  $(document).on('click', '.del-btn', (e) => {
    const inputArea = $(e.target).closest('.notice-input-area');
    inputArea.remove();
    
    const inputsArea = $(".notice-inputs-area");
    const inputCount = inputsArea.children('.notice-input-area').length;
    
    if(inputCount ==0){
      const newInputArea = $('<div class="notice-input-area"><input class="form-control" type="file" name="files" /></div>');
      inputsArea.append(newInputArea);
    }
  });
}


// 공지사항 중요 체크박스
const fnChkSig = () => {
  $('input[name="signal"]').val(0);
  $(document).on('click', '.chksignal', (e) => {
      if ($(e.target).prop('checked')) {
        $('input[name="signal"]').val(1);
      } else {
         $('input[name="signal"]').val(0); 
      }
  });
}

// 함수목록
fnRegister();
fnAttachAdd();
fnAttachCheck();
fnAttachDel();
fnChkSig();




</script>

<%@ include file="../../layout/footer.jsp"%>