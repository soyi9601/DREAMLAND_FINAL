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


<!-- Content wrapper -->
<div class="content-wrapper">
  <!-- Content -->
    <div class="container-xxl flex-grow-1 container-p-y">
        <div class="sd-title sd-point">공지사항 작성</div>

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
                          <label class="col-sm-2 col-form-label">체크</label>
                          <div class="col-sm-10">
                            <input type="checkbox" class="chksignal" name="signal" value="${notice.signal}" ${notice.signal eq 1 ? 'checked' : ''} />
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
                                  name="boardContents" >${notice.boardContents}</textarea>
                          </div>
                        </div>


                        <h3>현재 첨부 목록</h3>
                        <div id="attach-list" ></div>
                        <div class="row mb-3">
                          <label for="formFileMultiple"
                              class="col-sm-2 col-form-label"> 파일첨부
                               <span class="file-add-btn">추가버튼!!!</span>
                          </label>
                          <div class="col-sm-10 notice-input-area">
                             <!-- <input class="form-control" type="file" name="files" id="files" />-->
                             <div id="file-input-container"></div>
                          </div>
                          
                        </div>

                        <div>
                          <input type="hidden" name="delAttachList" id="delAttachList">
                          <input type="hidden" name="noticeNo" value="${notice.noticeNo}">
                          <button type="submit" id="btn-edit-submit">수정완료</button>
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
let insAttachList = [];
// 기존 첨부 파일 목록 가져오기 및 파일 입력 필드 생성
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
        str += '<a style="margin-left: 10px;" class="remove-attach" data-attach-no="' + attach.attachNo + '">x</a>';
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
  $(document).on('change', '.form-control', (e) => { // 이벤트 위임 사용
      const limitPerSize = 1024 * 1024 * 10; // 10MB
      const limitTotalSize = 1024 * 1024 * 10; // 10MB
      let totalSize = 0;
      const files = e.target.files[0];
      
      const inputArea = $(e.target).closest(".file-input-div");
      
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
 
 



//첨부파일 첨부 - 5개로 제한 , 2개 기본, 추가 누를시 파일input창 생기게... 없앨까? 
    // 이거 하는중
    
const fnAttachAdd = () => {
  $(".file-add-btn").on('click', () => {
    
    //여기에
    // list목록 + input창 개수 
    let attachListNum = $('#attach-list').children('.attach').length;
    let inputNum = $('.file-input-div').length;
    
    let totalNum = attachListNum + inputNum;
    const totalMax = 5;
    
    
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
fnAttachAdd();

// 첨부 파일 추가 이벤트 설정
let globalFormData = new FormData();

// 첨부 파일 추가 이벤트 설정

const fnAddAttach = () => {
  
  //
  const fileInputContainer = document.getElementById('file-input-container');
  
  fileInputContainer.addEventListener('change', (event) => {
    if (event.target.type === 'file') {
      
      let file = event.target.files[0];
      
      console.log(file);
      
      if (file) {
        globalFormData = new FormData(); // 새 formData 객체 생성
        globalFormData.append('files', file);
        globalFormData.append('noticeNo', '${notice.noticeNo}');
        
      }
    }
  });
}



// x버튼눌러서 삭제했는데도 첨부됨 .? 왜?

//첨부파일 input창 삭제
const fnAttachDel = () => {
  $(document).on('click', '.del-btn', (e) => {
    
    const inputArea = $(e.target).closest('.file-input-div');
    
    inputArea.remove();

    //원래있던globalFormData를 빼야할듯
    console.log(globalFormData);

    const inputsArea = $(".notice-input-area");
    const inputCount = inputsArea.children('.file-input-div').length;
    
  });
} 

fnAttachDel();

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
        //alert('첨부 파일이 추가되었습니다.');
        fnAttachList();
      } else {
        //alert('첨부 파일이 추가되지 않았습니다.');
      }
    },
  });
}

// 첨부 파일 삭제 (리스트항목에서 삭제, attachNo 잡아야해.)
  const fnRemoveAttach = () => {
      $(document).on('click', '.remove-attach', (evt) => {
          if (!confirm('해당 첨부 파일을 삭제할까요?')) {
              return;
          }
          
          const attachNo = evt.target.dataset.attachNo;
          //console.log('gsdg');
          //fnRemoveAttachGo(attachNo);
          console.log(attachNo)

          // ※ attachNo가 파일명에 붙어있는게 아니라 x버튼에 붙어있음
          let parentElement = $(evt.target).parent();
          let children = parentElement.children();
          parentElement.remove();
          
          //debugger;
          $("#delAttachList").val($("#delAttachList").val()+"|"+attachNo);
          //fnRemoveAttachGo(attachNo);
          return attachNo;
      });
  }

       
        
const fnRemoveAttachGo = (attachNo) => {
  console.log(attachNo);
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
      console.log(resData)
      console.log("못찾음")
      
        if (resData.deleteCount === 1) {
           // alert('첨부 파일이 삭제되었습니다.');
            fnAttachList();
            console.log(resData)
        } else {
            //alert('첨부 파일이 삭제되지 않았습니다.');
            console.log(resData)
        }
    });
}

// 목록에서도 사라저야 하고, form리스트 다시 만들어서 보내야하지않나?
      

// 제목 필수 입력 스크립트
const fnModifyUpload = () => {
  document.getElementById('frm-notice-modify').addEventListener('submit', (evt) => {
    if (document.getElementById('basic-default-name').value === '') {
      alert('제목은 필수입니다.');
      evt.preventDefault();
      console.log($('input[name="signal"]').val());
      return;
    }
    evt.preventDefault(); // 폼 제출 중지
    fnAddAttachGo(); // 파일 첨부 실행
    fnRemoveAttachGo();
    evt.target.submit(); // 폼 제출 재개
  });
}

//체크박스 선택시 value값 1로 넘긱기
const fnChkSig = () => {
  
  //$('input[name="signal"]').val(0);
  
  $(document).on('click', '.chksignal', (e) => {
      if ($(e.target).prop('checked')) {
        $('input[name="signal"]').val(1);
      } else {
         $('input[name="signal"]').val(0); 
      }
  });
}

fnAttachList();
fnAddAttach();
fnModifyUpload();
fnRemoveAttach();
fnAttachCheck();
fnChkSig();
</script>

<%@ include file="../../layout/footer.jsp"%>
