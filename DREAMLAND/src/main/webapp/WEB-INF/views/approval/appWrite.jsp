<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="./../layout/approvalWrite-header.jsp" />  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>

<div class="container-xxl flex-grow-1 container-p-y">
<div class="col-6 mb-4" style="width:100%; height:100%">

<div class="container">
    <div class="title">기안서 작성하기</div>
  <div class="select-container">
        <select id="pageSelector" onchange="showPage(this.value)">
            <option value="approvalForm">품의서 작성</option>
            <option value="leaveRequestForm">휴가신청서 작성</option>
        </select>
    </div>
    <div id="approvalForm" class="page">
      <form method="GET"
        action="${contextPath}/approval/approval.do">
        <h2>품의서</h2>
        <!-- 품의서 내용 -->
        <div class="container">
            <div class="title">품 의 서</div>
            <!--  <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">-->
            <input type="hidden" name="userNo" value="1">
           <div class="section">
                <div class="section-title">제목</div>
                        	<input type="text" style="width:750px;" name="title"></input>

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
                    <td><input type="text" name="approver2"></input></td>
                    <td><input type="text" name="approver3"></input></td>
                    <td><input type="text" name="approver4"></input></td>
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
                            <textarea class="textarea" name="contents"></textarea>
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
       			  <button class="button button-secondary">파일선택</button>
              <button class="button button-secondary">삭제</button>
              <button class="button button-primary">임시저장</button>
              <button class="button button-primary" type="submit">제출하기</button>
            </div>
        </div>
        </form>
    </div>
    
    <div id="leaveRequestForm" class="page">
         <form method="GET"
        action="${contextPath}/approval/leave.do">
        <h2>휴가신청서</h2>
        <!-- 휴가신청서 내용 -->
        <div class="container">
            <div class="title">휴가신청서</div>
                            <div class="section-title">제목</div>
                        	<input type="text" style="width:750px;" name="title"></input>
         <input type="hidden" name="userNo" value="1">
        
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
                    <td><input type="text" name="approver2"></input></td>
                    <td><input type="text" name="approver3"></input></td>
                    <td><input type="text" name="approver4"></input></td>
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
                    <td><input type="text" name="leavekind"></input></td>
                </tr>
                <tr>
                    <td>휴가 기간</td>
                    <td><input type="date" name="leavestart"> ~ <input type="date" name="leaveend"></td>
                </tr>
                <tr>
                    <td>사유</td>
                    <td>
                        <textarea class="textarea" name="contents"></textarea>
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
       			  <button class="button button-secondary">파일선택</button>
              <button class="button button-secondary">삭제</button>
              <button class="button button-primary">임시저장</button>
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
   
   
   function showPage(pageId) {
       const pages = document.querySelectorAll('.page');
       pages.forEach(page => {
           page.classList.remove('active');
       });
       document.getElementById(pageId).classList.add('active');
   }

   // Initialize to show the first page
   showPage('approvalForm');
</script>
   
    
<%@ include file="./../layout/footer.jsp" %>
