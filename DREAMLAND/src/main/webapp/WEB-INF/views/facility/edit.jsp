<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee"
    value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />


<!-- Content wrapper -->
<div class="content-wrapper sd-board">

  <!-- Content -->
    <div class="container-xxl flex-grow-1 container-p-y sd-notice-edit">
        <div class="title sd-point">시설점검 편집</div>

        <!-- Basic Layout & Basic with Icons -->
        <div class="row">
            <!-- Basic Layout -->
            <div class="col-xxl">
                <div class="card mb-4">

                    <div class="card-body">
                        <!-- Form 시작 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
                      <form id="frm-facility-modify" 
                            method="POST"
                            enctype="multipart/form-data"
                            action="${contextPath}/facility/modify.do">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">시설번호</label>
                          <div class="col-sm-10 col-form-label">
                            <input type="text" class="form-control deptNo"
                                  id="basic-default-no" name="deptNo" oninput="handleOnInput(this, 4)"/>
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">시설명</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control facilityName"
                                  id="facilityName" name="facilityName" value="${facility.facilityName}" oninput="handleOnInput(this, 4)"/>
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">관리유무</label>
                          <div class="col-sm-10">
                            <input type='checkbox' class='form-check-input chkmanagement' name='management' value="${facility.management}" ${facility.management eq 1 ? 'checked' : ''} />
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">등록날짜</label>
                          <div class="col-sm-10">
                            <input type='date' class='form-control facilityDate' name='facilityDate' value="${facility.facilityDate}"/>
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label"
                              for="basic-default-message">비고</label>
                          <div class="col-sm-10">
                              <textarea id="basic-default-message"
                                  class="form-control" placeholder="비고"
                                  name="remarks" oninput="handleOnInput(this, 166)">${facility.remarks}</textarea>
                          </div>
                        </div>


                        
                        <div class="attached-file-area">
                          <p>첨부파일 <i class='bx bx-paperclip'></i></p>
                          <div id="attach-list" ></div>
                          <div class="loading">
                            <span></span>
                          </div>
                        </div>
                        
                        
                        <div class="row mb-3">
                          <label for="formFileMultiple"
                              class="col-sm-2 col-form-label"> 파일첨부
                               <span class="file-add-btn">추가</span>
                          </label>
                          <div class="col-sm-10 notice-input-area">
                             <!-- <input class="form-control" type="file" name="files" id="files" />-->
                             <div id="file-input-container"></div>
                          </div>
                          
                        </div>

                        <div class="btn-area">
                          <input type="hidden" name="delAttachList" id="delAttachList">
                          <input type="hidden" name="facilityNo" value="${facility.facilityNo}">
                          <button type="submit" id="btn-edit-submit" class="btn-reset sd-btn sd-point-bg">수정</button>
                        	<button type="button" class="btn-reset sd-btn sd-point-bg" style="margin-left:7px;">
                            <a href="${contextPath}/facility/list.do">목록</a>
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

$(".loading").hide();

let insAttachList = []; // 새로 추가될 첨부 파일 목록 배열

// 기존 첨부 파일 목록 가져오기 및 파일 입력 필드 생성
const fnAttachList = () => {
  fetch('${contextPath}/facility/attachList.do?facilityNo=${facility.facilityNo}', {
    method: 'GET'
  })
  .then(response => response.json())
  .then(resData => {
      let divAttachList = document.getElementById('attach-list');
      divAttachList.innerHTML = '';
      const attachList = resData.attachList;
      
   		// 기존 첨부 파일 목록을 HTML에 추가
      for (let i = 0; i < attachList.length; i++) {
    	  
        const attach = attachList[i];
        let str = '<div class="attach">';
        str += '<span>' + attach.originalFilename + '</span>';
        str += '<a style="margin-left: 10px;" class="remove-attach" data-attach-no="' + attach.attachNo + '"><span data-attach-no="'+attach.attachNo+'" class="material-symbols-outlined">cancel</span></a>';
        str += '</div>';
        divAttachList.innerHTML += str;
      }
      
      const fileInputContainer = document.getElementById('file-input-container');
      fileInputContainer.innerHTML = '';
      
      const maxFileInputs = 2; // 최대 파일 입력 개수
      const remainingFileInputs = maxFileInputs - attachList.length;
      
   		// 부족한 파일 입력 필드 생성
      for (let i = 0; i < remainingFileInputs; i++) {
        const fileInputDiv = document.createElement('div');
        fileInputDiv.className = 'file-input-div';
        fileInputDiv.innerHTML = '<input class="form-control" type="file" name="files" />';
        fileInputContainer.appendChild(fileInputDiv);
      }
    });
 }
 
