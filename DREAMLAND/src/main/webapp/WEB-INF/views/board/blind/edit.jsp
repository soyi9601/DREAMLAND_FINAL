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

<!-- summernote -->
<!-- include summernote css/js -->
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.css">
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>

<!-- Content wrapper -->
<div class="content-wrapper">
		<!-- Content -->

		<div class="container-xxl flex-grow-1 container-p-y sd-notice-write">
				<div class="sd-title sd-point">익명게시판 작성</div>

				<!-- Basic Layout & Basic with Icons -->
				<div class="row">
						<!-- Basic Layout -->
						<div class="col-xxl">
								<div class="card mb-4">
									<form id="frm-blind-modify"
												method="POST"
												action="${contextPath}/board/blind/modify.do">
										<div class="card-body">
										
											<input type="text" name="boardTitle" value="${blind.boardTitle}">								
											<textarea id="contents" name="boardContents" >
												${blind.boardContents}
											</textarea>
										</div>
										<div>
											<input type="password" id="password" name="password" value=""> 
                      <input type="hidden" id="oldPassword" name="oldPassword" value="${blind.password}">
										  
											<button type="submit">작성완료</button>
											<input type="hidden" name="blindNo" value="${blind.blindNo}">
										</div>
										${blind.password}
									
									</form>
										
										
								</div>
						</div>



				</div>
		</div>
		<!-- / Content -->

	<script>
	const fnSummernoteEditor = () => {
	  $('#contents').summernote({
	    width: 900,
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
	
	
	fnSummernoteEditor();

	const fnModifyBlind = () => {
		document.getElementById('frm-blind-modify').addEventListener('submit', (evt) => {
			const passwordField = document.getElementById('password');
      const oldPasswordField = document.getElementById('oldPassword');

      // 비밀번호 필드가 비어있으면 기존 비밀번호로 설정
      if (passwordField.value === '') {
        passwordField.value = oldPasswordField.value;
      }
		})
	}

	fnModifyBlind()
  </script>

		<%@ include file="../../layout/footer.jsp"%>