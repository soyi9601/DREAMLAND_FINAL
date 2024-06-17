<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee"
    value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />


<!-- Content wrapper -->
<div class="content-wrapper sd-board">
  <!-- Content -->
    <div class="container-xxl flex-grow-1 container-p-y sd-notice-edit">
        <div class="title sd-point">공지사항 편집</div>

        <!-- Basic Layout & Basic with Icons -->
        <div class="row">
            <!-- Basic Layout -->
            <div class="col-xxl">
                <div class="card mb-4">

                    <div class="card-body">
                        <!-- Form 시작 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
                      <form id="frm-notice-modify" 
                            method="POST"
                            enctype="multipart/form-data"
                            action="${contextPath}/board/notice/modify.do">
                        <div class="row mb-3">
                          <input type="hidden" name="empNo"
                              value="${loginEmployee.empNo}"> <label
                              class="col-sm-2 col-form-label"
                              for="basic-default-name">제목</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control"
                                  id="basic-default-name" placeholder="제목을 입력해주세요."
                                  name="boardTitle" value="${notice.boardTitle}"/>
                          </div>
                        </div>
                        
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">중요</label>
                          <div class="col-sm-10">
                            <input type="checkbox" class="chksignal form-check-input" name="signal" value="${notice.signal}" ${notice.signal eq 1 ? 'checked' : ''} />
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
                                  class="form-control" placeholder="내용"
                                  aria-label="Hi, Do you have a moment to talk Joe?"
                                  aria-describedby="basic-icon-default-message2"
                                  name="boardContents" >${notice.boardContents}</textarea>
                          </div>
                        </div>

                        <div class="attached-file-area">
                          <p>첨부파일 <i class='bx bx-paperclip'></i></p>
                          <div id="attach-list" ></div>
                          <div class="loading">
                            <span></span>
                            <span></span>
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
                          <input type="hidden" name="noticeNo" value="${notice.noticeNo}">
                          <button type="submit" id="btn-edit-submit" class="btn-reset sd-btn sd-point-bg">수정</button>
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


$(".loading").hide(); // 전송시 첨부파일 목록의 로딩화면 숨겨놓음

// 기존 첨부 파일 목록 가져오기 및 input창 생성
let insAttachList = [];
const fnAttachList = () => {
  fetch('${contextPath}/board/notice/attachList.do?noticeNo=${notice.noticeNo}', {
    method: 'GET'
  })
  .then(response => response.json())
  .then(resData => {
      let divAttachList = document.getElementById('attach-list');
      divAttachList.innerHTML = '';
      const attachList = resData.attachList;
      
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
      
      const maxFileInputs = 5;
      const remainingFileInputs = maxFileInputs - attachList.length;
      
      for (let i = 0; i < remainingFileInputs; i++) {
        const fileInputDiv = document.createElement('div');
        fileInputDiv.className = 'file-input-div';
        fileInputDiv.innerHTML = '<input class="form-control" type="file" name="files" />';
        fileInputContainer.appendChild(fileInputDiv);
      }
    });
 }
 
// 첨부파일 크기제한
const fnAttachCheck = () => {
  $(document).on('change', '.form-control', (e) => {
      const limitPerSize = 1024 * 1024 * 10; 
      const limitTotalSize = 1024 * 1024 * 10; 
      let totalSize = 0;
      const files = e.target.files[0];
      
      const inputArea = $(e.target).closest(".file-input-div");
      
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
    const totalMax = 5;
    
    // 첨부파일 총합이 5개가 아닐 경우 input창 생성가능
    if (totalNum < totalMax) {
      const fileInputContainer = document.getElementById('file-input-container');
      const fileInputDiv = document.createElement('div');
      fileInputDiv.className = 'file-input-div';
      fileInputDiv.innerHTML = '<input class="form-control" type="file" name="files" />';
      fileInputContainer.appendChild(fileInputDiv);
    } else {
      alert('첨부파일은 최대 5개까지 가능합니다.');
    }
    
  });
}


// 첨부 파일 추가
let globalFormData = new FormData();
const fnAddAttach = () => {
  
  const fileInputContainer = document.getElementById('file-input-container');
  
  fileInputContainer.addEventListener('change', (event) => {
    if (event.target.type === 'file') {
      
      let file = event.target.files[0];
      if (file) {
        globalFormData.append('files', file);
        globalFormData.append('noticeNo', '${notice.noticeNo}');
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

    inputArea.remove();
    
    const newFormData = new FormData();
    for (let pair of globalFormData.entries()) {
      if (pair[1].name !== fileName) {
        newFormData.append(pair[0], pair[1]);
      }
    }
    globalFormData = newFormData
    const inputsArea = $(".notice-input-area");
    const inputCount = inputsArea.children('.file-input-div').length;
  });
} 



const fnAddAttachGo = () => {
  $.ajax({
    type: 'post',
    url: '${contextPath}/board/notice/addAttach.do',
    data: globalFormData,
    contentType: false,
    processData: false,
    dataType: 'json',
    success: (resData) => {
      if (resData.attachResult) {
        fnAttachList();
      } else {
        alert('첨부 파일이 추가되지 않았습니다.');
      }
    },
  });
}

// 첨부 파일 삭제 (jsp 리스트항목에서 삭제, attachNo로 인식)
const fnRemoveAttach = () => {
    $(document).on('click', '.remove-attach', (evt) => {
        if (!confirm('해당 첨부 파일을 삭제할까요?')) {
            return;
        }
        const attachNo = evt.target.dataset.attachNo;

        let parentElement = $(evt.target).parent().parent();
        let children = parentElement.children();
        parentElement.remove();
        
        $("#delAttachList").val($("#delAttachList").val()+"|"+attachNo);
        return attachNo;
    });
}

// 첨부 파일 삭제 (완전삭제)        
const fnRemoveAttachGo = (attachNo) => {
    fetch('${contextPath}/board/notice/removeAttach.do', {
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
            fnAttachList();
        } else {
        	
        }
    });
}

// 전송
const fnModifyUpload = () => {
  document.getElementById('frm-notice-modify').addEventListener('submit', (evt) => {
    if (document.getElementById('basic-default-name').value === '') {
      alert('제목은 필수입니다.');
      evt.preventDefault();
      return;
    }
    if (document.getElementById('basic-default-message').value === '') {
      alert('내용을 입력해주세요.');
      evt.preventDefault();
      return;
    }

    evt.preventDefault(); // 폼 제출 중지
    fnAddAttachGo(); // 파일 첨부 실행
    fnRemoveAttachGo(); // 삭제한 파일 넘기기
    $(".loading").show(); // 로딩화면 
    evt.target.submit(); // 폼 제출 재개
    
  });
}

// 공지사항 중요 체크박스
const fnChkSig = () => {
  $(document).on('click', '.chksignal', (e) => {
    if ($(e.target).prop('checked')) {
      $('input[name="signal"]').val(1);
    } else {
       $('input[name="signal"]').val(0); 
    }
  });
}


fnAttachInput();
fnAttachDel();
fnAttachList();
fnAddAttach();
fnModifyUpload();
fnRemoveAttach();
fnAttachCheck();
fnChkSig();
</script>

<%@ include file="../../layout/footer.jsp"%>
