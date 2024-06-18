<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto}" />  
<%-- <%session.setAttribute("empNo", 2);%>  --%> 
    
<jsp:include page="../layout/header.jsp" />

<!-- css link -->
<link rel="stylesheet" href="/resources/assets/css/work_dayoff.css" />

<!-- flatpickr CDN -->  
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>  
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/l10n/ko.min.js"></script>
  
 <div class="container-xxl flex-grow-1 container-p-y">
  <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">근태 /</span> 근무관리</h4>
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link active" aria-current="page" href="${contextPath}/work/status.do">근무관리</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${contextPath}/dayoff/info.do">휴가관리</a>
    </li>
  </ul>

  <div class="card">
    <div class="card-header">
      <div class="col">
        <div class="work-name">
          <h3 class="card-title">${loginEmployee.empName}</h3>
        </div>
        <span class="work-deptNo badge rounded-pill bg-label-secondary">
          <c:choose>
            <c:when test="${loginEmployee.deptNo == 9999}">대표이사</c:when>
            <c:when test="${loginEmployee.deptNo == 1000}">인사팀</c:when>
            <c:when test="${loginEmployee.deptNo == 2000}">경영지원팀</c:when>
            <c:when test="${loginEmployee.deptNo == 3000}">안전관리팀</c:when>
            <c:when test="${loginEmployee.deptNo == 5000}">시설운영팀</c:when>
            <c:when test="${loginEmployee.deptNo == 6000}">마케팅팀</c:when>
          </c:choose>
        </span>
      </div>
    </div>
    <div class="work-today text-center mb-1">
      <h4 class="today mb-0"><fmt:formatDate value="${today}" pattern="yyyy.MM.dd"/></h4>
    </div>
  </div>

  <div class="work-info row mb-1">
    <div class="col-md">
      <div class="card mb-3">
        <div class="row g-0">
          <div class="col-md-8">
            <div class="card-body">
              <h5 class="card-title">근태 현황</h5>
              <p class="card-text">
                <p id="late_count">지각 <span id="lateCount" class="badge badge-center bg-label-danger">${lateCount}</span></p>
                <p id="absence_count">결근  <span id="absenceCount" class="badge badge-center bg-label-danger">${absenceCount}</span></p>
              </p>
              <div class="text-exp">
                <p class="card-text"><small class="text-muted">올해 기준으로 표시됩니다.</small></p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md">
      <div class="card mb-3">
        <div class="row g-0">
          <div class="col-md-8">
            <div class="card-body">
              <h5 class="card-title">근무 시간</h5>
              <p id="total_work_days">총 근무일수 : <span id="totalWorkDays">${totalWorkDays}</span>일</p>
              <p id="total_work_hours">총 근무시간 : <span id="totalWorkHours">${totalWorkHours}</span>시간</p>
              <p id="average_work_hours">평균 근무시간 : <span id="averageWorkHours">${avgWorkHours}</span>시간</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="card wrap-work-list">
    <div class="card-body">
      <h5>기간 설정</h5>
      <div class="input-group">
        <input type="text" id="dateRange" class="form-control">
        <button id="btn-search" class="btn btn-primary">조회</button>
      </div>
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
  </div>
</div>
<script>
 
 // 오늘 날짜 생성
 const fnGetToday = () => {
     const today = new Date().toISOString().split('T')[0];
     document.querySelector('.today').textContent = today;
 }

 
 // 근무 리스트 조회
 const fnWorkList = () => {
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
  };
    
  fnGetToday();
  fnWorkList();
  
 </script>

    
<%@ include file="../layout/footer.jsp" %>    