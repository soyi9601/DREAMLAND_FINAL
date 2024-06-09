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
	        <form id="frm-add-employee" method="POST" action="${contextPath}/depart/addDepart.do">
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
	              <div class="mb-3 col-md-6">
	                <label class="form-label" for="deptNo">소속부서</label>
	                <select id="parent-id" name="parentId" class="select2 form-select">
	                  <option value="">선택하세요</option>
	                  <c:forEach var="depart" items="${depart}">
	                    <option value="${depart.deptNo}">${depart.deptName}</option>
	                  </c:forEach>
	                </select>
	              </div>
	            </div>
	            <div class="mt-2">
	              <button type="submit" class="btn btn-primary me-2" id="frm-add-department">저장</button>
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
	<script>
	let deptName = document.getElementById('dept-name');
	let deptNo = document.getElementById('dept-no');
	let parentId = document.getElementById('parent-id');
	 const fnAddDepart = (evt) => {
		 if(deptName === '') {
			 alert('부서명을 입력하세요');
			 evt.preventDefault();
			 return;
		 } else if(deptNo === '') {
			 alert('부서번호를 입력하세요');
       evt.preventDefault();
       return;
		 } else if(parentId === '') {
			 alert('소속부서를 입력하세요');
       evt.preventDefault();
       return;
		 }
	 };
	 document.getElementById('frm-add-department').addEventListener('submit', (evt) => {
		 fnAddDepart(evt);
	 })
	</script>

<%@ include file="../layout/footer.jsp" %>
    