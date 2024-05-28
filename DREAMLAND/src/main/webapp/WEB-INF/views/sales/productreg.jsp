<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

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
 
				<label for="contentSelect"></label>
    			<select id="pageSelect" onchange="showPage(this.value)">
        		<option value="ticket">티켓</option>
        		<option value="canteen1">매점1</option>
        		<option value="canteen2">매점2</option>
        		<option value="canteen3">매점3</option>
        		<option value="canteen4">매점4</option>
        		<option value="canteen5">매점5</option>
        		<option value="good1">굿즈샵1</option>
        		<option value="good2">굿즈샵2</option>
        		<option value="good3">굿즈샵3</option>
        		<option value="good4">굿즈샵4</option>
        		<option value="good5">굿즈샵5</option>
    			</select>
    		
    		
    		<div id="content"></div>	
					
				<form method="POST" 
    			action="${contextPath}/sales/productreg.do" 
    			id="frm-productreg">
    			
					
        <!-- Bootstrap Dark Table -->
        <div id="ticket" class="card">
        
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        	 <button type="button" onclick="myFunction()">추가</button>
        </div>
        
            <h5 class="card-header">
            	티켓
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th>상품번호</th>
                            <th>상품</th>
                            <th>가격</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0" id="myTable">
                        <tr>
                        		<td>11<input type="hidden" name="productNo" value="11"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>자유이용권(대)</strong>
                                <input type="hidden" name="goods" value="자유이용권대"></td>
                            <td>57000<input type="hidden" name="price" value="57000"></td>
                       			<td></td>
                        </tr>
                        <tr>
                        		<td>12<input type="hidden" name="productNo" value="12"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>자유이용권(소)</strong>
                                <input type="hidden" name="goods" value="자유이용권소"></td>
                            <td>47000<input type="hidden" name="price" value="47000"></td>
                        		<td></td>
                        </tr>
                        <tr>
                        		<td>13<input type="hidden" name="productNo" value="13"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>자유이용권(경로)</strong>
                                <input type="hidden" name="goods" value="자유이용권경로"></td>
                            <td>47000<input type="hidden" name="price" value="47000"></td>
                        		<td></td>
                        </tr>
                        <tr>
                        		<td>17<input type="hidden" name="productNo" value="17"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>야간이용권(대)</strong>
                                <input type="hidden" name="goods" value="야간이용권대"></td>
                            <td>28000<input type="hidden" name="price" value="28000"></td>
                        		<td></td>
                        </tr>
                        <tr>
                        		<td>18<input type="hidden" name="productNo" value="18"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>야간이용권(소)</strong>
                                <input type="hidden" name="goods" value="야간이용권소"></td>
                            <td>18000<input type="hidden" name="price" value="18000"></td>
                        		<td></td>
                        </tr>
                        <tr>
                       			<td>19<input type="hidden" name="productNo" value="19"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>야간이용권(경로)</strong>
                                <input type="hidden" name="goods" value="야간이용권경로"></td>
                            <td>18000<input type="hidden" name="price" value="18000"></td>
                        		<td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
      </form>
      
      <form method="POST" 
    			action="${contextPath}/sales/productreg.do" 
    			id="frm-productreg">
    			
        <div id="canteen1" class="card">
        
					<div>
						<button type="submit" id="regbtn" class="btn-reg">저장</button>
					</div>
					
            <h5 class="card-header">
							매점1
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th></th>
                            <th>상품</th>
                            <th>가격</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <tr>
                        		<td><input type="hidden" name="productNo" value="21"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>물</strong>
                                <input type="hidden" name="goods" value="물"></td>
                            <td>1000<input type="hidden" name="price" value="1000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="22"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>핫도그</strong>
                                <input type="hidden" name="goods" value="핫도그"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="23"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>츄러스</strong>
                                <input type="hidden" name="goods" value="츄러스"></td>
                            <td>3000<input type="hidden" name="price" value="3000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="24"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>소세지</strong>
                                <input type="hidden" name="goods" value="소세지"></td>
                            <td>4000<input type="hidden" name="price" value="4000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="25"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>핫바</strong>
                                <input type="hidden" name="goods" value="핫바"></td>
                            <td>4000<input type="hidden" name="price" value="4000"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
       </form>
       
       <form method="POST" 
    			action="${contextPath}/sales/productreg.do" 
    			id="frm-productreg">
    			
        <div id="canteen2" class="card">
        
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        </div>
        
            <h5 class="card-header">
            	매점2
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th></th>
                            <th>상품</th>
                            <th>가격</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <tr>
                        		<td><input type="hidden" name="productNo" value="21"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>치킨</strong>
                                <input type="hidden" name="goods" value="치킨"></td>
                            <td>20000<input type="hidden" name="price" value="20000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="22"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>닭강정</strong>
                                <input type="hidden" name="goods" value="닭강정"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="23"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>감자튀김</strong>
                                <input type="hidden" name="goods" value="감자튀김"></td>
                            <td>7000<input type="hidden" name="price" value="7000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="24"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>만두</strong>
                                <input type="hidden" name="goods" value="만두"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="25"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>콜팝</strong>
                                <input type="hidden" name="goods" value="콜팝"></td>
                            <td>6000<input type="hidden" name="price" value="6000"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
       </form>
       <form method="POST" 
    			action="${contextPath}/sales/productreg.do" 
    			id="frm-productreg">
    			
        <div id="canteen3" class="card">
          
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        </div>
          
            <h5 class="card-header">
            	매점3
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th></th>
                            <th>상품</th>
                            <th>가격</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <tr>
                        		<td><input type="hidden" name="productNo" value="21"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>커피</strong>
                                <input type="hidden" name="goods" value="커피"></td>
                            <td>3000<input type="hidden" name="price" value="3000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="22"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>이온음료</strong>
                                <input type="hidden" name="goods" value="이온음료"></td>
                            <td>2000<input type="hidden" name="price" value="2000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="23"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>슬러시</strong>
                                <input type="hidden" name="goods" value="슬러시"></td>
                            <td>4000<input type="hidden" name="price" value="4000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="24"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>주스</strong>
                                <input type="hidden" name="goods" value="주스"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="25"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>밀크티</strong>
                                <input type="hidden" name="goods" value="밀크티"></td>
                            <td>4000<input type="hidden" name="price" value="4000"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
       </form>
       <form method="POST" 
    			action="${contextPath}/sales/productreg.do" 
    			id="frm-productreg">
        <div id="canteen4" class="card">
        
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        </div>
        
            <h5 class="card-header">
            	매점4
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th></th>
                            <th>상품</th>
                            <th>가격</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <tr>
                        		<td><input type="hidden" name="productNo" value="21"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>팝콘</strong>
                                <input type="hidden" name="goods" value="팝콘"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="22"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>카라멜팝콘</strong>
                                <input type="hidden" name="goods" value="카라멜팝콘"></td>
                            <td>6000<input type="hidden" name="price" value="6000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="23"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>어니언팝콘</strong>
                                <input type="hidden" name="goods" value="어니언팝콘"></td>
                            <td>6000<input type="hidden" name="price" value="6000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="24"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>허니버터팝콘</strong>
                                <input type="hidden" name="goods" value="허니버터팝콘"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="25"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>초콜릿팝콘</strong>
                                <input type="hidden" name="goods" value="초콜릿팝콘"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
       </form>
       <form method="POST" 
    			action="${contextPath}/sales/productreg.do" 
    			id="frm-productreg">
        <div id="canteen5" class="card">
        
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        </div>
        
            <h5 class="card-header">
            	매점5
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th></th>
                            <th>상품</th>
                            <th>가격</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <tr>
                        		<td><input type="hidden" name="productNo" value="21"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>짜장면</strong>
                                <input type="hidden" name="goods" value="짜장면"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="22"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>짬뽕</strong>
                                <input type="hidden" name="goods" value="짬뽕"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="23"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>탕수육</strong>
                                <input type="hidden" name="goods" value="탕수육"></td>
                            <td>21000<input type="hidden" name="price" value="21000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="24"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>볶음밥</strong>
                                <input type="hidden" name="goods" value="볶음밥"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="25"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>냉면</strong>
                                <input type="hidden" name="goods" value="냉면"></td>
                            <td>9000<input type="hidden" name="price" value="9000"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
       </form>
       
       <form method="POST" 
    			action="${contextPath}/sales/productreg.do" 
    			id="frm-productreg">
        
        <div id="good1" class="card">
        
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        </div>
        
            <h5 class="card-header">
            	굿즈샵1
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th></th>
                            <th>상품</th>
                            <th>가격</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <tr>
                        		<td><input type="hidden" name="productNo" value="31"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>판다인형</strong>
                                <input type="hidden" name="goods" value="판다인형"></td>
                            <td>21000<input type="hidden" name="price" value="21000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="32"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>판다가방</strong>
                                <input type="hidden" name="goods" value="판다가방"></td>
                            <td>20000<input type="hidden" name="price" value="20000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="33"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>판다키링</strong>
                                <input type="hidden" name="goods" value="판다키링"></td>
                            <td>7000<input type="hidden" name="price" value="7000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="34"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>판다모자</strong>
                                <input type="hidden" name="goods" value="판다모자"></td>
                            <td>11000<input type="hidden" name="price" value="11000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="35"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>판다목걸이</strong>
                                <input type="hidden" name="goods" value="판다목걸이"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
       </form>
       
       <form method="POST" 
    			action="${contextPath}/sales/productreg.do" 
    			id="frm-productreg">
    			 
        <div id="good2" class="card">
        
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        </div>
        
            <h5 class="card-header">
          		굿즈샵2
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th></th>
                            <th>상품</th>
                            <th>가격</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <tr>
                        		<td><input type="hidden" name="productNo" value="31"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>수건</strong>
                                <input type="hidden" name="goods" value="수건"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="32"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>샤위밴드</strong>
                                <input type="hidden" name="goods" value="샤위밴드"></td>
                            <td>7000<input type="hidden" name="price" value="7000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="33"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>슬리퍼</strong>
                                <input type="hidden" name="goods" value="슬리퍼"></td>
                            <td>7000<input type="hidden" name="price" value="7000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="34"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>안대</strong>
                                <input type="hidden" name="goods" value="안대"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="35"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>칫솔</strong>
                                <input type="hidden" name="goods" value="칫솔"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
       </form>
       
       <form method="POST" 
    			action="${contextPath}/sales/productreg.do" 
    			id="frm-productreg">
       
        <div id="good3" class="card">
        
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        </div>
        
            <h5 class="card-header">
            	굿즈샵3
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th></th>
                            <th>상품</th>
                            <th>가격</th>
                            
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <tr>
                        		<td><input type="hidden" name="productNo" value="31"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>유리컵</strong>
                                <input type="hidden" name="goods" value="유리컵"></td>
                            <td>9000<input type="hidden" name="price" value="9000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="32"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>접시</strong>
                                <input type="hidden" name="goods" value="접시"></td>
                            <td>11000<input type="hidden" name="price" value="11000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="33"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>텀블러</strong>
                                <input type="hidden" name="goods" value="텀블러"></td>
                            <td>15000<input type="hidden" name="price" value="15000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="34"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>머그컵</strong>
                                <input type="hidden" name="goods" value="머그컵"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="35"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>팝콘통</strong>
                                <input type="hidden" name="goods" value="팝콘통"></td>
                            <td>17000<input type="hidden" name="price" value="17000"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
       </form>
       
       <form method="POST" 
    			action="${contextPath}/sales/productreg.do" 
    			id="frm-productreg"> 
       
        <div id="good4" class="card">
        
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        </div>
        
            <h5 class="card-header">
            	굿즈샵4
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th></th>
                            <th>상품</th>
                            <th>가격</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <tr>
                        		<td><input type="hidden" name="productNo" value="31"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>물총</strong>
                                <input type="hidden" name="goods" value="물총"></td>
                            <td>13000<input type="hidden" name="price" value="13000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="32"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>스노우볼</strong>
                                <input type="hidden" name="goods" value="스노우볼"></td>
                            <td>8000<input type="hidden" name="price" value="8000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="33"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>우산</strong>
                                <input type="hidden" name="goods" value="우산"></td>
                            <td>7000<input type="hidden" name="price" value="7000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="34"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>아마존티셔츠</strong>
                                <input type="hidden" name="goods" value="아마존티셔츠"></td>
                            <td>30000<input type="hidden" name="price" value="30000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="35"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>비눗방울</strong>
                                <input type="hidden" name="goods" value="비눗방울"></td>
                            <td>5000<input type="hidden" name="price" value="5000"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
       </form>
       
       <form method="POST" 
    			action="${contextPath}/sales/productreg.do" 
    			id="frm-productreg">
        
        <div id="good5" class="card">
        
        <div>
        	<button type="submit" id="regbtn" class="btn-reg">저장</button>
        </div>
        
            <h5 class="card-header">
            	굿즈샵5
            </h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-dark">
                    <thead>
                        <tr>
                        		<th></th>
                            <th>상품</th>
                            <th>가격</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <tr>
                        		<td><input type="hidden" name="productNo" value="31"></td>
                            <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>라마인형</strong>
                                <input type="hidden" name="goods" value="라마인형"></td>
                            <td>13000<input type="hidden" name="price" value="13000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="32"></td>
                            <td><i class="fab fa-react fa-lg text me-3"></i> <strong>래서판다인형</strong>
                                <input type="hidden" name="goods" value="래서판다인형"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="33"></td>
                            <td><i class="fab fa-vuejs fa-lg text me-3"></i> <strong>호랑이인형</strong>
                                <input type="hidden" name="goods" value="호랑이인형"></td>
                            <td>30000<input type="hidden" name="price" value="30000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="34"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>펭권인형</strong>
                                <input type="hidden" name="goods" value="펭권인형"></td>
                            <td>13000<input type="hidden" name="price" value="13000"></td>
                        </tr>
                        <tr>
                        		<td><input type="hidden" name="productNo" value="35"></td>
                            <td><i class="fab fa-bootstrap fa-lg text me-3"></i> <strong>드림이인형</strong>
                                <input type="hidden" name="goods" value="드림이인형"></td>
                            <td>10000<input type="hidden" name="price" value="10000"></td>
                        </tr>
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
showPage('ticket');

function myFunction() {
		var addRowIndex =6;
	  var table = document.getElementById("myTable");
	  var row = table.insertRow(addRowIndex);
	  var cell1 = row.insertCell(0);
	  var cell2 = row.insertCell(1);
	  var cell3 = row.insertCell(2);
	  var cell4 = row.insertCell(3);
	  cell1.innerHTML = "<input type='text' name='productNo'>";
	  cell2.innerHTML = "<td><i class='fab fa-bootstrap fa-lg text me-3'></i> <strong><input type='text' name='goods'></strong></td>";
	  cell3.innerHTML = "<td><input type='text' name='price'></td>";
	  cell4.innerHTML = "<td><button type='button' onclick='deleteRow(this)' class='btn_delete'>Delect</button>";
	  addRowIndex = addRowIndex + 1;
	}

function deleteRow(btn) {
		console.log('btn', btn)
	  var row = btn.parentNode.parentNode; // 클릭된 버튼의 부모 행을 찾습니다.
		console.log('row', row)
	  row.parentNode.removeChild(row);     // 테이블에서 해당 행을 제거합니다.
	}



</script>

	
	
