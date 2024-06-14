<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="./../layout/apv-header.jsp" />  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>

<div class="container-xxl flex-grow-1 container-p-y">
<div class="pv-col-6 mb-4" style="width:100%; height:100%; display: flex;
            justify-content: center;
            align-items: center; ">
                           <div class="post-list-container">

  <c:if test="${not empty title}">
<input type="hidden" id="kind" value="${kind}">
<c:if test="${kind ==0 }">
<body onload="showPage('approvalForm')"></body>
    </c:if>
    <c:if test="${kind ==1 }">
<body onload="showPage('leaveRequestForm')"></body>
    </c:if>
</c:if>

         <div id="container">

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
       
        <!-- 품의서 내용 -->
        <div class="apv-container">
         <h2 class="text-nowrap mb-2 text-primary">품의서</h2>
          <br>
            <!--  <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">-->
           <div class="section">
                <div class="section-title">제목</div>
                        	<input type="text" style=" width:970px;" name="title" id="title"  value="${title}"></input>
    <input type="hidden" name="temp" value="0">
    <input type="hidden" name="apvNo" id="apvNo" value="${approval.apvNo}">
            </div>
          <div class="section">
             <div class="section-title">결재자</div>
                   
     <button id="openOrgChartBtn" type="button" class="btn btn-outline-primary">조직도 열기</button>
     <button id="resetBtn" type="button"  class="btn btn-outline-secondary" >지우기</button>
    <div id="orgChartModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div id="orgChart"></div>
        </div>
    </div>
 
                <table class="approval-table">
                 <tr id="selectedPositiionRow">
                    <td>담당</td>
                    
                  <c:if test="${not empty title}">
                  <c:if test="${not empty appovers.approver1}"><td>${appovers.approverPosName1}</td></c:if>
                  <c:if test="${not empty appovers.approver2}"><td>${appovers.approverPosName2}</td></c:if>
                  <c:if test="${not empty appovers.approver3}"><td>${appovers.approverPosName3}</td></c:if>
                  </c:if>
     
                </tr>
                <c:if test="${empty title}">
                <tr id="selectedEmployeesRow">
                    <td><input type="text" name="approver" readonly="readonly"  class="approvers" value="${loginEmployee.empName}"></input></td>
                </tr>
                </c:if>
                <c:if test="${not empty title}">
                  <tr id="selectedEmployeesRow">
                     <td><input type="text" name="approver" readonly="readonly" class="approvers" value="${loginEmployee.empName}"></input></td>
                    <c:if test="${not empty appovers.approver1}"><td><input type="text"  class="approvers" name="approver2" value="${appovers.approver1}"></input></td></c:if>
                    <c:if test="${not empty appovers.approver2}"><td><input type="text" class="approvers" name="approver3" value="${appovers.approver2}"></input></td></c:if>
                    <c:if test="${not empty appovers.approver3}"><td><input type="text" class="approvers" name="approver4" value="${appovers.approver3}"></input></td></c:if>
                 </tr>
                </c:if>
                
            </table>
            
            </div>
            <div class="section">
                <div class="section-title">참조자</div>
                    <button id="openOrgChartBtn3" type="button" class="btn btn-outline-primary">조직도 열기</button>
     								<button id="resetBtn3" type="button"   class="btn btn-outline-secondary" >지우기</button>
    								<div id="orgChartModal3" class="modal">
        						<div class="modal-content">
          				  <span class="close">&times;</span>
           					<div id="orgChart3"></div>
        						</div>
    								</div>
                
                		<br>
                   	<input type="text" style=" width:967px;" name="referrer" id="referrer" value="${referrer}"></input>
            </div>
            <div class="section">
                <div class="section-title">품의 내용 및 상세내역</div>
                            <textarea class="textarea" name="contents"  id="contents" >${approval.detail}</textarea>
            </div>
            	<div class="footer">
              위와 같은 사유로 품의서를 제출하오니 허가하여 주시기 바랍니다.<br>
                     <br>
                     <c:if test="${empty title}">
                <div class="today"></div>        
                </c:if>
                     <c:if test="${not empty title}">
                          <div>     ${ApvDate} 작성자 : ${loginEmployee.empName}</div>
                </c:if>
                </div>
            <br>
            <div class="button-container">
														<div class="row mb-3">
																<div class="col-sm-10 notice-input-area">
																		<c:forEach items="${attachList}" var="attach">
																		  <div class="attach"   data-attach-no="${attach.attachNo}">
																		    ${attach.originalFilename} <i class='bx bx-x' id ="attachDelete"></i>
																		  </div>
																		</c:forEach>
																	  <div>
																	    	<c:if test="${not empty title}">
																	  	<c:if test="${empty attachList}">
																		    <div>첨부 없음</div>
																		  </c:if>
																		    	</c:if>
																    </div>
																</div>

  <div>
    <input type="file" name="files" id="files" multiple>
  </div>
    <div id="attach-list"></div>
														</div>
            </div>
        </div>
              <button  class="btn btn-primary justify-content-sm-center" id="submitBtn1">임시저장</button>
              <button  class="btn btn-primary justify-content-sm-center"type="submit">제출하기</button>
        </form>
    </div>
    
    <div id="leaveRequestForm" class="page">
      <form   id="myForm2" method="POST"
		enctype="multipart/form-data"
        action="${contextPath}/approval/leave.do">
        <!-- 휴가신청서 내용 -->
        <div class="apv-container">
           <h2 class="text-nowrap mb-2 text-primary">휴가신청서</h2>
           <br>
            <div class="section">
                            <div class="section-title">제목</div>
                        	<input type="text" style="width:967px;" name="title"  id="title2"  value="${title}"></input>
         <input type="hidden" name="temp" value="0">
            <input type="hidden" name="apvNo" value="${approval.apvNo}">
            </div>
            
              <div class="section">
             <div class="section-title">결재자</div>
 
     <button id="openOrgChartBtn2" type="button" class="btn btn-outline-primary">조직도 열기</button>
     <button id="resetBtn2" type="button" class="btn btn-outline-secondary">지우기</button>

    <div id="orgChartModal2" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div id="orgChart2"></div>
        </div>
    </div>

                <table class="approval-table">
                 <tr id="selectedPositiionRow2">
                    <td>담당</td>
                    
                  <c:if test="${not empty title}">
                  <c:if test="${not empty appovers.approver1}"><td>${appovers.approverPosName1}</td></c:if>
                  <c:if test="${not empty appovers.approver2}"><td>${appovers.approverPosName2}</td></c:if>
                  <c:if test="${not empty appovers.approver3}"><td>${appovers.approverPosName3}</td></c:if>
                  </c:if>
     
                <c:if test="${empty title}">
                                <tr id="selectedEmployeesRow2">
                    <td><input type="text" name="approver" readonly="readonly"  class="approvers2" value="${loginEmployee.empName}"></input></td>
                </tr>
      
                </c:if>
                <c:if test="${not empty title}">
                  <tr id="selectedEmployeesRow2">
                     <td><input type="text" name="approver" readonly="readonly" class="approvers2" value="${loginEmployee.empName}"></input></td>
                    <c:if test="${not empty appovers.approver1}"><td><input type="text" class="approvers2" name="approver2" value="${appovers.approver1}"></input></td></c:if>
                    <c:if test="${not empty appovers.approver2}"><td><input type="text" class="approvers2" name="approver3" value="${appovers.approver2}"></input></td></c:if>
                    <c:if test="${not empty appovers.approver3}"><td><input type="text"  class="approvers2" name="approver4" value="${appovers.approver3}"></input></td></c:if>
                 </tr>
                </c:if>
                
            </table>
            </div>
            <div class="section">
                 <div class="section-title">참조자</div>
                    <button id="openOrgChartBtn4" type="button"  class="btn btn-outline-primary" >조직도 열기</button>
     								<button id="resetBtn4" type="button"  class="btn btn-outline-secondary">지우기</button>
    								<div id="orgChartModal4" class="modal">
        						<div class="modal-content">
          				  <span class="close">&times;</span>
           					<div id="orgChart4"></div>
        						</div>
    								</div>
    								<br>
                   <input type="text" style="width:967px;" id="referrer2" name="referrer" value="${referrer}"></input>
            </div>
            
            <table class="input-table">
            
             <div class="section-title">휴가 상세 및 사유</div>
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
                       <c:if test="${approval.leaveClassify ==0}">
                    <td id="leave-details"><input type="date" name="leavestart" value="${approval.leaveStart}"> ~  <input type="date" name="leaveend" value="${approval.leaveEnd}"></td>
               				

               					</c:if>
               					                       <c:if test="${approval.leaveClassify ==1}">
                    <td id="leave-details"><input type="date" name="leavestart" value="${approval.leaveStart}">
                                   					  <c:if test="${approval.halfday == 'morning'}">
               					          <label><input type="radio" name="halfday" value="morning" checked> 오전 </label>
                                 <label><input type="radio" name="halfday" value="afternoon"> 오후</label>
                           </c:if>
               					  <c:if test="${approval.halfday == 'afternoon'}">
               					          <label><input type="radio" name="halfday" value="morning"> 오전 </label>
                                 <label><input type="radio" name="halfday" value="afternoon" checked> 오후</label>
               					  
               					  </c:if> </td>
               					
               					</c:if>         					
               					</c:if>
               					
               					
               					 <c:if test="${empty title}">
               					<td id="leave-details"><input type="date"  id="leaveDate"  name="leavestart" > ~ <input type="date" name="leaveend"  ></td>
                         </c:if>                  
               	 </tr>
                <tr>
                    <td>사유</td>
                    <td>
                        <textarea class="textarea" name="contents"  id="contents2" >${approval.detail}</textarea>
                    </td>
                </tr>
            </div>
            </table>
             	<div class="footer">
                위와 같은 사유로 휴가를 신청하오니 허가하여 주시기 바랍니다.<br>
                     <br>
                     <c:if test="${empty title}">
                <div class="today"></div>        
                </c:if>
                     <c:if test="${not empty title}">
                          <div>     ${ApvDate} 작성자 :${loginEmployee.empName}</div>
                </c:if>
                </div>
               <br>
        <div class="button-container">
   														<div class="row mb-3">
																<div class="col-sm-10 notice-input-area">
																		<c:forEach items="${attachList}" var="attach">
																		  <div class="attach"   data-attach-no="${attach.attachNo}">
																		    ${attach.originalFilename} <i class='bx bx-x' id ="attachDelete"></i>
																		  </div>
																		</c:forEach>
																	  <div>
																	    	<c:if test="${not empty title}">
																	  	<c:if test="${empty attachList}">
																		    <div>첨부 없음</div>
																		  </c:if>
																		    	</c:if>
																    </div>
																</div>
    <input type="file" name="files" id="files" multiple>
  </div>
    <div id="attach-list"></div>
														</div>
            </div>
              <button  class="btn btn-primary justify-content-sm-center" id="submitBtn2">임시저장</button>
              <button  class="btn btn-primary justify-content-sm-center" type="submit">제출하기</button>
        </div>
        </form>
    </div>
  </div>
  </div>
