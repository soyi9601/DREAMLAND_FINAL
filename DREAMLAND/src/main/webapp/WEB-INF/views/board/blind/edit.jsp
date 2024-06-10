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
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>


<!-- summernote -->
<!-- include summernote css/js -->
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.css">
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>

<!-- Content wrapper -->
<div class="content-wrapper sd-board" id="blind-edit">
    <!-- Content -->

    <div class="container-xxl flex-grow-1 container-p-y sd-blind">
        <div class="title sd-point">익명게시판 편집</div>

        <!-- Basic Layout & Basic with Icons -->
        <div class="row">
            <!-- Basic Layout -->
            <div class="col-xxl">
                <div class="card mb-4">
                  <form id="frm-blind-modify"
                        method="POST"
                        action="${contextPath}/board/blind/modify.do">
                    <div class="card-body">
                    
                      <div class="row mb-3">
                        <label class="col-sm-2 col-form-label" for="basic-default-name">제목</label>
                        <div class="col-sm-10">
                          <input type="text" class="form-control" name="boardTitle" id="board-title" placeholder="제목을 입력해주세요."
                          value="${blind.boardTitle}">   
                        </div>
                      </div>                    
                    
                      <textarea id="contents" name="boardContents" placeholder="내용을 입력하세요">
                        ${blind.boardContents}
                      </textarea> 
                      
                      
                      <div class="row mb-3">
                        <label class="col-sm-2 col-form-label" for="basic-default-name">비밀번호</label>
                        <div class="col-sm-10">
                          <input type="password" class="form-control" id="password" name="password" value=""> 
                          <input type="hidden" id="oldPassword" name="oldPassword" value="${blind.password}">
                        </div>
                      
                      </div>
                      <div class="btn-area">
                      
                        <button type="submit" class="btn-reset sd-btn sd-point-bg">수정</button>
                        <input type="hidden" name="blindNo" value="${blind.blindNo}">
                      </div>
                    </div>
                    
                
                  </form>
                    
                </div>
            </div>

        </div>
    </div>
    <!-- / Content -->
</div>


  <script>
  const fnSummernoteEditor = () => {
    $('#contents').summernote({
 
      height: 500,
      lang: 'ko-KR',
      toolbar: [
        // [groupName, [list of button]]
        ['fontname', ['fontname']],
        ['fontsize', ['fontsize']],
        ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
        ['color', ['forecolor','color']],
        ['para', ['paragraph']],
        ['insert',['picture','link','video']],
        ['view', ['help']]
      ],
    fontNames: ['맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체', 'Nanum Myeongjo', 'Noto Sans KR'],
    fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
    lang: 'ko-KR',
      callbacks: {
        onImageUpload: (images)=>{
          // 비동기 방식을 이용한 이미지 업로드
          for(let i = 0; i < images.length; i++) {
            let formData = new FormData();
            formData.append('image', images[i]);
            fetch('${contextPath}/board/blind/summernote/imageUpload.do', {
              method: 'POST',
              body: formData
            })
            .then(response=>response.json())
            .then(resData=>{
              $('#contents').summernote('insertImage', '${contextPath}' + resData.src);
            })
          }
        }
      }
    })
  }  
  
  //alert( document.getElementById('oldPassword').value)
  
  //let passwordField;
  //let oldPasswordField;
  
  const fnModifyBlind = () => {
     document.getElementById('frm-blind-modify').addEventListener('submit', (evt) => {
       let passwordField = document.getElementById('password').value;
       
       if (passwordField === '') {
           let oldPasswordField = document.getElementById('oldPassword').value;
           passwordField = oldPasswordField;
           document.getElementById('password').value = passwordField;
           
           //alert(passwordField+'<<<이거');
           //alert(document.getElementById('password').value)
       }else{
         
         document.getElementById('password').value = encryptPassword(passwordField);
         //alert(document.getElementById('password').value)
       }
       
       //document.getElementById('password').value = encryptPassword(passwordField);
       //alert(document.getElementById('password').value);
       //evt.preventDefault();
   });
};

function encryptPassword(password) {
  const key = CryptoJS.enc.Utf8.parse('mysecretkey12345');
  const encrypted = CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse(password), key, {
      mode: CryptoJS.mode.ECB,
      padding: CryptoJS.pad.Pkcs7
  });
  return encrypted.toString();
}


fnSummernoteEditor();
fnModifyBlind();


  </script>

    <%@ include file="../../layout/footer.jsp"%>