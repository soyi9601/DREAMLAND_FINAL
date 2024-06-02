<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="./../layout/approvalWrite-header.jsp" />  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>

<div class="container-xxl flex-grow-1 container-p-y">
<div class="col-6 mb-4" style="width:100%; height:100%">




  <c:if test="${not empty title}">

<c:if test="${kind ==0 }">
<body onload="showPage('approvalForm')"></body>

    </c:if>
    
    <c:if test="${kind ==1 }">
<body onload="showPage('leaveRequestForm')"></body>
    </c:if>
</c:if>

<div class="container">
    <div class="title">기안서 작성하기</div>
    <c:if test="${empty title}">
  <div class="select-container">
        <select id="pageSelector" onchange="showPage(this.value)">
            <option value="approvalForm">품의서 작성</option>
            <option value="leaveRequestForm">휴가신청서 작성</option>
        </select>
    </div>
    </c:if>
    <div id="approvalForm" class="page">
      <form   id="myForm" method="POST"
		enctype="multipart/form-data"
        action="${contextPath}/approval/approval.do">
        <h2>품의서</h2>
        <!-- 품의서 내용 -->
        <div class="container">
            <div class="title">품 의 서</div>
            <!--  <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">-->
           <div class="section">
                <div class="section-title">제목</div>
                        	<input type="text" style="width:750px;" name="title"  value="${title}"></input>
    <input type="hidden" name="temp" value="0">
            </div>
             <div class="section-title">결재자</div>
            <table class="approval-table">
                <tr>
                    <td>담당</td>
                    <td>팀장</td>
                    <td>본부장</td>
                    <td>대표이사</td>
                </tr>
                <tr>
                    <td><input type="text" name="approver" readonly="readonly" value="${loginEmployee.empName}"></input></td>
                    <td><input type="text" name="approver2" value="${appovers.approver1}"></input></td>
                    <td><input type="text" name="approver3" value="${appovers.approver2}"></input></td>
                    <td><input type="text" name="approver4" value="${appovers.approver3}"></input></td>
                </tr>
            </table>
            <div class="section">
                <div class="section-title">참조</div>
                <table class="input-table">
                    <tr>
                   <td>	<input type="text" style="width:750px;" name="referrer"></input></td>
                    </tr>           
                </table>
            </div>
            <div class="section">
                <div class="section-title">품의 내용</div>
                <table class="input-table">
                    <tr>
                        <td style="width: 150px;" >품의 사유 및 상세 내역</td>
                        <td>
                            <textarea class="textarea" name="contents" required>${approval.detail}</textarea>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                위와 같은 사유로 품의서를 제출하오니 허가하여 주시기 바랍니다.<br>
                <br>
                20<span style="border-bottom: 1px solid #000;">&nbsp;&nbsp;&nbsp;&nbsp;</span>년&nbsp;&nbsp;&nbsp;&nbsp;월&nbsp;&nbsp;&nbsp;&nbsp;일<br>
                작성자: <span style="border-bottom: 1px solid #000;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> (인)
            </div>
            <div class="button-container">
														<div class="row mb-3">
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
              <button class="button button-secondary">삭제</button>
              <button class="button button-primary" id="submitBtn1">임시저장</button>
              <button class="button button-primary" type="submit">제출하기</button>
            </div>
        </div>
        </form>
    </div>
    
    <div id="leaveRequestForm" class="page">
      <form   id="myForm2" method="POST"
		enctype="multipart/form-data"
        action="${contextPath}/approval/leave.do">
        <h2>휴가신청서</h2>
        <!-- 휴가신청서 내용 -->
        <div class="container">
            <div class="title">휴가신청서</div>
                            <div class="section-title">제목</div>
                        	<input type="text" style="width:750px;" name="title" value="${title}"></input>
         <input type="hidden" name="temp" value="0">
        
             <div class="section-title">결재자</div>
            <table class="approval-table">
                <tr>
                    <td>담당</td>
                    <td>팀장</td>
                    <td>본부장</td>
                    <td>대표이사</td>
                </tr>
                <tr>
                     <td><input type="text" name="approver" readonly="readonly" value="${loginEmployee.empName}"></input></td>
                    <td><input type="text" name="approver2" value="${appovers.approver1}"></input></td>
                    <td><input type="text" name="approver3" value="${appovers.approver2}"></input></td>
                    <td><input type="text" name="approver4" value="${appovers.approver3}"></input></td>
                 </tr>
            </table>
            <div class="section">
                <div class="section-title">참조</div>
                <table class="input-table">
                    <tr>
                   <td>	<input type="text" style="width:750px;" name="referrer"></input></td>
                    </tr>           
                </table>
            </div>
            
            <table class="input-table">
                <tr>
                    <td>휴가 종류</td>
                    <td>
                    
            <select id="leave-type" name="leavekind">
            <c:if test="${empty title}">
            <option value="0">연차</option>
            <option value="1">반차</option>
            </c:if>
            
            <c:if test="${not empty title}">
            
                <c:if test="${kind ==1 }">
            <c:if test="${approval.leaveClassify == 0}">
              <option value="0" selected >연차</option>
              <option value="1">반차</option>
            </c:if>
            <c:if test="${approval.leaveClassify == 1}">
              <option value="0">연차</option>
              <option value="1" selected >반차</option>
            </c:if>
            </c:if>
            
            </c:if>
            
        </select></td>
                </tr>
                <tr>
                    <td>휴가 기간</td>
                       <c:if test="${kind ==1 }">
                    <td><input type="date" name="leavestart" value="<fmt:formatDate value='${approval.leaveStart}' pattern='yyyy-MM-dd'/>" > ~ <input type="date" name="leaveend" value="<fmt:formatDate value='${approval.leaveEnd}' pattern='yyyy-MM-dd'/>"></td>
               					</c:if>
               					 <c:if test="${empty title}">
               					<td><input type="date" name="leavestart" > ~ <input type="date" name="leaveend"  ></td>
                         </c:if>
               	 </tr>
                <tr>
                    <td>사유</td>
                    <td>
                        <textarea class="textarea" name="contents"   required> ${approval.detail}</textarea>
                    </td>
                </tr>
            </table>
            <div class="footer">
                위와 같은 사유로 휴가를 신청하오니 허가하여 주시기 바랍니다.<br>
                <br>
                20<span style="border-bottom: 1px solid #000;">&nbsp;&nbsp;&nbsp;&nbsp;</span>년&nbsp;&nbsp;&nbsp;&nbsp;월&nbsp;&nbsp;&nbsp;&nbsp;일<br>
                작성자: <span style="border-bottom: 1px solid #000;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> (인)
            </div>
        <div class="button-container">
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
              <button class="button button-secondary">삭제</button>
              <button class="button button-primary" id="submitBtn2">임시저장</button>
              <button class="button button-primary" type="submit">제출하기</button>
            </div>
        </div>
        </form>
    </div>
