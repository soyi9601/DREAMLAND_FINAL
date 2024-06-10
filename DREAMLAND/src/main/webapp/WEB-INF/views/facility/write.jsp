<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />

<!DOCTYPE html>

<!-- =========================================================
* Sneat - Bootstrap 5 HTML Admin Template - Pro | v1.0.0
==============================================================

* Product Page: https://themeselection.com/products/sneat-bootstrap-html-admin-template/
* Created by: ThemeSelection
* License: You must have a valid license purchased in order to legally use the theme for your project.
* Copyright ThemeSelection (https://themeselection.com)

=========================================================
 -->
<!-- beautify ignore:start -->
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

    <title>Dashboard - Analytics | Sneat - Bootstrap 5 HTML Admin Template - Pro</title>

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

    <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../assets/js/config.js"></script>
		
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>

<form method="POST" 
				enctype="multipart/form-data"
    		action="${contextPath}/facility/register.do" 
    		id="frm-facilityreg">
    		
    <div class="col-sm-10">
				<button type="submit" class="btn btn-primary">전송</button>
				<button type="button" onclick="myFunction()">추가</button>
		</div>

		<!-- Hoverable Table rows -->
							<div id="Zootopia" class="card">
						    <h5 class="card-header">시설 점검 등록</h5>
						    	<div class="table-responsive text-nowrap">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                      	<th>시설번호</th>
                        <th>시설명</th>
                        <th>점검일자</th>
                        <th>관리유무</th>
                        <th>비고</th>
                        <th>파일첨부</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0" id="myTable">
                    	 <tr>
                    	 
                    	 </tr>
                    </tbody>
                  </table>
                </div>
              </div>
</form>
</body>

<script>
function showCurrentDate() {
	const dateElement = document.getElementById('currentDate');
	const currentDate = new Date();
  const formattedDate = currentDate.toLocaleDateString('ko-KR', {
  	year: 'numeric',
    month: 'long',
    day: 'numeric',
  });
  dateElement.textContent = formattedDate;
}
window.onload = showCurrentDate;
        
function myFunction() {
	var addRowIndex = 1;
  var table = document.getElementById("myTable");
  var row = table.insertRow(addRowIndex);
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	var cell4 = row.insertCell(3);
	var cell5 = row.insertCell(4);
	var cell6 = row.insertCell(5);
	var cell7 = row.insertCell(6);
	cell1.innerHTML = "<td><input type='text'  class='deptNo' name='deptNo'></td>";
	cell2.innerHTML = "<td><input type='text'  class='facilityName' name='facilityName'></td>";
	cell3.innerHTML = "<span id='currentDate'></span>";
	cell4.innerHTML = "<td><input type='checkbox' class='chkmanagement' name='management'/></td>";
	cell5.innerHTML = "<td><textarea id='basic-default-message' class='form-control' name='remarks'></textarea></td>";
	cell6.innerHTML = "<td><input class='form-control' type='file' name='files' /></td>";
	cell7.innerHTML = "<td><button type='button' onclick='deleteRow(this)' class='btn_delete'>Delect</button>";
	
	 var currentDateElement = row.querySelector('#currentDate');
	    if (currentDateElement) {
	        var options = { year: 'numeric', month: 'long', day: 'numeric' };
	        var currentDate = new Date().toLocaleDateString('ko-KR', options);
	        currentDateElement.textContent = currentDate;
	}
	
	addRowIndex = addRowIndex + 1;
	}
	
	
function deleteRow(btn) {
	console.log('btn', btn)
	var row = btn.parentNode.parentNode; // 클릭된 버튼의 부모 행을 찾습니다.
	console.log('row', row)
	row.parentNode.removeChild(row);     // 테이블에서 해당 행을 제거합니다.
}



const fnCkgMng = () => {
	  
	$('input[name="management"]').val(0);
	  
	  $(document).on('click', '.chkmanagement', (e) => {
	      if ($(e.target).prop('checked')) {
	        $('input[name="management"]').val(1);
	      } else {
	         $('input[name="management"]').val(0); 
	      }
	  });
	}

fnCkgMng();

















</script>
</html>