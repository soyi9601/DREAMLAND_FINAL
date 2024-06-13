<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="./layout/header.jsp" />  

<!-- Content wrapper -->
<div class="content-wrapper">
 <!-- Content -->
	<div class="container-xxl flex-grow-1 container-p-y">
	  <div class="row">
	    <div class="col-lg-6">
		    <div class="row">
			    <div class="col-6 mb-4">
					  <h2 class="py-3 mb-4">
						  안녕하세요. <span class="user-name">${emp.empName}</span>님
						</h2>	    
			    </div>
			    
			    <div class="col-6 mb-4 py-3">
			      <c:choose>
	            <c:when test="${emp.role == 'ROLE_ADMIN'}">
	              <input id="empNo" type="hidden" name="empNo" value="${emp.empNo}">
	              <div class="button-wrapper text-end"></div>
	            </c:when>
	            <c:when test="${emp.role == 'ROLE_USER'}">
	              <div class="button-wrapper text-end">
                  <input id="empNo" type="hidden" name="empNo" value="${emp.empNo}">
		              <button type="button" class="btn btn-primary mb-4" id="btn-work-in" ${hasCheckedWorkIn ? 'disabled' : ''}>
		                <span class="d-none d-sm-block">출근</span>
		              </button>
		              <button type="submit" class="btn btn-danger mb-4" id="btn-work-out" >
		                <span class="d-none d-sm-block">퇴근</span>
		              </button>
		            </div>
	            </c:when>                   
            </c:choose>			      
	        </div>	
	        	    
		    </div>
	    </div>
	  </div>
	  <div class="row">
	    <div class="col-12 col-lg-6">
	      <div class="row">
	        <div class="col-6 mb-4 h-100">
	          <div class="card">
	            <div class="card-body text-center">
	              <div class="text-center my-3">
	                <c:if test="${not empty emp.profilePath}">
					          <img src="${emp.profilePath}"  alt="user-avatar" class="rounded" height="100" width="100" id="uploadedAvatar" >
					         </c:if>
					         <!-- 프로필 이미지 없을 때 (기본이미지 첨부 됨) -->
					         <c:if test="${empty emp.profilePath}">
					          <img src="../assets/img/user-solid.png" class="rounded" height="100" width="100" alt="프로필 이미지">
					         </c:if>
	              </div>
	              <span class="fw-semibold d-block mb-1">
	                ${emp.deptName}팀
	                <c:choose>
	                 <c:when test="${emp.role == 'ROLE_ADMIN'}">
	                   <strong>${emp.empName}</strong>
	                 </c:when>
	                 <c:when test="${emp.role == 'ROLE_USER'}">
                     <strong>${emp.empName} ${emp.posName}</strong>
                   </c:when>                   
	                </c:choose><br/>
	                ${emp.email}<br/>
	                ${emp.mobile}
	              </span>
	            </div>
	          </div>
	        </div>
	        <div class="col-6 mb-4">
	          <div class="card h-100">
	            <div class="card-body">
	              <div class="card-title">
	                <h5 class="text-nowrap mb-2 text-primary">오늘의 날씨</h5>                   
	              </div>
	              <div class="weather">
	                <div class="col-md">
	                  <div class="row">
	                    <div id="weather-icon-wrap" class="col-md-6">
	                      <img id="weather-icon">
	                    </div>
	                    <div id="current-temp" class="col-md-6 display-3"></div>
	                  </div>  
	                </div>
	                <div class="temt-wrap mt-3">
	                  <div><span class="tit d-inline-block mr-1">최저기온 : </span><span id="temp-min" class="py-1"></span></div>
	                  <div><span class="tit d-inline-block">풍속 : </span><span id="wind" class="py-1"></span></div>
	                  <div><span class="tit d-inline-block">최고기온 : </span><span id="temp-max" class="py-1"></span></div>
	                  <div><span class="tit d-inline-block">습도 : </span><span id="cloud" class="py-1"></span></div>
	                </div>
	              </div>
	            </div>
	          </div>
	        </div>	        
        </div>
	      <div class="row">
	        <div class="col-12 mb-4">
	          <div class="card h-100 noti-card">
	            <div class="card-body">
	              <div class="gap-3">
                  <div class="card-title">
                    <h5 class="text-nowrap mb-2 text-primary">공지사항</h5>
                  </div>
                  <div class="table-responsive text-nowrap">
								    <table class="table">
								      <thead class="table-light text-center">
								        <tr>
								          <th scope="col">번호</th>
								          <th scope="col">제목</th>
								          <th scope="col">작성일자</th>
								        </tr>
								      </thead>
								      <tbody class="table-border-bottom-0 notice-table"> </tbody>
								    </table>
							    </div>
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	    <div class="col-12 col-lg-6">
	      <h4 class="mb-4">
	        <span class="today"></span>
	        <span class="day-name"></span>
	        <span class="time"></span>
	      </h4> 
        <div class="row">
          <div class="col-md-8">
            <div class="card" id="cal"></div>
          </div>
          <div class="col-md-4">
            <div class="main-news-wrap">
              <div class="btn rounded-pill btn-outline-secondary mb-4 py-3 news-msg"><a href="${contextPath}/user/receiveBox?empNo=${emp.empNo}">안읽은 쪽지<br/><strong class="msg-count"></strong> 건입니다.</a></div>
              <div class="btn rounded-pill btn-outline-success mb-4 py-3  news-await"><a href="${contextPath}/approval/appList">대기 전자문서<br/><strong class="wait-count"></strong> 건입니다.</a></div>
              <div class="btn rounded-pill btn-outline-info py-3 news-my-await"><a href="${contextPath}/approval/appMyList">진행 전자문서<br/><strong class="my-apv-count"></strong> 건입니다.</a></div>
            </div>
          </div>
        </div>
	    </div>
	  </div>	  
	</div>
  <!-- / Content -->            

<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.13/index.global.min.js'></script>
<script src="../assets/js/pages-index.js"></script>
<%@ include file="./layout/footer.jsp" %>