</div>



<script>

var tdCount =2;

const posName = {  '10':'사원',
		'20': '주임',
		'30' : '대리',
		 '40' : '과',
		 '50' :'부장',
		 '60' :'팀장',
		 '100': '대표이사' }



const fnRegisterUpload = () => {
	document.getElementById('myForm').addEventListener('submit', (evt) => {
		
		const row = document.getElementById('selectedEmployeesRow');
		const cells = row.getElementsByTagName('td');
		const cellCount = cells.length;
		
		if(document.getElementById('title').value === '' ) {
			alert('제목은 필수입니다.');
			evt.preventDefault();
			return;
		} else if(cellCount == 1 ) {
			alert('결재자를 선택해주세요');
			evt.preventDefault();
			return;
		}
		else if(document.getElementById('contents').value === '' ) {
			alert('내용은 필수입니다.');
			evt.preventDefault();
			return;
		} 
	})
	document.getElementById('myForm2').addEventListener('submit', (evt) => {
		
		const row = document.getElementById('selectedEmployeesRow2');
		const cells = row.getElementsByTagName('td');
		const cellCount = cells.length;
	  var leaveTypePick = document.getElementById("leave-type").value;
	  var leaveType;
	  if(leaveTypePick ==0) {
		  
		  leaveType = 'leaveDate';
	  } else {
		  leaveType ='leaveDate2';
	  }
		
		if(document.getElementById('title2').value === '' ) {
			alert('제목은 필수입니다.');
			evt.preventDefault();
			return;
		}else if(cellCount == 1 ) {
			alert('결재자를 선택해주세요.');
			evt.preventDefault();
			return;
		}else if(document.getElementById(leaveType).value === '') {
			alert('날짜를 입력해주세요.');
			evt.preventDefault();
			return;
			
		} else if(document.getElementById('contents2').value === '' ) {
			alert('내용은 필수입니다.');
			evt.preventDefault();
			return;
		} 
	})
}
		 
		 
function fnTdcount1(tag) {
	tdCount = tag.getElementsByTagName('td').length +1;
	}
	
