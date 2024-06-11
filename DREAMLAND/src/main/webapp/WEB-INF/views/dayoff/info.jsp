<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto}" />    

<jsp:include page="../layout/header.jsp" />  

<!-- moment.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>

  <ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="${contextPath}/work/status.do">근태관리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="${contextPath}/dayoff/info.do">휴가관리</a>
  </li>
</ul>

  <div class="container my-5 p-5 bg-white shadow rounded">
        <div class="row align-items-center mb-5">
        <!-- 프로필 사진 영역 -->
        <!--<div class="col-auto">
                <div class="avatar bg-secondary rounded-circle"></div>
            </div> -->
            <div class="col">
                <h2>${loginEmployee.empName}</h2>
                 <span class="badge rounded-pill bg-secondary">
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
            <div class="col-auto">
                <a class="btn btn-primary" href="${contextPath}/approval/appWrite?apvNo=000">연차신청</a>
            </div>
        </div>

        <hr>
        <div class="text-center mb-5">
             <h1 class="today mb-0"><fmt:formatDate value="${today}" pattern="yyyy.MM.dd"/></h1>
        </div>
        <div>
          <div class="row text-center mb-5">
              <div class="col"> 
                  <div class="stat-detail">
                    <span>총 연차</span>
                    <span class="fs-4">${totalDayOff}</span>
                  </div>
              </div>
              <div class="col">
                  <div class="stat-detail">
                    <span>사용 연차</span>
                    <span class="fs-4">${usedDayOff}</span>
                  </div>
              </div>
              <div class="col">
                  <div class="stat-detail">
                    <span>잔여 연차</span>
                    <span class="fs-4">${remainDayOff}</span>
                  </div>
              </div>
          </div>
        </div>

        <div>
		        <h4>사용내역</h4>
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
  <script>
  document.addEventListener('DOMContentLoaded', function () {
    // 오늘 날짜 생성
    const today = new Date().toISOString().split('T')[0];
    document.querySelector('.today').textContent = today;

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
            	  console.log(dayoff);
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
  });
  
</script>
    
<%@ include file="../layout/footer.jsp" %>    