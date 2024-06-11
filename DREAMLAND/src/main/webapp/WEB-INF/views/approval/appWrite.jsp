<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="./../layout/header.jsp" />  
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
        <h2>품의서</h2>
        <!-- 품의서 내용 -->
        <div class="container">
            <div class="title">품 의 서</div>
            <!--  <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">-->
           <div class="section">
                <div class="section-title">제목</div>
                        	<input type="text" style="width:750px;" name="title"  value="${title}"></input>
    <input type="hidden" name="temp" value="0">
    <input type="hidden" name="apvNo" id="apvNo" value="${approval.apvNo}">
            </div>
             <div class="section-title">결재자</div>
                  

     <button id="openOrgChartBtn" type="button">조직도 열기</button>
     <button id="resetBtn" type="button" style="display:none">지우기</button>
    <div id="orgChartModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div id="orgChart"></div>
        </div>
    </div>


   
    
                <table class="approval-table">
                <tr>
                    <td>담당</td>
                    <td>팀장</td>
                    <td>본부장</td>
                    <td>대표이사</td>
                </tr>
                <c:if test="${empty title}">
                                <tr id="selectedEmployeesRow">
                    <td><input type="text" name="approver" readonly="readonly" value="${loginEmployee.empName}"></input></td>
                </tr>
      
                </c:if>
                <c:if test="${not empty title}">

                  <tr id="selectedEmployeesRow">
                     <td><input type="text" name="approver" readonly="readonly" value="${loginEmployee.empName}"></input></td>
                    <c:if test="${not empty appovers.approver1}"><td><input type="text" name="approver2" value="${appovers.approver1}"></input></td></c:if>
                    <c:if test="${not empty appovers.approver2}"><td><input type="text" name="approver3" value="${appovers.approver2}"></input></td></c:if>
                    <c:if test="${not empty appovers.approver3}"><td><input type="text" name="approver4" value="${appovers.approver3}"></input></td></c:if>
                 </tr>
                </c:if>
                
            </table>
            <div class="section">
                <div class="section-title">참조자</div>
                <table class="input-table">
                    <tr>
                   <td>	<input type="text" style="width:750px;" name="referrer"  value="${referrer}"></input></td>
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
                <div class="today"></div>
                
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
            <input type="hidden" name="apvNo" value="${approval.apvNo}">
             <div class="section-title">결재자</div>
 
     <button id="openOrgChartBtn2" type="button">조직도 열기</button>
     <button id="resetBtn2" type="button"  style="display:none">지우기</button>

    <div id="orgChartModal2" class="modal">
        <div class="modal-content">
            <span class="close2">&times;</span>
            <div id="orgChart2"></div>
        </div>
    </div>

                <table class="approval-table">
                <tr>
                    <td>담당</td>
                    <td>팀장</td>
                    <td>본부장</td>
                    <td>대표이사</td>
                </tr>
                <c:if test="${empty title}">
                                <tr id="selectedEmployeesRow2">
                    <td><input type="text" name="approver" readonly="readonly" value="${loginEmployee.empName}"></input></td>
                </tr>
      
                </c:if>
                <c:if test="${not empty title}">
                  <tr id="selectedEmployeesRow2">
                     <td><input type="text" name="approver" readonly="readonly" value="${loginEmployee.empName}"></input></td>
                    <c:if test="${not empty appovers.approver1}"><td><input type="text" name="approver2" value="${appovers.approver1}"></input></td></c:if>
                    <c:if test="${not empty appovers.approver2}"><td><input type="text" name="approver3" value="${appovers.approver2}"></input></td></c:if>
                    <c:if test="${not empty appovers.approver3}"><td><input type="text" name="approver4" value="${appovers.approver3}"></input></td></c:if>
                 </tr>
                </c:if>
                
            </table>
            <div class="section">
                <div class="section-title">참조자</div>
                <table class="input-table">
                    <tr>
                   <td>	<input type="text" style="width:750px;" name="referrer" value="${referrer}"></input></td>
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
               					<td id="leave-details"><input type="date" name="leavestart" > ~ <input type="date" name="leaveend"  ></td>
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
                <div class="today"></div>        
                
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

var tdCount =0;


function fnToDay() {
	var today = new Date();

	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);

	var dateString = year + '년 ' + month  + '월 ' + day +'일      작성자:' + '${loginEmployee.empName}';
	   document.getElementsByClassName('today')[0].innerHTML = dateString;
	   document.getElementsByClassName('today')[1].innerHTML = dateString;
}



function fnTdcount() {
const selectedEmployeesRow = document.getElementById('selectedEmployeesRow');
tdCount = selectedEmployeesRow.getElementsByTagName('td').length +1;
}