//첨부 파일 크기 제한 및 삭제 버튼 추가 함수
const fnAttachCheck = () => {
  $(document).on('change', '.form-control', (e) => { // 이벤트 위임 사용
      const limitPerSize = 1024 * 1024 * 10; // 10MB
      const limitTotalSize = 1024 * 1024 * 10; // 10MB
      let totalSize = 0;
      const files = e.target.files[0];
      
      const inputArea = $(e.target).closest(".file-input-div");
      
      // 삭제 버튼 추가
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
 

//첨부파일 첨부 - 5개로 제한 , 추가 누를시 파일input창 생기게
const fnAttachInput = () => {
  $(".file-add-btn").on('click', () => {
    
    // list목록 + input창 개수 
    let attachListNum = $('#attach-list').children('.attach').length;
    let inputNum = $('.file-input-div').length;
    
    let totalNum = attachListNum + inputNum;
    const totalMax = 1;
    
    // 첨부파일 총합이 5개가 아닐 경우 input창 생성가능
    if (totalNum < totalMax) {
      const fileInputContainer = document.getElementById('file-input-container');
      const fileInputDiv = document.createElement('div');
      fileInputDiv.className = 'file-input-div';
      fileInputDiv.innerHTML = '<input class="form-control" type="file" name="files" />';
      fileInputContainer.appendChild(fileInputDiv);
    } else {
      alert('첨부파일은 최대 1개까지 가능합니다.');
    }
    
  });
}




// 첨부 파일 추가 이벤트 설정
let globalFormData = new FormData();
// 첨부 파일 추가 이벤트 설정
const fnAddAttach = () => {
  
  const fileInputContainer = document.getElementById('file-input-container');
  
  fileInputContainer.addEventListener('change', (event) => {
    if (event.target.type === 'file') {
      
      let file = event.target.files[0];
      
      
   		// 선택된 파일을 FormData에 추가
      if (file) {
        globalFormData.append('files', file);
        globalFormData.append('facilityNo', '${facility.facilityNo}');
        
      }
    }
  });
}

//첨부파일 input창 삭제
const fnAttachDel = () => {
  $(document).on('click', '.del-btn', (e) => {
    
    const inputArea = $(e.target).closest('.file-input-div');
    const fileInput = inputArea.find('input[type="file"]')[0];
    const fileName = fileInput.files[0].name;

    // 입력 영역 삭제	
    inputArea.remove();

 		// 삭제된 파일을 FormData에서도 제거
    const newFormData = new FormData();
    for (let pair of globalFormData.entries()) {
      if (pair[1].name !== fileName) {
        newFormData.append(pair[0], pair[1]);
      }
    }
    globalFormData = newFormData
    
 		// 남아 있는 입력 영역 개수 확인
    const inputsArea = $(".notice-input-area");
    const inputCount = inputsArea.children('.file-input-div').length;
    
  });
} 


const fnAddAttachGo = () => {

	  // FormData의 내용을 출력하여 확인
	  for (let pair of globalFormData.entries()) {
	    console.log(pair[0] + ': ' + pair[1].name); // 파일 이름 출력
	  }

	  $.ajax({
	    type: 'post',
	    url: '${contextPath}/facility/addAttach.do',
	    data: globalFormData,
	    contentType: false,
	    processData: false,
	    dataType: 'json',
	    success: (resData) => {
	      if (resData.attachResult) {
	        fnAttachList(); // 첨부 파일 목록 다시 불러오기
	      } else {
	    	  alert('첨부 파일이 추가되지 않았습니다.');	
	      }
	    }, 
	  });
	}

	// 폼 제출 이벤트 핸들러
	document.getElementById('frm-facility-modify').addEventListener('submit', (evt) => {
	  evt.preventDefault(); // 폼 제출 중지
	  console.log("폼 제출 중지됨");

	  fnAddAttachGo(); // 파일 첨부 실행
	  $(".loading").show(); // 로딩 표시

	  setTimeout(() => {
	    evt.target.submit(); // 폼 제출 재개
	  }, 1000); // AJAX 요청이 완료되기 전에 폼 제출을 재개하지 않도록 약간의 딜레이를 추가
	});

// 첨부 파일 삭제 (리스트항목에서 삭제, attachNo 잡아야해.)
  const fnRemoveAttach = () => {
      $(document).on('click', '.remove-attach', (evt) => {
          if (!confirm('해당 첨부 파일을 삭제할까요?')) {
              return;
          }
          const attachNo = evt.target.dataset.attachNo;

          // 해당 첨부 파일을 목록에서 삭제하고 관련 데이터 설정
          let parentElement = $(evt.target).parent().parent();
          let children = parentElement.children();
          parentElement.remove();
          
          $("#delAttachList").val($("#delAttachList").val()+"|"+attachNo);
          return attachNo;
      });
  }

       
//Ajax를 통해 첨부 파일 삭제 요청을 보내는 함수        
const fnRemoveAttachGo = (attachNo) => {
    fetch('${contextPath}/facility/removeAttach.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            'attachNo': attachNo
        })
    })
    .then(response => response.json())
    .then(resData => {
      
        if (resData.deleteCount === 1) {
            fnAttachList(); // 첨부 파일 목록 다시 불러오기
        } else {
        }
    });
}

