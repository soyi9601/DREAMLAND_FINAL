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
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />
<link rel="stylesheet" href="/resources/assets/vendor/fonts/boxicons.css" />

<!-- Content wrapper -->
<div class="content-wrapper">

<!-- 부트스트랩 다크 테이블 -->
<div id="EuropeanAdventure" class="card">
    <h5 class="card-header">상품목록</h5>
    <div class="table-responsive text-nowrap">
        <form id="productForm" method="post" action="${contextPath}/sales/updateProduct.do">
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
                            <td><input type="checkbox" name="productChk" value="${ProductList.productNo}" /></td>
                            <td>${ProductList.productSctCd}</td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${ProductList.productNM}</strong></td>
                            <td>${ProductList.price}</td>
                        </tr>
                      </c:if>
                    </c:forEach>
            </table>
            <div class="sd-btn-write-area">
                <button type="submit" id="list-del-btn">삭제</button>
            </div>
        </form>
    </div>
    <div>${paging}</div>
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