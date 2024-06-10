<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto}" />    

<jsp:include page="../layout/header.jsp" />  

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
            <div class="col-auto">
                <div class="avatar bg-secondary rounded-circle"></div>
            </div>
            <div class="col">
                <h2>${loginEmployee.empName}</h2>
                <span class="badge rounded-pill bg-secondary">${loginEmployee.deptName}</span>
            </div>
            <div class="col-auto">
                <button type="button" class="btn btn-primary">연차신청</button>
            </div>
        </div>

        <hr>
        <div class="text-center mb-5">
            <h1 class="display-7 mb-0">2024.06.05</h1>
        </div>
        <div>
          <div class="row text-center mb-5">
              <div class="col"> 
                  <div class="stat-detail">
                    <span>총 연차</span>
                    <span class="fs-4">${loginEmployee.dayOff}</span>
                  </div>
              </div>
              <div class="col">
                  <div class="stat-detail">
                    <span>사용 연차</span>
                    <span class="fs-4">10</span>
                  </div>
              </div>
              <div class="col">
                  <div class="stat-detail">
                    <span>잔여 연차</span>
                    <span class="fs-4">5</span>
                  </div>
              </div>
          </div>
        </div>

        <div>
            <h4>사용내역</h4>
            <select class="form-select w-auto mb-3">
                <option>Select year</option>
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
                <tbody>
                    <tr>
                        <td>연차</td>
                        <td>01-15 ~ 01-15</td>
                        <td>1</td>
                        <td>개인사정</td>
                    </tr>
                    <tr>
                        <td>반차</td>
                        <td>01-15 ~ 01-15</td>
                        <td>0.5</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>연차</td>
                        <td>01-15 ~ 01-15</td>
                        <td>1</td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

  <script>
  
  </script>  
    
<%@ include file="../layout/footer.jsp" %>    