document.addEventListener('DOMContentLoaded', function() {
	var a;
	
	if(document.getElementById('kind').value == 0) {
		 a=document.getElementById('selectedEmployeesRow');
		
	} else if(document.getElementById('kind').value == 1){
		a= document.getElementById('selectedEmployeesRow2');
	}
	fnTdcount1(a);
});


function fnToDay() {
	var today = new Date();

	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);

	var dateString = year + '년 ' + month  + '월 ' + day +'일      작성자:' + '${loginEmployee.empName}';
	   document.getElementsByClassName('today')[0].innerHTML = dateString;
	   document.getElementsByClassName('today')[1].innerHTML = dateString;
}





// jstree
function fnJstree() {
    const openOrgChartBtn = document.getElementById("openOrgChartBtn");
    const resetBtn = document.getElementById("resetBtn");
    const orgChartModal = document.getElementById("orgChartModal");
    const closeBtn = document.getElementsByClassName("close")[0];
    const selectedEmployeesRow = document.getElementById("selectedEmployeesRow");
    const openOrgChartBtn2 = document.getElementById("openOrgChartBtn2");
    const resetBtn2 = document.getElementById("resetBtn2");
    const orgChartModal2 = document.getElementById("orgChartModal2");
    const closeBtn2 = document.getElementsByClassName("close")[1];
    const selectedEmployeesRow2 = document.getElementById("selectedEmployeesRow2");

    
    const openOrgChartBtn3 = document.getElementById("openOrgChartBtn3");
    const resetBtn3 = document.getElementById("resetBtn3");
    const orgChartModal3 = document.getElementById("orgChartModal3");
    const closeBtn3 = document.getElementsByClassName("close")[2];
    const referrer = document.getElementById("referrer");
    const openOrgChartBtn4 = document.getElementById("openOrgChartBtn4");
    const resetBtn4 = document.getElementById("resetBtn4");
    const orgChartModal4 = document.getElementById("orgChartModal4");
    const closeBtn4 = document.getElementsByClassName("close")[3];
    const referrer2 = document.getElementById("referrer2");
    
    const selectedPositiionRow = document.getElementById("selectedPositiionRow");
    const selectedPositiionRow2 = document.getElementById("selectedPositiionRow2");
    
    const approvers = document.getElementsByClassName("approvers");
    const approvers2 = document.getElementsByClassName("approvers2");
 
 
    
    var Edata = [];
    
    
    $.ajax({
        url: '${contextPath}/approval/employeeList.do',
        type: 'GET',
        dataType: 'json',
        success: (resData) => {
        	
        	resData.departmentList.forEach(item => {
                let node = {
                        "id": item.deptNo+"",
                        "text": item.deptName+"",
                        "parent" : "#"
                    }
                Edata.push(node);
        		
        	})
        	console.log(Edata);
        		  resData.employeeList.forEach(item => {
          // jsTree 형식에 맞게 변환하여 data 배열에 추가
          let node = {
              "id": item.empNo+"",
              "text": item.empName + " " + posName[item.posNo] ,
              "parent" : item.deptNo+"",
              "icon": "bx bx-user",
               "data": { "rank": item.posNo+"" ,
            	            "name": item.empName+"" }
          };
          Edata.push(node);
    });
        	     	console.log(Edata);
        	
        	
        	
        	
            $('#orgChart').jstree({
                'core': {
                    'data': Edata
                }
            });
        	
            $('#orgChart2').jstree({
                'core': {
                    'data': Edata
                }
            });
            $('#orgChart3').jstree({
                'core': {
                    'data': Edata
                }
            });
        	
            $('#orgChart4').jstree({
                'core': {
                    'data': Edata
                }
            });
            },
        	
       
        error: (jqXHR) => {
            alert(jqXHR.statusText + '(' + jqXHR.status + ')');
        }
    });

    
    if (tdCount >= 5) {
        openOrgChartBtn.style.display = "none";
        openOrgChartBtn2.style.display = "none";
        
    }

    openOrgChartBtn.onclick = function() {
        orgChartModal.style.display = "block";
    };

    closeBtn.onclick = function() {
        orgChartModal.style.display = "none";
    };


    openOrgChartBtn2.onclick = function() {
        orgChartModal2.style.display = "block";
    };

    closeBtn2.onclick = function() {
        orgChartModal2.style.display = "none";
    };
    
    openOrgChartBtn3.onclick = function() {
        orgChartModal3.style.display = "block";
    };

    closeBtn3.onclick = function() {
        orgChartModal3.style.display = "none";
    };


    openOrgChartBtn4.onclick = function() {
        orgChartModal4.style.display = "block";
    };

    closeBtn4.onclick = function() {
        orgChartModal4.style.display = "none";
    };
	
    resetBtn.onclick = function() {
    	  let firstChild = selectedEmployeesRow.firstElementChild;
    	  let firstChild2 = selectedPositiionRow.firstElementChild;
        while (selectedEmployeesRow.lastElementChild && selectedEmployeesRow.lastElementChild !== firstChild) {
            selectedEmployeesRow.removeChild(selectedEmployeesRow.lastElementChild);
        }
        while (selectedPositiionRow.lastElementChild && selectedPositiionRow.lastElementChild !== firstChild2) {
        	selectedPositiionRow.removeChild(selectedPositiionRow.lastElementChild);
        }
        tdCount=2;
        openOrgChartBtn.style.display = "inline-block";
    };
    resetBtn2.onclick = function() {
    	  let firstChild = selectedEmployeesRow2.firstElementChild;
       	  let firstChild2 = selectedPositiionRow2.firstElementChild;
          while (selectedEmployeesRow2.lastElementChild && selectedEmployeesRow2.lastElementChild !== firstChild) {
              selectedEmployeesRow2.removeChild(selectedEmployeesRow2.lastElementChild);
          }
          while (selectedPositiionRow2.lastElementChild && selectedPositiionRow2.lastElementChild !== firstChild2) {
          	selectedPositiionRow2.removeChild(selectedPositiionRow2.lastElementChild);
          }
        tdCount=2;
        openOrgChartBtn2.style.display = "inline-block";
    };
    
    resetBtn3.onclick = function() {
    	referrer.value = '';

    };
    
    resetBtn4.onclick = function() {
       	referrer2.value = '';
    };

    window.onclick = function(event) {
        if (event.target == orgChartModal2 || event.target == orgChartModal || event.target == orgChartModal3 || event.target == orgChartModal4) {
            orgChartModal.style.display = "none";
            orgChartModal2.style.display = "none";
            orgChartModal3.style.display = "none";
            orgChartModal4.style.display = "none";
        }
    };
    $('#orgChart').on("select_node.jstree", function (e, data) {
    	
        if (tdCount < 5) {
        	
        	if(data.node.parent == '#') {
        		return
        	}
        	
     
        	
        	 var selectedNode = $('#orgChart').jstree().get_node(data.node.id);
        	if( +(selectedNode.data.rank) <= +(Object.values(Edata).find(item => item.data && item.data.name === approvers[tdCount-2].value).data.rank) ) {
        		alert("이전 결재자보다 직급이 높은 사원을 선택하십시오");
        		return
        		
        	}
            const name = data.node.data.name;
            const pos = posName[selectedNode.data.rank];
            const newCell = selectedEmployeesRow.insertCell();
            const newCell2 = selectedPositiionRow.insertCell();
            newCell.innerHTML = '<input type="text" class="approvers" name="approver' + tdCount+ '" value="'+name+'" ></input>'; // HTML 추가
            newCell2.innerHTML = pos; // HTML 추가
            tdCount++;
            if (tdCount >= 5) {
                openOrgChartBtn.style.display = "none";
            resetBtn.style.display = "inline-block";
            } else {
                openOrgChartBtn.style.display = "inline-block";
            }
        }
    });
    $('#orgChart2').on("select_node.jstree", function (e, data) {
    	   const approvers = document.getElementsByClassName("approvers");
    	    const approvers2 = document.getElementsByClassName("approvers2");
    	
    	
    	if(data.node.parent == '#') {
    		return
    	}
    	
   	 var selectedNode = $('#orgChart2').jstree().get_node(data.node.id);
 	if( +(selectedNode.data.rank) <= +(Object.values(Edata).find(item => item.data && item.data.name === approvers2[tdCount-2].value).data.rank) ) {
		alert("이전 결재자보다 직급이 높은 사원을 선택하십시오");
		return
		
	}
        if (tdCount < 5) {
            const name = data.node.data.name;
            const pos = posName[selectedNode.data.rank];
            const newCell = selectedEmployeesRow2.insertCell();
            const newCell2 = selectedPositiionRow2.insertCell();
            newCell.innerHTML = '<input type="text" class="approvers2" name="approver' + tdCount+ '" value="'+name+'" ></input>'; // HTML 추가
            newCell2.innerHTML = pos; // HTML 추가
            tdCount++;
            if (tdCount >= 5) {
                openOrgChartBtn2.style.display = "none";
            resetBtn2.style.display = "inline-block";
            } else {
                openOrgChartBtn2.style.display = "inline-block";
            }
        }
    });
    $('#orgChart3').on("select_node.jstree", function (e, data) {
    	
    	
    	if(data.node.parent == '#') {
    		return
    	}
    
             const name = data.node.data.name;
            referrer.value += name+ ' ';


        
    });
    
    
    $('#orgChart4').on("select_node.jstree", function (e, data) {
    	
    	
    	if(data.node.parent == '#') {
    		return
    	}
    
         	const name = data.node.data.name;
            referrer2.value += name+ ' ';

        
    });
    
};

   // 반차 선택시 오전,오후 선택창 생성
   function updateLeaveForm() {
	   
	    $(document).on("change", "#leave-type", (e) => {
       var leaveType = document.getElementById("leave-type").value;
       var leaveDetails = document.getElementById("leave-details");

       if (leaveType == "1") { // 반차 selected
           leaveDetails.innerHTML   = '<input type="date" id="leaveDate2" name="leavestart"> '; 
           leaveDetails.innerHTML   +=' <label><input type="radio" name="halfday" value="morning" checked> 오전</label>';
           leaveDetails.innerHTML   +=' <label><input type="radio" name="halfday" value="afternoon"> 오후</label>';
          
       } else { // 연차 selected
           leaveDetails.innerHTML = '<input type="date" id="leaveDate" name="leavestart"> ~'; 
           leaveDetails.innerHTML  +=' <input type="date" name="leaveend">';
       }})
   }
   
   
   // 
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
           let firstChild = selectedEmployeesRow.firstElementChild;
           let firstChild2 = selectedEmployeesRow2.firstElementChild;
           let firstChild3 = selectedPositiionRow.firstElementChild;
     	     let firstChild4 = selectedPositiionRow2.firstElementChild;
         
           $('#pageSelector').change(function(event) {
        	   tdCount =2;
           while (selectedEmployeesRow.lastElementChild && selectedEmployeesRow.lastElementChild !== firstChild) {
               selectedEmployeesRow.removeChild(selectedEmployeesRow.lastElementChild);
           }
           while (selectedEmployeesRow2.lastElementChild && selectedEmployeesRow2.lastElementChild !== firstChild2) {
               selectedEmployeesRow2.removeChild(selectedEmployeesRow2.lastElementChild);
           }
           
           while (selectedPositiionRow.lastElementChild && selectedPositiionRow.lastElementChild !== firstChild3) {
           	selectedPositiionRow.removeChild(selectedPositiionRow.lastElementChild);
           }
           while (selectedPositiionRow2.lastElementChild && selectedPositiionRow2.lastElementChild !== firstChild4) {
             	selectedPositiionRow2.removeChild(selectedPositiionRow2.lastElementChild);
             }
           });
       });
       document.getElementById(pageId).classList.add('active');
   }
   

   var fileNo = 0;
   var filesArr = new Array();

   
   const fnAttachCheck = () => {
	   document.getElementById('files').addEventListener('change', (evt) => {
	     const limitPerSize = 1024 * 1024 * 10;
	     const limitTotalSize = 1024 * 1024 * 100;
	     let totalSize = 0;
	     const files = evt.target.files;
	     const attachList = document.getElementById('attach-list');
	     attachList.innerHTML = '';
	     
	     if(files.length >5) {
	         alert('첨부파일은 최대 5개까지 입니다.');
	         evt.target.value = '';
	         attachList.innerHTML = '';
	         return;
	     }
	     
	     for(let i = 0; i < files.length; i++){
	       if(files[i].size > limitPerSize){
	         alert('각 첨부 파일의 최대 크기는 10MB입니다.');
	         evt.target.value = '';
	         attachList.innerHTML = '';
	         return;
	       }
	       totalSize += files[i].size;
	       if(totalSize > limitTotalSize){
	         alert('전체 첨부 파일의 최대 크기는 100MB입니다.');
	         evt.target.value = '';
	         attachList.innerHTML = '';
	         return;
	       }
	       attachList.innerHTML += '<div>' + files[i].name +'</div>';
	     }
	   })
	 }


   const fnAttachDelete = () => {
       // attachDelete 태그 클릭 이벤트 핸들러
       $(document).on("click", "#attachDelete", function() {
           // 클릭된 태그의 부모 태그에서 attach-no 데이터 속성 값을 가져옴
           var attachNo = $(this).parent().data("attach-no");
           var apvNo =  $("#apvNo").val();
           var parentElement = $(this).parent();
           alert(attachNo);

           // Ajax 요청
           $.ajax({
               url: '${contextPath}/approval/deleteAttach.do',
               type: 'GET',
               data: { attachNo: attachNo, apvNo: apvNo },
               dataType: 'json',
               success: (resData) => {
                   console.log("삭제 성공:", resData);
                   parentElement.remove();
               },
               error: (jqXHR) => {
                   alert(jqXHR.statusText + '(' + jqXHR.status + ')');
               }
           });
       });
   }
   
 



   // Initialize to show the first page
  showPage('approvalForm');
  fnJstree();
  updateLeaveForm();
  fnRegisterUpload();
	fnAttachCheck();
	fnAttachDelete();
  fnAttachDelete();
  fnToDay();
</script>
   
    
<%@ include file="./../layout/footer.jsp" %>
