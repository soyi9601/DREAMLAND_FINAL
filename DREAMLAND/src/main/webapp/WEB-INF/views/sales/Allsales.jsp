<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />

<style>
    .custom-col {
        flex: 0 0 20%; 
        max-width: 20%; 
    }
</style>

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

    <title>Cards basic - UI elements | Sneat - Bootstrap 5 HTML Admin Template - Pro</title>

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
  </head>
		<body>
			<!-- Style variation -->
				<div class="row">
			    <div class="col-6 col-md-4 col-xl-3 custom-col">
			        <div class="card shadow-none bg-transparent border border-success mb-3">
			            <div class="card-body">                              
			                <h5 class="card-title">일간</h5 >
			                <p class="card-text">매출:
			                    <fmt:formatNumber value="${TodaySalesTotal}" type="currency" />
			                </p>
			            </div>
			        </div>
			    </div>
			    <div class="col-6 col-md-4 col-xl-3 custom-col">
			        <div class="card shadow-none bg-transparent border border-danger mb-3">
			            <div class="card-body">
			                <h5 class="card-title">주간</h5>
			                <p class="card-text">매출:
			                    <fmt:formatNumber value="${CurrentWeekSalesTotal}" type="currency" />
			                </p>
			            </div>
			        </div>
			    </div>
			    <div class="col-6 col-md-4 col-xl-3 custom-col">
			        <div class="card shadow-none bg-transparent border border-warning mb-3">
			            <div class="card-body">
			                <h5 class="card-title">월간</h5>
			                <p class="card-text">매출:
			                    <fmt:formatNumber value="${CurrentMonthSalesTotal}" type="currency" />
			                </p>
			            </div>
			        </div>
			    </div>
			    <div class="col-6 col-md-4 col-xl-3 custom-col">
			        <div class="card shadow-none bg-transparent border border-info mb-3">
			            <div class="card-body">
			                <h5 class="card-title">연간</h5>
			                <p class="card-text">매출:
			                    <fmt:formatNumber value="${CurrentYearSalesTotal}" type="currency" />
			                </p>
			            </div>
			        </div>
			    </div>
			</div>
			</body>
			
			<body>
			<!-- Hoverable Table rows -->
              <div class="card">
                <h5 class="card-header">Hoverable rows</h5>
                <div class="table-responsive text-nowrap">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>번호</th>
                        <th>이름</th>
                        <th>일간</th>
                        <th>주간</th>
                        <th>월간</th>
                        <th>연간</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                   		<c:forEach items="${getPartSales}" var="sale">
                      	<tr>
                      		<c:if test="${sale.deptNo ge 5100 && sale.deptNo le 5130 && sale.deptNo ne 5110}"> 
                      			<td>${sale.deptNo}</td>
                        		<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>${sale.deptName}</strong></td>
                        		<td><fmt:formatNumber value="${sale.dailySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.weeklySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.monthlySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.annualSales}" type="currency" /></td>
                      		</c:if>
                      	</tr>
                      </c:forEach>	
                    </tbody>
                  </table>
                </div>
              </div>
		</body>
</html>