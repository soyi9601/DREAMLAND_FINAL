<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee"
    value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../layout/header.jsp" />

<!-- 링크 -->
<link rel="stylesheet" href="/resources/assets/vendor/fonts/boxicons.css" />
<!-- include moment.js -->
<script src="/resources/assets/moment/moment-with-locales.min.js"></script>

		<style>
 		.Allmagin {
 					margin : 0px 200px 100px 200px;
 		}
 		.title {
 					padding : 40px 40px 0px 30px;
 					color :  #90B54C;
 		}
 		.card-header {
 					background-color: rgb(189,189,189,0.5);
          padding : 40px 40px 10px 30px;
          text-align: left;
          border-bottom: 1px solid #ddd;
 		}
 		.btn-remove {
 				 	width: 120px;
 				 	height: 35px;
    			float: right;
    		  margin-right: 20px;
    		  text-align: center;
    			background-color: #EE2B4B;
    			color: #FFFFFF; 
 		}
 		.text-nowrap {
 					width:100%;
   				margin-top: 30px;
   				background-color:#233446;
   				padding:0 12px;
 		}
 		th, tr {
 					text-align: center;  
 		}
 		.table table-dark {
 					width: 100%;
 		}
 		.pagination{
 					justify-content: center;
 					margin: 20px 0px 20px 0px;
 		}
		.pagination .page-link {
					background:#fff;
		}
		</style>
		
		
<!-- Content wrapper -->
<div class="content-wrapper">

<div class="Allmagin">

<form id="productForm" method="post" action="${contextPath}/sales/updateProduct.do">
	<h1 class="title">매출</h1>
	
	<!-- 부트스트랩 다크 테이블 -->
	<div id="EuropeanAdventure" class="card">
    <div class="card-header">    
    	<h2>상품목록 <button type="submit" id="list-del-btn" class="btn btn-primary btn-remove">삭제</button></h2>
    </div>
    <div class="table-responsive text-nowrap">
    	<table class="table table-dark">
      	<thead>
        	<tr>
          	<th>파트번호</th>
            <th>선택</th>
            <th>상품번호</th>
            <th>상품</th>
            <th>가격</th>
          </tr>
        </thead>
        <tbody class="table-border-bottom-0">
        	<c:forEach items="${loadProductList}" var="ProductList">
          	<c:if test="${ProductList.delyn != 'Y'}">
            	<tr>
              	<td>${ProductList.department.deptNo}</td>
                <td><input type="checkbox" name="productChk" value="${ProductList.productNo}" class="form-check-input"/></td>
                <td>${ProductList.productSctCd}</td>
                <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${ProductList.productNM}</strong></td>
                <td>${ProductList.price}</td>
              </tr>
            </c:if>
          </c:forEach>
        </table>
      </form>
    </div>
   <div class="pagination">${paging}</div>
	</div>
</div>

<script>
const fnremoveCheck = () => {
document.getElementById("list-del-btn").addEventListener("click", function() {
    const confirmDelete = confirm("선택한 항목을 삭제하시겠습니까?");
    if (confirmDelete) {
        document.getElementById("productForm").submit();
    		}
        alert("삭제되었습니다.");
		});
}

fnremoveCheck();
</script>

<%@ include file="../layout/footer.jsp"%>