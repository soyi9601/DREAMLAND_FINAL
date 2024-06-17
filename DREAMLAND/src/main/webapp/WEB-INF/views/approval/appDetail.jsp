<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="./../layout/apv-header.jsp" />  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>

<c:if test="${kind == 0}">
   <div class="container-xxl flex-grow-1 container-p-y">
<div class="pv-col-6 mb-4" style="width:100%; height:100%; display: flex;
            justify-content: center;
            align-items: center; ">
 <div class="post-list-container">
         <div class="apv-container">
    <div id="approvalForm" >
        <!-- 품의서 내용 -->
         <h2 class="text-nowrap mb-2 text-primary">품의서</h2>
            <br>
            <!--  <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">-->
            <input type="hidden" name="userNo" value="1">
           <div class="section">
                <div class="section-title">제목</div>
                         	<input type="text" style=" width:100%;    background-color: #ffffff;" class="form-control" name="title" id="title"  readonly="readonly" value="${title}"></input>

            </div>
            <br>
             <div class="section-title">결재자</div>
           <table  class="table table-bordered">
                <tr>
                    <td>담당</td>
  									 <c:if test="${not empty appovers.approver1}"><td><div>${appovers.approverPosName1}</div></td></c:if>
                     <c:if test="${not empty appovers.approver2}"><td><div>${appovers.approverPosName2}</div></td></c:if>
                     <c:if test="${not empty appovers.approver3}"><td><div>${appovers.approverPosName3}</div></td></c:if>
                </tr>
                <tr>
                    <td><div>${appovers.writer}</div></td>
                     <c:if test="${not empty appovers.approver1}"><td><div>${appovers.approver1}</div></td></c:if>
                     <c:if test="${not empty appovers.approver2}"><td><div>${appovers.approver2}</div></td></c:if>
                     <c:if test="${not empty appovers.approver3}"><td><div>${appovers.approver3}</div></td></c:if>
                </tr>
            </table>
               <br>
            <div class="section">
                <div class="section-title">참조자</div>
                 	<input type="text" style=" width:100%;    background-color: #ffffff;" class="form-control" name="title" id="title"  readonly="readonly" value="${referrer}"></input>
            </div>
               <br>
            <div class="section">
                <div class="section-title">품의 내용 및 상세내역</div>
                            <textarea class="form-control" name="contents"  id="contents" >${approval.detail}</textarea>
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
                    <br>
      		<div class="row mb-3">
												   <div class="section-title">첨부파일</div>
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
														</div>
            
            <br>
            
            <div class="footer">
  위와 같은 사유로 품의서를 제출하오니 허가하여 주시기 바랍니다. &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp; 
                 &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp; 
                  &nbsp;&nbsp; &nbsp;&nbsp;
                             ${ApvDate} &nbsp;&nbsp; 작성자 : ${appovers.writer}   
                     </div>
         </div>
            </div>
                       <c:if test="${kind2 == 'wait' &&  loginEmployee.empName == appovers.approver1 || kind2 == 'wait' &&  loginEmployee.empName == appovers.approver2 || kind2 == 'wait' &&  loginEmployee.empName == appovers.approver3}">
            <div class="buttons">
                     <input type="hidden" name="apvNo" value="${approval.apvNo}">
                     <input type="hidden" name="empNo" value="${loginEmployee.empNo}">
              <button class="btn btn-success" style="" id="approve">결재하기</button>
              <button class="btn btn-danger" id="rejected">반려하기</button>
            </div>
            </c:if>
            
               <c:if test="${reject == 2}">
                   <div class="buttons">
               	  <button class="btn btn-danger" id="delete">삭제하기</button>
               	  <button class="btn btn-success" id="write">작성하기</button>
              	</div>
               </c:if>
               
               
            <c:if test="${kind2 == 'total' &&  loginEmployee.empName == appovers.writer || kind2 == 'wait' &&  loginEmployee.empName ==appovers.writer || kind2 == 'complete' &&  loginEmployee.empName == appovers.writer}">
               <div class="buttons">
              	  <button class="btn btn-danger" id="revoke">철회하기</button>
              	  </div>
            </c:if>
 

    </div>
    
  
</div>
</div>
    
  
</c:if>

<c:if test="${kind == 1}">
   <div class="container-xxl flex-grow-1 container-p-y">
