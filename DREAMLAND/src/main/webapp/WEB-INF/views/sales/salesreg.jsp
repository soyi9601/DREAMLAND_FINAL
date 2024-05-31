<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />

<!DOCTYPE html>
<html
  lang="en"
  class="light-style layout-menu-fixed"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="../assets/"
  data-template="vertical-menu-template-free"
>
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />


    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../assets/js/config.js"></script>
 		
 		<style>
 		.card {
            display: none;
        }
 		.card.active {
            display: block;
        }
 		</style>
  </head>
  

<body>
	
		<form method="POST" 
    			action="${contextPath}/sales/salesreg.do" 
    			id="frm-salesreg">
    			 
				<label for="contentSelect">부서선택</label>
    				<select id="pageSelect" onchange="showPage(this.value)">
        			<option value="5000">티켓</option>
        			<option value="5110">매점1</option>
        			<option value="5220">매점2</option>
        			<option value="5320">매점3</option>
        			<option value="5420">매점4</option>
        			<option value="5520">매점5</option>
        			<option value="5130">굿즈샵1</option>
        			<option value="5230">굿즈샵2</option>
        			<option value="5330">굿즈샵3</option>
        			<option value="5430">굿즈샵4</option>
        			<option value="5530">굿즈샵5</option>
    				</select>
  	</form>

		<form method="POST" 
    			action="${contextPath}/sales/salesreg.do" 
    			id="frm-salesreg">    		
    		<div id="content"></div>	
    		
        <!-- Bootstrap Dark Table -->
        <div id="5000" class="card">
        
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        	<input type="date" name="salesDate">
        </div>
        
            <h5 class="card-header">
            	티켓
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th>이름</th>
                            <th>상품</th>
                            <th>수량</th>
                            <th>파트</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <c:forEach items="${product}" var="product">
                        		<tr>
                        			<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
                            	<td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
                            	<td><input type="text" name="qty" value=1></td>
                            	<td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
                        		</tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
      </form>
 
      
</body>
</html>

<script>
function showPage(pageId) {
    const pages = document.querySelectorAll('.card');
    pages.forEach(page => {
        page.classList.remove('active');
    });
    document.getElementById(pageId).classList.add('active');
}

// Initialize to show the first page
showPage('5000');

</script>



	
	
