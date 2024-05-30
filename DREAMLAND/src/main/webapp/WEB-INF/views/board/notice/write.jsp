<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto}" />

<jsp:include page="../../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />


<!-- Content wrapper -->
<div class="content-wrapper">
		<!-- Content -->

		<div class="container-xxl flex-grow-1 container-p-y sd-notice-write">
				<div class="sd-title sd-point">공지사항 작성</div>

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
																<span>${loginEmployee.empNo} empNo임</span> <!-- 확인용 -->
																<input type="hidden" name="empNo"
																		value="${loginEmployee.empNo}"> <label
																		class="col-sm-2 col-form-label
																		for="basic-default-name">제목</label>
																		
																<div class="col-sm-10">
																		<input type="text" class="form-control"
																				id="board-title" placeholder="제목을 입력해주세요."
																				name="boardTitle" />
																</div>
														</div>
														<div class="row mb-3">
																<label class="col-sm-2 col-form-label">체크</label>
																<div class="col-sm-10">
																	<input type="checkbox" class="chksignal" name="signal"  />
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
																		for="basic-default-message">답변</label>
																<div class="col-sm-10">
																		<textarea id="basic-default-message"
																				class="form-control" placeholder="내용"
																				aria-label="Hi, Do you have a moment to talk Joe?"
																				aria-describedby="basic-icon-default-message2"
																				name="boardContents">
																		</textarea>
																</div>
														</div>

														<div class="row mb-3">
																<label for="formFileMultiple"
																		class="col-sm-2 col-form-label"> 
																	파일첨부
																	<span class="file-add-btn">추가</span>
																</label>
																<div class="col-sm-10 notice-inputs-area">
																		<div class="notice-input-area">
																			<input class="form-control" type="file" name="files"/>
																		</div>
																</div>
														</div>
														<div class="row justify-content-end">
																<div class="col-sm-10">
																		<button type="submit" class="btn btn-primary">전송</button>
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
		
// 제목 필수 입력
const fnRegister = () => {
	document.getElementById('frm-notice-register').addEventListener('submit', (evt) => {
		if(document.getElementById('board-title').value === '') {
			alert('제목은 필수입니다.');
			evt.preventDefault();
			return;
		}
		 alert( $('input[name="signal"]').val());
	})
}

// 첨부파일 첨부 - 5개로 제한 , 2개 기본, 추가 누를시 파일input창 생기게... 없앨까? 
const fnAttachAdd = () => {
  $(".file-add-btn").on('click', () => {
    const inputsArea = $(".notice-inputs-area");
    const inputCount = inputsArea.children('.notice-input-area').length;

    if (inputCount < 5) { // input 창이 5개를 넘지 않도록 제한
    	const newInputArea = $('<div class="notice-input-area"><input class="form-control" type="file" name="files" /></div>');
        inputsArea.append(newInputArea);
        if(inputCount == 4){
        	 //$(".file-add-btn").css('display', 'none');
        }
    } else {
        alert("더 이상 파일을 추가할 수 없습니다.");
    }
  });
}


const fnAttachCheck = () => {
  $(document).on('change', '.form-control', (e) => { 
    const limitPerSize = 1024 * 1024 * 10; // 10MB
    const limitTotalSize = 1024 * 1024 * 10; // 10MB
    let totalSize = 0;
    const files = e.target.files[0];

    const inputArea = $(e.target).closest(".notice-input-area");
    
    
    if (!inputArea.find('.del-btn').length) {
      const delBtn = $('<span class="del-btn">X</span>');
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

    console.log("files:  " + files);
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

	fnRegister();
	fnAttachAdd();
	fnAttachCheck();
	fnAttachDel();
	
//체크박스 상태에 따라 signal 값 설정
/*
	const setSignalValue = () => {
	    const checkbox = document.querySelector('.chksignal');
	    const signalInput = document.querySelector('input[name="signal"]');
	    
	    checkbox.addEventListener('change', function() {
	        if (this.checked) {
	            signalInput.value = 1;
	        } else {
	            signalInput.value = 0;
	        }
	    });
	}
	setSignalValue();
*/


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

fnChkSig();


/*
	// 페이지 로드 시 실행
	window.addEventListener('load', function() {
	    setSignalValue();
	});

*/




	</script>

		<%@ include file="../../layout/footer.jsp"%>