<div class="pv-col-6 mb-4" style="width:100%; height:100%; display: flex;
            justify-content: center;
            align-items: center; ">
 <div class="post-list-container">
    <div id="leaveRequestForm" >

         
        <!-- 휴가신청서 내용 -->
        <div class="apv-container">
             <h2 class="text-nowrap mb-2 text-primary">휴가신청서</h2>
                <br>  <div class="section">
                            <div class="section-title">제목</div>
                                    	<input type="text" style=" width:100%;    background-color: #ffffff;" class="form-control" name="title" id="title"  readonly="readonly" value="${title}"></input>
         </div>
          <br>
            <div class="section">
             <div class="section-title">결재자</div>
            <table  class="table table-bordered">
                <tr>
                    <td>담당</td>
                    <td>팀장</td>
                    <td>본부장</td>
                    <td>대표이사</td>
                </tr>
                <tr>
                    <td><div id="writer">${appovers.writer}</div></td>
                    <td><div id="approver1">${appovers.approver1}</div></td>
                    <td><div id="approver2">${appovers.approver2}</div></td>
                    <td><div id="approver3">${appovers.approver3}</div></td>
                </tr>
            </table>
            </div>
              <br>
            <div class="section">
                <div class="section-title">참조자</div>
                     <input type="text"  class="form-control"style="width:100%;" id="referrer2" name="referrer" value="${referrer}"></input>
            </div>
             <br>
            <input type="hidden" id="leaveKind" value="${approval.leaveClassify}">
           <div class="section-title">휴가 상세 및 사유</div>
            <table class="table table-bordered leavetable">
                <tr>
                    <td>휴가 종류</td>
                    <td colspan="2">
                        <c:if test="${approval.leaveClassify==1}">
                        	반차
                        </c:if>
                        <c:if test="${approval.leaveClassify==0}">
                        	연차
                        </c:if>
                     </td>
                                   
                </tr>
                <tr>
                    <td>휴가 기간</td>
                      <c:if test="${approval.leaveClassify==0}">
                                              <td>
                        	${approval.leaveStart}
                        	
                        	&nbsp;~	&nbsp;
                        	
                        	${approval.leaveEnd}
                        </td>
                        </c:if>
                    <c:if test="${approval.leaveClassify==1}">
                        <td>
                        	${approval.leaveStart}
                        </td>
                       <c:if test="${approval.halfday=='afternoon'}">
                        <td>
                        오후
                        </td>
                        </c:if>
                       <c:if test="${approval.halfday=='morning'}">
                            <td>
                        	오전
                      		  </td>
                       	 </c:if>
                     </c:if>
                        
                        
                        
                </tr>
                <tr>
                    <td>사유</td>
                                  <td colspan="2">
                        ${approval.detail}
                        </td>
                </tr>
            </table>
            <br>
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
            <br>
                </c:if>
                
      		<div class="row mb-3">
												   <div class="section-title">첨부파일</div>
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
														</div>
														    <br>
             <div class="footer">
                위와 같은 사유로 품의서를 제출하오니 허가하여 주시기 바랍니다. &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp; 
                 &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp; 
                            &nbsp;&nbsp; &nbsp;&nbsp; 
                             ${ApvDate} &nbsp;&nbsp; 작성자 : ${appovers.writer}
                     </div>
                      </div>
                        </div>
                       <c:if test="${kind2 == 'wait' &&  loginEmployee.empName == appovers.approver1 || kind2 == 'wait' &&  loginEmployee.empName == appovers.approver2 || kind2 == 'wait' &&  loginEmployee.empName == appovers.approver3}">
            <div class="buttons">
                     <input type="hidden" name="apvNo" value="${approval.apvNo}">
                     <input type="hidden" name="empNo" value="${loginEmployee.empNo}">
              <button class="btn btn-success" style="" id="approve">결재하기</button>
              <button class="btn btn-danger" id="rejected">반려하기</button>
            </div>
            </c:if>
            
               <c:if test="${reject == 2}">
                   <div class="buttons">
               	  <button class="btn btn-danger" id="delete">삭제하기</button>
               	  <button class="btn btn-success" id="write">작성하기</button>
              	</div>
               </c:if>
               
               
            <c:if test="${kind2 == 'total' &&  loginEmployee.empName == appovers.writer || kind2 == 'wait' &&  loginEmployee.empName ==appovers.writer || kind2 == 'complete' &&  loginEmployee.empName == appovers.writer}">
               <div class="buttons">
              	  <button class="btn btn-danger" id="revoke">철회하기</button>
              	  </div>
            </c:if>
    </div>

    </div>
    </div>
    
  
</c:if>


<script>

const apvNo = ${approval.apvNo};
const apvKind = ${kind};
if(apvKind == '1') {
	var leavekind = document.getElementById('leaveKind').value ;
	} else {
		var leavekind = 0;
	}

const empNo = ${loginEmployee.empNo};

const fnDownload = () => {
	  $('.bx-download').on('click', (evt) => {
	    if (confirm('해당 첨부 파일을 다운로드 할까요?')) {
	      const attachNo = $(evt.currentTarget).parent().data('attach-no');
	      // alert(attachNo);
	      location.href = '${contextPath}/approval/download.do?attachNo='+attachNo;
	    }
	  });
	};
	
fnDownload();


const fnReWrite = () => {
	  $('#write').on('click', (evt) => {
	      location.href = '${contextPath}/approval/appWrite?apvNo=' + apvNo; 
	    
	  });
	};
	fnReWrite();
	
const fnDelete = () => {
	  $('#delete').on('click', (evt) => {
	      location.href = '${contextPath}/approval/appDelete?apvNo=' + apvNo; 
	    
	  });
	};
	fnDelete();
	
const fnRevoke = () => {
		  $('#revoke').on('click', (evt) => {
			  if (confirm('정말 철회하시겠습니까? 철회된 문서는 임시저장함으로 이동합니다')) {
		      location.href = '${contextPath}/approval/revoke.do?apvNo=' + apvNo +'&apvKind=' + apvKind; 
			  }
		  });
		};
		fnRevoke();

function sendGetRequest(queryParams) {
	 window.location.href = '${contextPath}/approval/approve.do?'+ new URLSearchParams(queryParams).toString();
}

function handlePopupFormSubmission(inputText) {
    const queryParams = { apvNo: apvNo, empNo:empNo, rejectedReason: inputText };
    sendGetRequest(queryParams);
}


document.getElementById('approve').addEventListener('click', function() {
    const queryParams = { apvNo: apvNo, empNo:empNo, rejectedReason:'0' , apvKind : apvKind, leavekind: leavekind };
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