</div>
    </div>
</div>

<script>
/**
   document.getElementById('addButton').addEventListener('click', function() {
       var newButton = '<button class="button button">결재자</button>'
       document.getElementById('buttonContainer').innerHTML += newButton;
   });
   document.getElementById('addButton2').addEventListener('click', function() {
       var newButton = '<button class="button button">참조자</button>'
       document.getElementById('buttonContainer2').innerHTML += newButton;
   });
   document.getElementById('addButton3').addEventListener('click', function() {
       var selectedForm = document.getElementById('formSelect').value;
       var formContainer = document.getElementById('formContainer');
       
       if (selectedForm === 'expense') {
    	   formContainer.innerHTML = '<p>지출품의서</p>';
       } else if (selectedForm === 'leave') {
           formContainer.innerHTML = '<p>휴가신청서</p>';
       }
   });
   */
   
   $(document).ready(function() {
       $('#submitBtn1').click(function(event) {
           event.preventDefault(); // 기본 제출 동작을 막음
           $('input[name="temp"]').val('3');
           $('#myForm').submit(); // 폼 제출
       });

       $('#submitBtn2').click(function(event) {
           event.preventDefault(); // 기본 제출 동작을 막음
           $('input[name="temp"]').val('3');
           $('#myForm2').submit(); // 폼 제출
       });
       

   });
   
   
   function showPage(pageId) {
       const pages = document.querySelectorAll('.page');
       pages.forEach(page => {
           page.classList.remove('active');
       });
       document.getElementById(pageId).classList.add('active');
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

   // Initialize to show the first page
  showPage('approvalForm');
  fnTempSave();
	fnAttachAdd();
	fnAttachCheck();
	fnAttachDel();
</script>
   
    
<%@ include file="./../layout/footer.jsp" %>
