<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto}" />    

<jsp:include page="../layout/header.jsp" />
  
<!-- css link -->
<link rel="stylesheet" href="/resources/assets/css/work_dayoff.css" />
 
 <div class="container-xxl flex-grow-1 container-p-y">
  <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">근태 /</span> 휴가관리</h4>
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link" aria-current="page" href="${contextPath}/work/status.do">근태관리</a>
    </li>
    <li class="nav-item">
      <a class="nav-link active" href="${contextPath}/dayoff/info.do">휴가관리</a>
    </li>
  </ul>

  <div class="card">
    <div class="card-header">
      <div class="col">
        <div class="work-name">
          <h3 class="card-title">${loginEmployee.empName}</h3>
        </div>
        <span class="work-deptNo badge rounded-pill bg-label-secondary">${department.deptName}</span>
      </div>
      <div class="col-auto">
        <a class="btn btn-outline-primary" href="${contextPath}/approval/appWrite?apvNo=000">연차신청</a>
      </div>
    </div>
    <div class="text-center mb-1">
      <h4 class="today mb-0"><fmt:formatDate value="${today}" pattern="yyyy.MM.dd"/></h4>
    </div>
    <hr>
    <div class="card-body">
      <div class="row text-center mb-5">
        <div class="col">
          <div class="stat-detail">
            <h5>총 연차</h5>
          </div>
          <span class="fs-6 badge rounded-pill bg-primary">${totalDayOff}</span>
        </div>
        <div class="col">
          <div class="stat-detail">
            <h5>사용 연차</h5>
          </div>
          <span class="fs-6 badge rounded-pill bg-primary">${usedDayOff}</span>
        </div>
        <div class="col">
          <div class="stat-detail">
            <h5>잔여 연차</h5>
          </div>
          <span class="fs-6 badge rounded-pill bg-primary">${remainDayOff}</span>
        </div>
      </div>
    </div>
  </div>
  <div class="card wrap-list">
    <div class="card-body">
      <h5>사용내역</h5>
      <select id="year-select" class="form-select w-auto mb-3">
        <option>Select year</option>
        <c:forEach var="year" items="${yearList}">
          <option value="${year}">${year}</option>
        </c:forEach>
      </select>
      <table class="table">
        <thead>
          <tr>
            <th>연차종류</th>
            <th>사용기간</th>
            <th>사용연차</th>
            <th>사유</th>
          </tr>
        </thead>
        <tbody id="dayoff-list">
          <!-- 휴가 리스트는 AJAX로 추가 -->
        </tbody>
      </table>
    </div>
  </div>
</div>
<script>
  
  // 오늘 날짜 생성
  const fnGetToday = () => {
      const today = new Date().toISOString().split('T')[0];
      document.querySelector('.today').textContent = today;
  }

  // 휴가 리스트 조회
  const fnDayoffList = () => {
    const yearSelect = document.getElementById('year-select');
    const dayoffListTable = document.getElementById('dayoff-list');

    yearSelect.addEventListener('change', function() {
      const selectedYear = yearSelect.value;

      if (selectedYear) {
        fetch(`${contextPath}/dayoff/list.do?year=` + selectedYear)
          .then(response => response.json())
          .then(resData => {
            const dayoffList = resData.dayoffList;
            dayoffListTable.innerHTML = '';  // 초기화

            if (dayoffList.length === 0) {
              dayoffListTable.innerHTML = '<tr><td colspan="5">조회할 목록이 없습니다.</td></tr>';
            } else {
              dayoffList.forEach(dayoff => {
                let str = '';
                str += '<tr>';
                str += '<td>' + (dayoff.leaveClassify == 1 ? '반차' : '연차') + '</td>';
                str += '<td>' + moment(dayoff.leaveStart).format('YYYY-MM-DD') + ' ~ ' +  moment(dayoff.leaveEnd).format('YYYY-MM-DD') + '</td>';
                str += '<td>' + (dayoff.leaveClassify == 1 ? '0.5' : '1') + '</td>';
                str += '<td>' + dayoff.detail + '</td>';
                str += '</tr>';
                dayoffListTable.insertAdjacentHTML('beforeend', str);
              });
            }
          })
         .catch(error => console.log(error));
       }
    });
  };
  
  fnGetToday();
  fnDayoffList();
  
</script>
    
<%@ include file="../layout/footer.jsp" %>    