// 제목 필수 입력 스크립트
const fnModifyUpload = () => {
  document.getElementById('frm-facility-modify').addEventListener('submit', (evt) => {
    if (document.getElementById('"basic-default-no"').value === '') {
      alert('시설번호는 필수입니다.');
      evt.preventDefault();
      return;
    }
    if (document.getElementById('basic-default-name').value === '') {
      alert('시설명을 입력해주세요.');
      evt.preventDefault();
      return;
    }
    
    
    
    evt.preventDefault(); // 폼 제출 중지
    fnAddAttachGo(); // 파일 첨부 실행
    fnRemoveAttachGo(); // 첨부 파일 삭제 요청 실행
    $(".loading").show(); // 로딩 표시
    evt.target.submit(); // 폼 제출 재개
  });
}

//관리 체크박스 처리 함수
const fnCkgMng = () => {
	  
	$('input[name="management"]').val(0);
	  
	  $(document).on('click', '.chkmanagement', (e) => {
		  	// 체크박스 상태에 따라 값 설정
		  	if ($(e.target).prop('checked')) {
	        $('input[name="management"]').val(1);
	      } else {
	         $('input[name="management"]').val(0); 
	      }
	  });
	}

	//입력 필드 길이 제한 처리 함수
	function handleOnInput(el, maxlength) {
	  	if(el.value.length > maxlength)  {
	    	el.value = el.value.substr(0, maxlength); // 최대 길이까지 자르기
	  	}
		}
	
	// 폼 유효성 검사 함수
	const validateForm = () => {
	    const deptNoInput = document.getElementById('basic-default-no');
	    const deptNo = deptNoInput.value.trim();
	    const pattern = /^[5-9][0-9]{3}$/; // 5000에서 5999 사이의 숫자 패턴

	    if (!pattern.test(deptNo)) {
	        deptNoInput.setCustomValidity('시설번호는 5000에서 5999 사이의 숫자여야 합니다.');
	    } else {
	        deptNoInput.setCustomValidity('');
	    }
	};

	// 폼 제출 시 유효성 검사 실행
	const form = document.getElementById('frm-facility-modify');
	form.addEventListener('submit', validateForm);

fnAttachInput();
fnAttachDel();
fnAttachList();
fnAddAttach();
fnModifyUpload();
fnRemoveAttach();
fnAttachCheck();
fnCkgMng();
</script>

<%@ include file="../layout/footer.jsp"%>