document.addEventListener('DOMContentLoaded', function() {
	fnTdcount();
});

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
    const closeBtn2 = document.getElementsByClassName("close2")[0];
    const selectedEmployeesRow2 = document.getElementById("selectedEmployeesRow2");
    
    var data = [];
    
    
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
                data.push(node);
        		
        	})
        	console.log(data);
        		  resData.employeeList.forEach(item => {
          // jsTree 형식에 맞게 변환하여 data 배열에 추가
          let node = {
              "id": item.empNo+"",
              "text": item.empName,
              "parent" : item.deptNo+"",
              "icon": "bx bx-user"
          };
          data.push(node);
    });
        	     	console.log(data);
        	
        	
        	
        	
            $('#orgChart').jstree({
                'core': {
                    'data': data
                }
            });
        	
            $('#orgChart2').jstree({
                'core': {
                    'data': data
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
    resetBtn.onclick = function() {
    	  let firstChild = selectedEmployeesRow.firstElementChild;
        while (selectedEmployeesRow.lastElementChild && selectedEmployeesRow.lastElementChild !== firstChild) {
            selectedEmployeesRow.removeChild(selectedEmployeesRow.lastElementChild);
        }
        openOrgChartBtn.style.display = "inline-block";
        resetBtn.style.display = "none";
        tdCount=2;
    };
    resetBtn2.onclick = function() {
    	  let firstChild2 = selectedEmployeesRow2.firstElementChild;
        while (selectedEmployeesRow2.lastElementChild && selectedEmployeesRow2.lastElementChild !== firstChild2) {
            selectedEmployeesRow2.removeChild(selectedEmployeesRow2.lastElementChild);
        }
        openOrgChartBtn.style.display = "inline-block";
        resetBtn.style.display = "none";
        tdCount=2;
    };

    window.onclick = function(event) {
        if (event.target == orgChartModal2 || event.target == orgChartModal) {
            orgChartModal.style.display = "none";
            orgChartModal2.style.display = "none";
        }
    };
    $('#orgChart').on("select_node.jstree", function (e, data) {
        if (tdCount < 5) {
        	
        	if(data.node.parent == '#') {
        		return
        	}
            const name = data.node.text;
            const newCell = selectedEmployeesRow.insertCell();
            newCell.innerHTML = '<input type="text" name="approver' + tdCount+ '" value="'+name+'" ></input>'; // HTML 추가
            tdCount++;
            if (tdCount >= 5) {
                openOrgChartBtn.style.display = "none";
            resetBtn.style.display = "inline-block";
            } else {
                openOrgChartBtn.style.display = "inline-block";
            }
            orgChartModal.style.display = "none";
        }
    });
    $('#orgChart2').on("select_node.jstree", function (e, data) {
    	
    	
    	if(data.node.parent == '#') {
    		return
    	}
        if (tdCount < 5) {
            const name = data.node.text;
            const newCell = selectedEmployeesRow2.insertCell();
            newCell.innerHTML = '<input type="text" name="approver' + tdCount+ '" value="'+name+'" ></input>'; // HTML 추가
            tdCount++;
            if (tdCount >= 5) {
                openOrgChartBtn2.style.display = "none";
            resetBtn2.style.display = "inline-block";
            } else {
                openOrgChartBtn2.style.display = "inline-block";
            }
            orgChartModal2.style.display = "none";
        }
    });
    
    fnTdcount();
};

   // 반차 선택시 오전,오후 선택창 생성
   function updateLeaveForm() {
	   
	    $(document).on("change", "#leave-type", (e) => {
       var leaveType = document.getElementById("leave-type").value;
       var leaveDetails = document.getElementById("leave-details");

       if (leaveType == "1") { // 반차 selected
           leaveDetails.innerHTML   = '<input type="date" name="leavestart"> '; 
           leaveDetails.innerHTML   +=' <label><input type="radio" name="halfday" value="morning"> 오전</label>';
           leaveDetails.innerHTML   +=' <label><input type="radio" name="halfday" value="afternoon"> 오후</label>';
          
       } else { // 연차 selected
           leaveDetails.innerHTML = '<input type="date" name="leavestart"> ~'; 
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
           fnTdcount();
           while (selectedEmployeesRow.lastElementChild && selectedEmployeesRow.lastElementChild !== firstChild) {
               selectedEmployeesRow.removeChild(selectedEmployeesRow.lastElementChild);
           }
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
	fnAttachAdd();
	fnAttachCheck();
	fnAttachDel();
  fnAttachDelete();
  fnToDay();
</script>
   
    
<%@ include file="./../layout/footer.jsp" %>
