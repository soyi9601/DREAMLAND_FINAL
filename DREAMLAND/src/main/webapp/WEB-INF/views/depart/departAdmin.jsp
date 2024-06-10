<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.16/jstree.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.16/themes/default/style.min.css" />

<!-- Content wrapper -->
<div class="content-wrapper">

	<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="text-nowrap mb-2">부서관리</h4>   
	  <blockquote class="blockquote mt-3">
       <p class="mb-0"></p>
    </blockquote>
    <div class="row">
	    <div class="col-12 col-lg-4 mb-4">
	      <div class="row g-0 mb-4">
	        <div class="col-md-10">
	          <label class="mb-3">찾는 부서나 구성원이 있으시면 검색해주세요.</label>
	          <input type="text" class="form-control" id="departSearch" placeholder="사원 및 부서를 입력해주세요.">
	        </div>
	      </div>
		    <div class="row">
		      <div id="jsTree"></div>
		    </div>
	    </div>
	    <div class="col-12 col-lg-8 mb-4">
	      <!--  EMPLOYEE  -->
        <form id="empForm">
		      <div class="row">
		      <div class="mb-3 col-md-6">
		        <input class="form-control" type="text" id="emp-no" name="empNo" value="${emp.empNo}" hidden />
		        <label for="empName" class="form-label">이름</label>
		        <input class="form-control" type="text" id="emp-name" name="empName" value="${emp.empName}" />
		        <div id="name-result"></div>
		      </div>
		      <div class="mb-3 col-md-6">
		        <label for="birth" class="form-label">생년월일</label>
		        <input class="form-control" type="date" id="birth" name="birth" value="${emp.birth}" />
		      </div>
		      <div class="mb-3 col-md-6">
		        <label for="empPw" class="form-label">비밀번호</label>
		        <input class="form-control" type="password" name="empPw" id="empPw" readOnly />
		      </div>
		      <div class="mb-3 col-md-6">
		        <label class="form-label" for="mobile">휴대전화</label>
		          <input type="tel" id="emp-mobile" name="mobile" class="form-control" value="${emp.mobile}" />
		       <div id="result-mobile"></div>
		      </div>
		      <div class="mb-3">
		        <label for="email" class="form-label">E-mail</label>
		        <input class="form-control" type="text" id="emp-email" name="email" value="${emp.email}" />
		        <div id="result-email"></div>
		      </div>
		      <div class="mb-3 col-md-6">
		        <label class="form-label" for="deptNo">소속</label>
		        <select id="emp-dept-no" name="deptNo" class="select2 form-select">
		          <option value="">선택하세요</option>
		          <c:forEach var="depart" items="${depart}">
                <option value="${depart.deptNo}">${depart.deptName}</option>
               </c:forEach>
		        </select>
		      </div>
		      <div class="mb-3 col-md-6">
		        <label for="posNo" class="form-label">직급</label>
		        <select id="pos-no" name="posNo" class="select2 form-select">
		          <option value="">선택하세요</option>
		          <option value="10">사원</option>
		          <option value="20">주임</option>
		          <option value="30">대리</option>
		          <option value="40">과장</option>
		          <option value="50">부장</option>
		          <option value="60">팀장</option>
		          <option value="100">대표이사</option>
		        </select>
		      </div>
		      <div class="mb-3 col-md-6">
		        <label for="enterDate" class="form-label">입사일</label>
		        <input class="form-control" type="date"  id="enterDate" name="enterDate" value="${emp.enterDate}"/>
		      </div>		
		      <div class="mb-3 col-md-6">
		        <label for="role" class="form-label">권한</label>
		        <select id="role" name="role" class="select2 form-select">
		          <option value="">선택하세요</option>
		          <option value="ROLE_USER">직원</option>
		          <option value="ROLE_ADMIN">관리자</option>
		        </select>
		      </div>
		      <div class="mt-2">
              <button type="submit" class="btn btn-primary me-2" id="frm-modify-emp">저장</button>
              <button type="reset" class="btn btn-outline-secondary">취소</button>
            </div>
            </div>
	      </form>
		      
	      <!--  DEPARTMENT  -->
	      <form id="deptForm">
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
           <div class="mt-2">
             <button type="submit" class="btn btn-primary me-2" id="frm-modify-dept">저장</button>
             <button type="reset" class="btn btn-outline-secondary">취소</button>
           </div>
           </div>
	      </form>
		  </div>
	  </div>
  </div>

<script src="../assets/js/pages-depart.js"></script>
<%@ include file="../layout/footer.jsp" %>    