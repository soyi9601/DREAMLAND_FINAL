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
	              <div class="button-wrapper text-end"></div>
	            </c:when>
	            <c:when test="${emp.role == 'ROLE_USER'}">
	              <div class="button-wrapper text-end">
		              <button type="submit" class="btn btn-primary mb-4">
		                <span class="d-none d-sm-block">출근</span>
		              </button>
		              <button type="submit" class="btn btn-danger mb-4">
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
	                <img src="${emp.profilePath}" alt="user-avatar" class="rounded" height="100" width="100" id="uploadedAvatar" />
	              </div>
	              <span class="fw-semibold d-block mb-1">
	                ${emp.deptName}팀
	                <c:choose>
	                 <c:when test="${emp.role == 'ROLE_ADMIN'}">
	                   <strong>${emp.empName}</strong>
	                 </c:when>
	                 <c:when test="${emp.role == 'ROLE_USER'}">
                     <strong>${emp.empName}${emp.posName}</strong>
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
	          <div class="card h-100">
	            <div class="card-body">
	              <div class="gap-3">
                  <div class="card-title">
                    <h5 class="text-nowrap mb-2">공지사항</h5>
                  </div>
                  <div class="table-responsive text-nowrap">
								    <table class="table">
								      <thead class="table-light">
								        <tr>
								          <th scope="col">공지번호</th>
								          <th scope="col">내용</th>
								        </tr>
								      </thead>
								      <tbody class="table-border-bottom-0">
								        <tr>
								          <td scope="col"><span class="fw-medium">1</span></td>
								          <td scope="col">Albert Cook</td>
								        </tr>
								        <tr>
                          <td scope="col"><span class="fw-medium">2</span></td>
                          <td scope="col">Albert Cook</td>
                        </tr>
								        <tr>
                          <td scope="col"><span class="fw-medium">3</span></td>
                          <td scope="col">Albert Cook</td>
                        </tr>
								      </tbody>
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
            <div class="card">캘린더</div>
          </div>
          <div class="col-md-4">
            <div class="main-news-wrap">
              <div class="btn rounded-pill btn-outline-secondary mb-4 py-3">안읽은 쪽지<br/><strong class="msg-count">0</strong> 건입니다.</div>
              <div class="btn rounded-pill btn-outline-success mb-4 py-3">대기 전자문서<br/><strong class="wait-count">0</strong> 건입니다.</div>
              <div class="btn rounded-pill btn-outline-info py-3">진행 전자문서<br/><strong class="continue-count">0</strong> 건입니다.</div>
            </div>
          </div>
        </div>
	    </div>
	  </div>	  
	</div>
  <!-- / Content -->            
 
	

<script src="../assets/js/pages-index.js"></script>
<%@ include file="./layout/footer.jsp" %>
