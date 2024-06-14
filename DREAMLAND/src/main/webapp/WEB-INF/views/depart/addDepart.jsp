<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp" /> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>


<!-- Content wrapper -->
<div class="content-wrapper">
	  
	<!-- Content -->	
	<div class="container-xxl flex-grow-1 container-p-y">
	  <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">인사관리 /</span> 부서등록</h4>
	
	  <div class="row">
	    <div class="col-md-12">
	      <div class="card mb-4">
	        <h5 class="card-header">부서등록</h5>
	        <!-- Account -->
	        <form id="frm-add-department" method="POST" action="/depart/addDepart">
	        <hr class="my-0" />
		        <div class="card-body">
	            <div class="row">
	              <div class="mb-3 col-md-6">
	                <label for="deptName" class="form-label">부서명</label>
	                <input class="form-control" type="text" id="dept-name" name="deptName" />
	              </div>
	              <div class="mb-3 col-md-6">
	                 <label for="deptNo" class="form-label">부서번호</label>
	                 <input class="form-control" type="text" id="dept-no" name="deptNo" />
	               </div>
	              <div class="mb-3 col-md-3">
                  <label class="form-label" for="parent-id">소속부서</label>
                  <select id="parent-id" name="parentDeptTitle" class="select2 form-select">
                    <c:forEach var="depart" items="${deptTitleList}">
                      <option value="${depart.deptNo}">${depart.deptName}[${depart.deptNo}]</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="mb-3 col-md-3">
                  <label class="form-label" for="parentDeptDetail">세부소속</label>
                  <select id="parent-id-detail" name="parentDeptDetail" class="select2 form-select">
                    <option value="">세부 소속 없음</option>
                  </select>
                </div>
	            </div>
	            <div class="mt-2">
	              <button type="submit" class="btn btn-primary me-2">저장</button>
	              <button type="reset" class="btn btn-outline-secondary">취소</button>
	            </div>
		        </div>
	        </form>	       
	        <!-- /Account -->
	      </div>
	    </div>
	  </div>
	</div>
	<!-- / Content -->
	
<script src="../assets/js/pages-add-depart.js"></script>
<%@ include file="../layout/footer.jsp" %>
    