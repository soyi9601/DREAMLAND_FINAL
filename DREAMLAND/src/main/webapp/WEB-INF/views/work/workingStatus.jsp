<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto}" />  
<%-- <%session.setAttribute("empNo", 2);%>  --%> 
    
<jsp:include page="../layout/header.jsp" />

<!-- flatpickr CDN -->  
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>  
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/l10n/ko.min.js"></script>

<!-- moment.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>
  
  <style>
    .input-group {
        display: flex;
        align-items: center;
    }

    #dateRange {
        flex: 1;
        max-width: 230px;
    }

   /*  #btn-search {
        margin-left: 10px;
    }
 */
</style>
  
  <ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="${contextPath}/work/status.do">근태관리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="${contextPath}/dayoff/info.do">휴가관리</a>
  </li>
</ul>
  
   <div class="container mt-4">
     <h3 class="mb-3">올해 근무 정보</h3>
     
     <div class="row g-4 mb-5">
         <div class="col-md-6">
             <div class="p-3 border bg-light">
                 <h4>근태 현황</h4>
                 <p id="late_count">지각 : <span id="lateCount">${lateCount}</span>회</p>
                 <%-- <p id="early_leave_count">조기퇴근 : <span id="earlyLeaveCount">${earlyLeaveCount}</span>회</p> --%>
                 <p id="absence_count">결근 : <span id="absenceCount">${absenceCount}</span>회</p>
             </div>
         </div>
         <div class="col-md-6">
             <div class="p-3 border bg-light">
                 <h4>근무 시간</h4>
                 <p id="total_work_days">총 근무일수: <span id="totalWorkDays">${totalWorkDays}</span>일</p>
                 <p id="total_work_hours">총 근무시간: <span id="totalWorkHours">${totalWorkHours}</span>시간</p>
                 <p id="average_work_hours">평균 근무시간: <span id="averageWorkHours">${avgWorkHours}</span>시간</p>
             </div>
         </div>
     </div>
   </div>
   <div class="container mt-5">
	   <div class="row">
	     <div class="col-md-6">
	        <label for="dateRange">기간 설정</label>
	        <div class="input-group">
	           <input type="text" id="dateRange" class="form-control">
	           <button id="btn-search" class="btn btn-primary">조회</button>
	        </div>
	     </div>
	   </div>
       <!-- <div class="row">
          <div class="col-md-6">
              <label for="dateRange">기간 설정</label>
              <input type="text" id="dateRange" class="form-control"  style="width: 230px;">
          </div>
      </div>
      <div class="row mt-3">
          <div class="col-md-12">
              <button id="btn-search" class="btn btn-primary">조회</button>
          </div>
      </div> -->
      <div class="row mt-3">
          <div class="col-md-12">
              <table class="table table-striped" id="work-list">
                  <thead>
                      <tr>
                          <th>일자</th>
                          <th>출근시간</th>
                          <th>퇴근시간</th>
                          <th>총 근무시간</th>
                          <th>근무 상태</th>
                      </tr>
                  </thead>
                  <tbody>
                      <!-- 근무 리스트는 AJAX로 추가 -->
                  </tbody>
              </table>
          </div>
      </div>
   </div>
   <!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->
   <!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
   <script>
	   document.addEventListener('DOMContentLoaded', function () {
		      const enterDate = new Date("${employee.enterDate}"); // 입사일
	        const now = new Date();

	        flatpickr("#dateRange", {
	            mode: "range",
	            dateFormat: "Y-m-d",
	            locale: "ko", 
	            maxDate: now,
	            minDate: enterDate,
	            onChange: function (selectedDates) {
	                if (selectedDates.length === 2) {
	                    if (selectedDates[0] > selectedDates[1]) {
	                        alert("시작일은 종료일 이전이어야 합니다.");
	                        this.clear();
	                    }
	                }
	            }
	        });
	
	       $('#btn-search').on('click', function() {
	           const dateRange = $('#dateRange').val().split(' ~ ');
	           if (dateRange.length === 2) {
	               const startDate = dateRange[0];
	               const endDate = dateRange[1];
	               
	               $.ajax({
	                   type: 'GET',
	                   url: '${contextPath}/work/list.do',
	                   data: {
	                       startDate: startDate,
	                       endDate: endDate
	                   },
	                   success: (resData) => {
                  	   //  리스트 초기화
                  	   let workList = $('#work-list tbody');
                  	   workList.empty();
                  	   if(resData.workList.length === 0) {
                  		   workList.append('<tr><td colspan="5">조회할 목록이 없습니다.</td></tr>');
                  	   } else {
                             $.each(resData.workList, (i, work) => {
                            	 let str = '';
                                 str += '<tr>';
	                                 str += '<td>' + moment(work.workDate).format('YYYY-MM-DD') + '</td>';
	                                 str += '<td>' + (work.workIn ? moment(work.workIn).format('HH:mm:ss') : '') + '</td>';
	                                 str += '<td>' + (work.workOut ? moment(work.workOut).format('HH:mm:ss') : '') + '</td>';
	                                 str += '<td>' + work.workTotalTime + '시간</td>';
	                                 str += '<td>' + getWorkState(work.workState) + '</td>';
                                 str += '</tr>';
                                 workList.append(str);
                                 console.log(work.workIn);
                                 console.log(typeof work.workIn);
                                 console.log(work.workOut);
                                 console.log(work.workTotalTime);
                             });
                         }
                     },
                     error: function(jqXHR) {
                         alert(jqXHR.statusText + '(' + jqXHR.status + ')');
                     }
                 });
             } else {
                 alert('기간을 정확히 설정해주세요.');
             }
         });
	
	       function getWorkState(workState) {
	           switch (workState) {
	               case '10': return '정상출근';
	               //case '20': return '조기퇴근';
	               case '20': return '반차';
	               case '30': return '연차';
	               case '40': return '결근';
	               default: return '알 수 없음';
	           }
	       }
	   });
      
   </script>

    
<%@ include file="../layout/footer.jsp" %>    