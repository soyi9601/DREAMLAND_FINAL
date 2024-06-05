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
    		action="${contextPath}/sales/productreg.do" 
    		id="frm-productreg">
 
        <!-- Bootstrap Dark Table -->
        
        <h5 class="card-header">상품등록</h5>
        
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        	 <button type="button" onclick="myFunction()">추가</button>
        </div>
        
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th>상품번호</th>
                            <th>상품</th>
                            <th>가격</th>
                            <th>파트번호</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0" id="myTable">
                    <!--<tr>
                        		<td>11<input type="hidden" name="productSctCd" value="11"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>자유이용권(대)</strong>
                                <input type="hidden" name="productNM" value="자유이용권대"></td>
                            <td>57000<input type="hidden" name="price" value="57000"></td>
                       			<td>5000<input type="hidden" name="deptNo" value="5000"></td>
                        </tr>
                        <tr>
                        		<td>12<input type="hidden" name="productSctCd" value="12"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>자유이용권(소)</strong>
                                <input type="hidden" name="productNM" value="자유이용권소"></td>
                            <td>47000<input type="hidden" name="price" value="47000"></td>
                        		<td>5000<input type="hidden" name="deptNo" value="5000"></td>
                        </tr>
                        <tr>
                        		<td>13<input type="hidden" name="productSctCd" value="13"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>자유이용권(경로)</strong>
                                <input type="hidden" name="productNM" value="자유이용권경로"></td>
                            <td>47000<input type="hidden" name="price" value="47000"></td>
                        		<td>5000<input type="hidden" name="deptNo" value="5000"></td>
                        </tr>
                        <tr>
                        		<td>17<input type="hidden" name="productSctCd" value="17"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>야간이용권(대)</strong>
                                <input type="hidden" name="productNM" value="야간이용권대"></td>
                            <td>28000<input type="hidden" name="price" value="28000"></td>
                        		<td>5000<input type="hidden" name="deptNo" value="5000"></td>
                        </tr>
                        <tr>
                        		<td>18<input type="hidden" name="productSctCd" value="18"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>야간이용권(소)</strong>
                                <input type="hidden" name="productNM" value="야간이용권소"></td>
                            <td>18000<input type="hidden" name="price" value="18000"></td>
                        		<td>5000<input type="hidden" name="deptNo" value="5000"></td>
                        </tr>
                        <tr>
                       			<td>19<input type="hidden" name="productSctCd" value="19"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>야간이용권(경로)</strong>
                                <input type="hidden" name="productNM" value="야간이용권경로"></td>
                            <td>18000<input type="hidden" name="price" value="18000"></td>
                        		<td>5000<input type="hidden" name="deptNo" value="5000"></td>
                        </tr>
                        <tr> 
                        		<td>21<input type="hidden" name="productSctCd" value="21"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>물</strong>
                                <input type="hidden" name="productNM" value="물"></td>
                            <td>1000<input type="hidden" name="price" value="1000"></td>
                            <td>5120<input type="hidden" name="deptNo" value="5120"></td>
                        </tr>
                        <tr>
                        		<td>22<input type="hidden" name="productSctCd" value="22"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>핫도그</strong>
                                <input type="hidden" name="productNM" value="핫도그"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                        		<td>5120<input type="hidden" name="deptNo" value="5120"></td>
                        </tr>
                        <tr>
                        		<td>23<input type="hidden" name="productSctCd" value="23"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>츄러스</strong>
                                <input type="hidden" name="productNM" value="츄러스"></td>
                            <td>3000<input type="hidden" name="price" value="3000"></td>
                        		<td>5120<input type="hidden" name="deptNo" value="5120"></td>
                        </tr>
                        <tr>
                        		<td>24<input type="hidden" name="productSctCd" value="24"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>소세지</strong>
                                <input type="hidden" name="productNM" value="소세지"></td>
                            <td>4000<input type="hidden" name="price" value="4000"></td>
                        		<td>5120<input type="hidden" name="deptNo" value="5120"></td>
                        </tr>
                        <tr>
                        		<td>25<input type="hidden" name="productSctCd" value="25"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>핫바</strong>
                                <input type="hidden" name="productNM" value="핫바"></td>
                            <td>4000<input type="hidden" name="price" value="4000"></td>
                        		<td>5120<input type="hidden" name="deptNo" value="5120"></td>
                        </tr>
                        <tr> 
                        		<td>21<input type="hidden" name="productSctCd" value="21"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>치킨</strong>
                                <input type="hidden" name="productNM" value="치킨"></td>
                            <td>20000<input type="hidden" name="price" value="20000"></td>
                        		<td>5220<input type="hidden" name="deptNo" value="5220"></td>
                        </tr>
                        <tr>
                        		<td>22<input type="hidden" name="productSctCd" value="22"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>닭강정</strong>
                                <input type="hidden" name="productNM" value="닭강정"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                            <td>5220<input type="hidden" name="deptNo" value="5220"></td>
                        </tr>
                        <tr>
                        		<td>23<input type="hidden" name="productSctCd" value="23"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>감자튀김</strong>
                                <input type="hidden" name="productNM" value="감자튀김"></td>
                            <td>7000<input type="hidden" name="price" value="7000"></td>
                            <td>5220<input type="hidden" name="deptNo" value="5220"></td>
                        </tr>
                        <tr>
                        		<td>24<input type="hidden" name="productSctCd" value="24"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>만두</strong>
                                <input type="hidden" name="productNM" value="만두"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                            <td>5220<input type="hidden" name="deptNo" value="5220"></td>
                        </tr>
                        <tr>
                        		<td>25<input type="hidden" name="productSctCd" value="25"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>콜팝</strong>
                                <input type="hidden" name="productNM" value="콜팝"></td>
                            <td>6000<input type="hidden" name="price" value="6000"></td>
                            <td>5220<input type="hidden" name="deptNo" value="5220"></td>
                        </tr>
                        <tr>
                        		<td>21<input type="hidden" name="productSctCd" value="21"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>커피</strong>
                                <input type="hidden" name="productNM" value="커피"></td>
                            <td>3000<input type="hidden" name="price" value="3000"></td>
                            <td>5320<input type="hidden" name="deptNo" value="5320"></td>
                        </tr>
                        <tr>
                        		<td>22<input type="hidden" name="productSctCd" value="22"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>이온음료</strong>
                                <input type="hidden" name="productNM" value="이온음료"></td>
                            <td>2000<input type="hidden" name="price" value="2000"></td>
                            <td>5320<input type="hidden" name="deptNo" value="5320"></td>
                        </tr>
                        <tr>
                        		<td>23<input type="hidden" name="productSctCd" value="23"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>슬러시</strong>
                                <input type="hidden" name="productNM" value="슬러시"></td>
                            <td>4000<input type="hidden" name="price" value="4000"></td>
                            <td>5320<input type="hidden" name="deptNo" value="5320"></td>
                        </tr>
                        <tr>
                        		<td>24<input type="hidden" name="productSctCd" value="24"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>주스</strong>
                                <input type="hidden" name="productNM" value="주스"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                            <td>5320<input type="hidden" name="deptNo" value="5320"></td>
                        </tr>
                        <tr>
                        		<td>25<input type="hidden" name="productSctCd" value="25"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>밀크티</strong>
                                <input type="hidden" name="productNM" value="밀크티"></td>
                            <td>4000<input type="hidden" name="price" value="4000"></td>
                            <td>5320<input type="hidden" name="deptNo" value="5320"></td>
                        </tr>
                    
                        <tr>
                        		<td>21<input type="hidden" name="productSctCd" value="21"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>팝콘</strong>
                                <input type="hidden" name="productNM" value="팝콘"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                            <td>5420<input type="hidden" name="deptNo" value="5420"></td>
                        </tr>
                        <tr>
                        		<td>22<input type="hidden" name="productSctCd" value="22"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>카라멜팝콘</strong>
                                <input type="hidden" name="productNM" value="카라멜팝콘"></td>
                            <td>6000<input type="hidden" name="price" value="6000"></td>
                            <td>5420<input type="hidden" name="deptNo" value="5420"></td>
                        </tr>
                        <tr>
                        		<td>23<input type="hidden" name="productSctCd" value="23"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>어니언팝콘</strong>
                                <input type="hidden" name="productNM" value="어니언팝콘"></td>
                            <td>6000<input type="hidden" name="price" value="6000"></td>
                            <td>5420<input type="hidden" name="deptNo" value="5420"></td>
                        </tr>
                        <tr>
                        		<td>24<input type="hidden" name="productSctCd" value="24"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>허니버터팝콘</strong>
                                <input type="hidden" name="productNM" value="허니버터팝콘"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                            <td>5420<input type="hidden" name="deptNo" value="5420"></td>
                        </tr>
                        <tr>
                        		<td>25<input type="hidden" name="productSctCd" value="25"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>초콜릿팝콘</strong>
                                <input type="hidden" name="productNM" value="초콜릿팝콘"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                            <td>5420<input type="hidden" name="deptNo" value="5420"></td>
                        </tr>
                        <tr>
                        		<td>21<input type="hidden" name="productSctCd" value="21"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>짜장면</strong>
                                <input type="hidden" name="productNM" value="짜장면"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                            <td>5520<input type="hidden" name="deptNo" value="5520"></td>
                        </tr>
                        <tr>
                        		<td>22<input type="hidden" name="productSctCd" value="22"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>짬뽕</strong>
                                <input type="hidden" name="productNM" value="짬뽕"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                       <td>5520<input type="hidden" name="deptNo" value="5520"></td>
                        </tr>
                        <tr>
                        		<td>23<input type="hidden" name="productSctCd" value="23"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>탕수육</strong>
                                <input type="hidden" name="productNM" value="탕수육"></td>
                            <td>21000<input type="hidden" name="price" value="21000"></td>
                            <td>5520<input type="hidden" name="deptNo" value="5520"></td>
                        </tr>
                        <tr>
                        		<td>24<input type="hidden" name="productSctCd" value="24"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>볶음밥</strong>
                                <input type="hidden" name="productNM" value="볶음밥"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                            <td>5520<input type="hidden" name="deptNo" value="5520"></td>
                        </tr>
                        <tr>
                        		<td>25<input type="hidden" name="productSctCd" value="25"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>냉면</strong>
                                <input type="hidden" name="productNM" value="냉면"></td>
                            <td>9000<input type="hidden" name="price" value="9000"></td>
                            <td>5520<input type="hidden" name="deptNo" value="5520"></td>
                        </tr> 
                        <tr>
                        		<td>31<input type="hidden" name="productSctCd" value="31"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>판다인형</strong>
                                <input type="hidden" name="productNM" value="판다인형"></td>
                            <td>21000<input type="hidden" name="price" value="21000"></td>
                            <td>5130<input type="hidden" name="deptNo" value="5130"></td>
                        </tr>
                        <tr>
                        		<td>32<input type="hidden" name="productSctCd" value="32"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>판다가방</strong>
                                <input type="hidden" name="productNM" value="판다가방"></td>
                            <td>20000<input type="hidden" name="price" value="20000"></td>
                            <td>5130<input type="hidden" name="deptNo" value="5130"></td>
                        </tr>
                        <tr>
                        		<td>33<input type="hidden" name="productSctCd" value="33"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>판다키링</strong>
                                <input type="hidden" name="productNM" value="판다키링"></td>
                            <td>7000<input type="hidden" name="price" value="7000"></td>
                            <td>5130<input type="hidden" name="deptNo" value="5130"></td>
                        </tr>
                        <tr>
                        		<td>34<input type="hidden" name="productSctCd" value="34"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>판다모자</strong>
                                <input type="hidden" name="productNM" value="판다모자"></td>
                            <td>11000<input type="hidden" name="price" value="11000"></td>
                            <td>5130<input type="hidden" name="deptNo" value="5130"></td>
                        </tr>
                        <tr>
                        		<td>35<input type="hidden" name="productSctCd" value="35"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>판다목걸이</strong>
                                <input type="hidden" name="productNM" value="판다목걸이"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                            <td>5130<input type="hidden" name="deptNo" value="5130"></td>
                        </tr>
                        <tr>
                        		<td>31<input type="hidden" name="productSctCd" value="31"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>수건</strong>
                                <input type="hidden" name="productNM" value="수건"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                            <td>5230<input type="hidden" name="deptNo" value="5230"></td>
                        </tr>
                        <tr>
                        		<td>32<input type="hidden" name="productSctCd" value="32"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>샤위밴드</strong>
                                <input type="hidden" name="productNM" value="샤위밴드"></td>
                            <td>7000<input type="hidden" name="price" value="7000"></td>
                            <td>5230<input type="hidden" name="deptNo" value="5230"></td>
                        </tr>
                        <tr>
                        		<td>33<input type="hidden" name="productSctCd" value="33"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>슬리퍼</strong>
                                <input type="hidden" name="productNM" value="슬리퍼"></td>
                            <td>7000<input type="hidden" name="price" value="7000"></td>
                            <td>5230<input type="hidden" name="deptNo" value="5230"></td>
                        </tr>
                        <tr>
                        		<td>34<input type="hidden" name="productSctCd" value="34"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>안대</strong>
                                <input type="hidden" name="productNM" value="안대"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                            <td>5230<input type="hidden" name="deptNo" value="5230"></td>
                        </tr>
                        <tr>
                        		<td>35<input type="hidden" name="productSctCd" value="35"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>칫솔</strong>
                                <input type="hidden" name="productNM" value="칫솔"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                            <td>5230<input type="hidden" name="deptNo" value="5230"></td>
                        </tr>
                        <tr>
                        		<td>21<input type="hidden" name="productSctCd" value="31"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>유리컵</strong>
                                <input type="hidden" name="productNM" value="유리컵"></td>
                            <td>9000<input type="hidden" name="price" value="9000"></td>
                            <td>5330<input type="hidden" name="deptNo" value="5330"></td>
                        </tr>
                        <tr>
                        		<td>22<input type="hidden" name="productSctCd" value="32"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>접시</strong>
                                <input type="hidden" name="productNM" value="접시"></td>
                            <td>11000<input type="hidden" name="price" value="11000"></td>
                            <td>5330<input type="hidden" name="deptNo" value="5330"></td>
                        </tr>
                        <tr>
                        		<td>23<input type="hidden" name="productSctCd" value="33"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>텀블러</strong>
                                <input type="hidden" name="productNM" value="텀블러"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                            <td>5330<input type="hidden" name="deptNo" value="5330"></td>
                        </tr>
                        <tr>
                        		<td>24<input type="hidden" name="productSctCd" value="34"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>머그컵</strong>
                                <input type="hidden" name="productNM" value="머그컵"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                            <td>5330<input type="hidden" name="deptNo" value="5330"></td>
                        </tr>
                        <tr>
                        		<td>25<input type="hidden" name="productSctCd" value="35"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>팝콘통</strong>
                                <input type="hidden" name="productNM" value="팝콘통"></td>
                            <td>17000<input type="hidden" name="price" value="17000"></td>
                            <td>5330<input type="hidden" name="deptNo" value="5330"></td>
                        </tr>
                        <tr>
                        		<td>21<input type="hidden" name="productSctCd" value="31"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>물총</strong>
                                <input type="hidden" name="productNM" value="물총"></td>
                            <td>13000<input type="hidden" name="price" value="13000"></td>
                            <td>5430<input type="hidden" name="deptNo" value="5430"></td>
                        </tr>
                        <tr>
                        		<td>22<input type="hidden" name="productSctCd" value="32"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>스노우볼</strong>
                                <input type="hidden" name="productNM" value="스노우볼"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                            <td>5430<input type="hidden" name="deptNo" value="5430"></td>
                        </tr>
                        <tr>
                        		<td>23<input type="hidden" name="productSctCd" value="33"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>우산</strong>
                                <input type="hidden" name="productNM" value="우산"></td>
                            <td>7000<input type="hidden" name="price" value="7000"></td>
                            <td>5430<input type="hidden" name="deptNo" value="5430"></td>
                        </tr>
                        <tr>
                        		<td>24<input type="hidden" name="productSctCd" value="34"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>아마존티셔츠</strong>
                                <input type="hidden" name="productNM" value="아마존티셔츠"></td>
                            <td>30000<input type="hidden" name="price" value="30000"></td>
                            <td>5430<input type="hidden" name="deptNo" value="5430"></td>
                        </tr>
                        <tr>
                        		<td>25<input type="hidden" name="productSctCd" value="35"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>비눗방울</strong>
                                <input type="hidden" name="productNM" value="비눗방울"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                            <td>5430<input type="hidden" name="deptNo" value="5430"></td>
                        </tr>
                        <tr>
                        		<td>21<input type="hidden" name="productSctCd" value="31"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>라마인형</strong>
                                <input type="hidden" name="productNM" value="라마인형"></td>
                            <td>13000<input type="hidden" name="price" value="13000"></td>
                            <td>5530<input type="hidden" name="deptNo" value="5530"></td>
                        </tr>
                        <tr>
                        		<td>22<input type="hidden" name="productSctCd" value="32"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>래서판다인형</strong>
                                <input type="hidden" name="productNM" value="래서판다인형"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                            <td>5530<input type="hidden" name="deptNo" value="5530"></td>
                        </tr>
                        <tr>
                        		<td>23<input type="hidden" name="productSctCd" value="33"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>호랑이인형</strong>
                                <input type="hidden" name="productNM" value="호랑이인형"></td>
                            <td>30000<input type="hidden" name="price" value="30000"></td>
                            <td>5530<input type="hidden" name="deptNo" value="5530"></td>
                        </tr>
                        <tr>
                        		<td>24<input type="hidden" name="productSctCd" value="34"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>펭권인형</strong>
                                <input type="hidden" name="productNM" value="펭권인형"></td>
                            <td>13000<input type="hidden" name="price" value="13000"></td>
                            <td>5530<input type="hidden" name="deptNo" value="5530"></td>
                        </tr>
                        <tr>
                        		<td>25<input type="hidden" name="productSctCd" value="35"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>드림이인형</strong>
                                <input type="hidden" name="productNM" value="드림이인형"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                            <td>5530<input type="hidden" name="deptNo" value="5530"></td>
                        </tr> --> 
                    </tbody>
                </table>
            </div>
        </div> 
    </form>
