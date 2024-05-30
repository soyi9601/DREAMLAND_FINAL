<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="./../layout/approvalWrite-header.jsp" />  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>

<c:if test="${kind == 0}">
   <div class="container-xxl flex-grow-1 container-p-y">
<div class="col-6 mb-4" style="width:100%; height:100%">

<div class="container">
    <div id="approvalForm" >
        <!-- 품의서 내용 -->
        <div class="container">
            <div class="title">품 의 서</div>
            <!--  <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">-->
            <input type="hidden" name="userNo" value="1">
           <div class="section">
                <div class="section-title">제목</div>
                        	<div>${title}</div>

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
                    <td><div>${appovers.writer}</div></td>
                    <td><div>${appovers.approver1}</div></td>
                    <td><div>${appovers.approver2}</div></td>
                    <td><div>${appovers.approver3}</div></td>
                </tr>
            </table>
            <div class="section">
                <div class="section-title">참조</div>
                <table class="input-table">
                    <tr>
                   <td>	<input type="text" style="width:100%;" name="referrer"></input></td>
                    </tr>           
                </table>
            </div>
            <div class="section">
                <div class="section-title">품의 내용</div>
                <table class="input-table">
                    <tr>
                        <td style="width: 150px;" >품의 사유 및 상세 내역</td>
                        <td>
                        	${approval.detail}
                        </td>
                    </tr>
                </table>
            </div>
            
             <c:if test="${reject == 1}">
                    <div class="section">
                <div class="section-title">반려자</div>
                <table class="input-table">
                    <tr>
                        <td>
                        	${returner}
                        </td>
                    </tr>
                </table>
            </div>
                    <div class="section">
                <div class="section-title">반려사유</div>
                <table class="input-table">
                    <tr>
                        <td>
                        	${returnReason}
                        </td>
                    </tr>
                </table>
            </div>
                </c:if>
            
            
            <div class="footer">
                위와 같은 사유로 품의서를 제출하오니 허가하여 주시기 바랍니다.<br>
                <br>
                20<span style="border-bottom: 1px solid #000;">&nbsp;&nbsp;&nbsp;&nbsp;</span>년&nbsp;&nbsp;&nbsp;&nbsp;월&nbsp;&nbsp;&nbsp;&nbsp;일<br>
                작성자: <span style="border-bottom: 1px solid #000;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> (인)
            </div>
            <c:if test="${kind2 == 'wait' &&  loginEmployee.empName == appovers.approver1 || kind2 == 'wait' &&  loginEmployee.empName == appovers.approver2 || kind2 == 'wait' &&  loginEmployee.empName == appovers.approver3}">
            <div class="button-container">
                     <input type="hidden" name="apvNo" value="${approval.apvNo}">
                     <input type="hidden" name="empNo" value="${loginEmployee.empNo}">
              <button class="button button-primary"  id="approve">결재하기</button>
            </div>
            <div class="button-container">
              <button class="button button-primary" id="rejected">반려하기</button>
            </div>
            </c:if>
            </div>
 
        </div>
    </div>
    
  
</div>
    </div>
    
  
</c:if>

<c:if test="${kind == 1}">
   <div class="container-xxl flex-grow-1 container-p-y">
<div class="col-6 mb-4" style="width:100%; height:100%">


     <div class="container">
    <div id="leaveRequestForm" >

        <h2>휴가신청서</h2>
        <!-- 휴가신청서 내용 -->
        <div class="container">
            <div class="title">휴가신청서</div>
                            <div class="section-title">제목</div>
                                       	<div>${title}</div>

        
             <div class="section-title">결재자</div>
            <table class="approval-table">
                <tr>
                    <td>담당</td>
                    <td>팀장</td>
                    <td>본부장</td>
                    <td>대표이사</td>
                </tr>
                <tr>
                    <td><div>${appovers.writer}</div></td>
                    <td><div>${appovers.approver1}</div></td>
                    <td><div>${appovers.approver2}</div></td>
                    <td><div>${appovers.approver3}</div></td>
                </tr>
            </table>
            <div class="section">
                <div class="section-title">참조</div>
                <table class="input-table">
                    <tr>
                   <td>	<input type="text" style="width:100%;" name="referrer"></input></td>
                    </tr>           
                </table>
            </div>
            
              <div class="section">
            <table class="input-table">
                <tr>
                    <td>휴가 종류</td>
                    <td colspan="2">
                        	${approval.leaveClassify}
                        </td>
                                   
                </tr>
                <tr>
                    <td>휴가 기간</td>
                                              <td>
                        	${approval.leaveStart}
                        </td>
                                                  <td>
                        	${approval.leaveEnd}
                        </td>
                </tr>
                <tr>
                    <td>사유</td>
                                  <td colspan="2">
                        	${approval.detail}
                        </td>
                </tr>
            </table>
            </div>
                      <c:if test="${reject == 1}">
                    <div class="section">
                <div class="section-title">반려자</div>
                <table class="input-table">
                    <tr>
                        <td>
                        	${returner}
                        </td>
                    </tr>
                </table>
            </div>
                    <div class="section">
                <div class="section-title">반려사유</div>
                <table class="input-table">
                    <tr>
                        <td>
                        	${returnReason}
                        </td>
                    </tr>
                </table>
            </div>
                </c:if>
            <div class="footer">
   
                위와 같은 사유로 휴가를 신청하오니 허가하여 주시기 바랍니다.<br>
                <br>
                20<span style="border-bottom: 1px solid #000;">&nbsp;&nbsp;&nbsp;&nbsp;</span>년&nbsp;&nbsp;&nbsp;&nbsp;월&nbsp;&nbsp;&nbsp;&nbsp;일<br>
                작성자: <span style="border-bottom: 1px solid #000;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> (인)
            </div>
            <c:if test="${kind2 == 'wait' &&  loginEmployee.empName == appovers.approver1 || kind2 == 'wait' &&  loginEmployee.empName == appovers.approver2 || kind2 == 'wait' &&  loginEmployee.empName == appovers.approver3}">
            <div class="button-container">
                     <input type="hidden" name="apvNo" value="${approval.apvNo}">
                     <input type="hidden" name="empNo" value="${loginEmployee.empNo}">
             <button class="button button-primary"  id="approve">결재하기</button>
            </div>
            <div class="button-container">
              <button class="button button-primary" id="rejected">반려하기</button>
            </div>
            </c:if>
        </div>
    </div>
    </div>
    </div>
    </div>
</c:if>


<script>

const apvNo = ${approval.apvNo};
const empNo = ${loginEmployee.empNo};

function sendGetRequest(queryParams) {
	 window.location.href = '${contextPath}/approval/approve.do?'+ new URLSearchParams(queryParams).toString();
}

function handlePopupFormSubmission(inputText) {
    const queryParams = { apvNo: apvNo, empNo:empNo, rejectedReason: inputText };
    sendGetRequest(queryParams);
}

document.getElementById('approve').addEventListener('click', function() {
    const queryParams = { apvNo: apvNo, empNo:empNo, rejectedReason:'0' };
    sendGetRequest(queryParams);
});

document.getElementById('rejected').addEventListener('click', function() {
	 openPopupAndSendRequest();
});

function openPopupAndSendRequest() {
     window.open('popup', '', 'width=400,height=300');
}



window.handlePopupFormSubmission = handlePopupFormSubmission;

</script>
   
    
<%@ include file="./../layout/footer.jsp" %>