</body>
</html>

<script>
function myFunction() {
		var addRowIndex = 0;
	  var table = document.getElementById("myTable");
	  var row = table.insertRow(addRowIndex);
	  var cell1 = row.insertCell(0);
	  var cell2 = row.insertCell(1);
	  var cell3 = row.insertCell(2);
	  var cell4 = row.insertCell(3);
	  var cell5 = row.insertCell(4);
	  cell1.innerHTML = "<input type='text' name='productSctCd'>";
	  cell2.innerHTML = "<td><i class='fab fa-bootstrap fa-lg text me-3'></i> <strong><input type='text' name='productNM'></strong></td>";
	  cell3.innerHTML = "<td><input type='text' name='price'></td>";
	  cell4.innerHTML = "<td><input type='text' name='deptNo'></td>";
	  cell5.innerHTML = "<td><button type='button' onclick='deleteRow(this)' class='btn_delete'>Delect</button>";
	  addRowIndex = addRowIndex + 1;
	}

function deleteRow(btn) {
		console.log('btn', btn)
	  var row = btn.parentNode.parentNode; // 클릭된 버튼의 부모 행을 찾습니다.
		console.log('row', row)
	  row.parentNode.removeChild(row);     // 테이블에서 해당 행을 제거합니다.
	}
</script>

	
	
