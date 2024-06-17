<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee"
    value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
 		
 		<style>
 		.card {
        display: none;
        }
    .card.active {
        display: block;
        }
    .Allmagin {
    		margin: 0px 200px 100px 200px;
    		}
    .Ss {
    		display: flex; 
    		justify-content: space-between;
    }
    .title {
    		padding: 40px 40px 0px 30px;
    		color:  #90B54C;
    }    
    select {
    		float: right;
    		height: 30px;
    		margin: 50px 50px 0px 30px;
    }
    .card-date {
    		display: flex; 
    }
    .salesDate {
    		height: 30px;
    		margin-top: 20px; 
    }
    th, tr {
 					text-align: center;  
 		}
 		.table table-dark {
 					width: 100%;
 		}
 		.btn-reg {
 						margin : 30px 25px 30px 0px;
 						height: 50px;
    				width: 120px;
    				float: right;
    				background-color: #90B54C;
    				color: #FFFFFF;
    }
 		</style>

<!-- Content wrapper -->
<div class="content-wrapper">  

<div class="Allmagin">
	<div class="Ss">		
		<h1 class="title">매출등록</h1>
			<label for="pageSelect"></label>
				<select id="pageSelect" onchange="showPage(this.value)">
    			<option value="tickets">티켓</option>
    			<option value="Zootopia">주토피아</option>
    			<option value="MagicLand">매직랜드</option>
    			<option value="AmericanAdventure">아메리칸어드벤처</option>
    			<option value="GloverFair">글로버페어</option>
    			<option value="EuropeanAdventure">유로피언어드벤처</option>
			</select>
	</div>
	
     <!-- Bootstrap Dark Table -->
     <div id="tickets" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	       <div class="card-date">
	       	<h5 class="card-header">티켓</h5>
	        <input type="date" name="salesDate" id="ticketDate" class="salesDate">
	       </div>
	       	
	       	<%-- Success Message --%>
					<c:if test="${not empty successMessage}">
					    <div class="alert alert-success" role="alert">
					        ${successMessage}
					    </div>
					</c:if>
					<%-- Error Message --%>
					<c:if test="${not empty errorMessage}">
					    <div class="alert alert-danger" role="alert">
					        ${errorMessage}
					    </div>
					</c:if>
					
	        <div class="table-responsive text-nowrap">
	        	<table class="table table-dark">
	          	<thead>
	            	<tr>
	              	<th>상품번호</th>
	                <th>상품</th>
	                <th>수량</th>
	                <th>파트번호</th>
	              </tr>
	            </thead>
	            <tbody class="table-border-bottom-0">
	            	<c:forEach items="${product}" var="product">
	              	<tr>
	              	<c:if test="${product.department.deptNo == 5000 && product.delyn != 'Y'}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Tqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	          <button type="submit" id="regbtn" class="btn btn-primary btn-reg" onclick="validateForm('ticketDate')">저장</button>
	        </div>
	     </form>
  	</div>	
   
     <!-- Bootstrap Dark Table -->
     <div id="Zootopia" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	    		
	       <div class="card-date">
	       	<h5 class="card-header">주토피아</h5>
	        <input type="date" name="salesDate" id="zootopiaDate" class="salesDate">
	       </div>
	       	
	       	<%-- Success Message --%>
					<c:if test="${not empty successMessage}">
					    <div class="alert alert-success" role="alert">
					        ${successMessage}
					    </div>
					</c:if>
					<%-- Error Message --%>
					<c:if test="${not empty errorMessage}">
					    <div class="alert alert-danger" role="alert">
					        ${errorMessage}
					    </div>
					</c:if>
					
	        <div class="table-responsive text-nowrap">
	        	<table class="table table-dark">
	          	<thead>
	            	<tr>
	              	<th>상품번호</th>
	                <th>상품</th>
	                <th>수량</th>
	                <th>파트번호</th>
	              </tr>
	            </thead>
	            <tbody class="table-border-bottom-0">
	            	<c:forEach items="${product}" var="product">
	              	<tr>
	              	<c:if test="${product.department.deptNo ge 5120 && product.department.deptNo le 5130 && product.delyn != 'Y'}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Jqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	          <button type="submit" id="regbtn" class="btn btn-primary btn-reg" onclick="validateForm('zootopiaDate')">저장</button>
	        </div>
	     </form>
	   </div>
	   
     <!-- Bootstrap Dark Table -->
     <div id="MagicLand" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	    		
	       <div class="card-date">
	       	<h5 class="card-header">매직랜드</h5>
	        <input type="date" name="salesDate" id="magicDate" class="salesDate">
	       </div>
	       	
	       	<%-- Success Message --%>
					<c:if test="${not empty successMessage}">
					    <div class="alert alert-success" role="alert">
					        ${successMessage}
					    </div>
					</c:if>
					<%-- Error Message --%>
					<c:if test="${not empty errorMessage}">
					    <div class="alert alert-danger" role="alert">
					        ${errorMessage}
					    </div>
					</c:if>
					
	        <div class="table-responsive text-nowrap">
	        	<table class="table table-dark">
	          	<thead>
	            	<tr>
	              	<th>상품번호</th>
	                <th>상품</th>
	                <th>수량</th>
	                <th>파트번호</th>
	              </tr>
	            </thead>
	            <tbody class="table-border-bottom-0">
	            	<c:forEach items="${product}" var="product">
	              	<tr>
	              	<c:if test="${product.department.deptNo ge 5220 && product.department.deptNo le 5230 && product.delyn != 'Y'}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Mqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	          <button type="submit" id="regbtn" class="btn btn-primary btn-reg" onclick="validateForm('magicDate')">저장</button>
	        </div>
	     </form>
	   </div>
	   
     <!-- Bootstrap Dark Table -->
     <div id="AmericanAdventure" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	    		
	       <div class="card-date">
	       	<h5 class="card-header">아메리칸어드벤처</h5>
	        <input type="date" name="salesDate" id="americanDate" class="salesDate">
	       </div>
	       	
	       		<%-- Success Message --%>
					<c:if test="${not empty successMessage}">
					    <div class="alert alert-success" role="alert">
					        ${successMessage}
					    </div>
					</c:if>
					<%-- Error Message --%>
					<c:if test="${not empty errorMessage}">
					    <div class="alert alert-danger" role="alert">
					        ${errorMessage}
					    </div>
					</c:if>
					
	        <div class="table-responsive text-nowrap">
	        	<table class="table table-dark">
	          	<thead>
	            	<tr>
	              	<th>상품번호</th>
	                <th>상품</th>
	                <th>수량</th>
	                <th>파트번호</th>
	              </tr>
	            </thead>
	            <tbody class="table-border-bottom-0">
	            	<c:forEach items="${product}" var="product">
	              	<tr>
	              	<c:if test="${product.department.deptNo ge 5320 && product.department.deptNo le 5330 && product.delyn != 'Y'}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Aqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	          <button type="submit" id="regbtn" class="btn btn-primary btn-reg" onclick="validateForm('americanDate')">저장</button>
	        </div>
	     </form>
	   </div>
	   
     <!-- Bootstrap Dark Table -->
     <div id="GloverFair" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	    		
	       <div class="card-date">
	       	<h5 class="card-header">글로버페어</h5>
	        <input type="date" name="salesDate" id="gloverDate" class="salesDate">
	       </div>
	       	
	       		<%-- Success Message --%>
					<c:if test="${not empty successMessage}">
					    <div class="alert alert-success" role="alert">
					        ${successMessage}
					    </div>
					</c:if>
					<%-- Error Message --%>
					<c:if test="${not empty errorMessage}">
					    <div class="alert alert-danger" role="alert">
					        ${errorMessage}
					    </div>
					</c:if>
					
	        <div class="table-responsive text-nowrap">
	        	<table class="table table-dark">
	          	<thead>
	            	<tr>
	              	<th>상품번호</th>
	                <th>상품</th>
	                <th>수량</th>
	                <th>파트번호</th>
	              </tr>
	            </thead>
	            <tbody class="table-border-bottom-0">
	            	<c:forEach items="${product}" var="product">
	              	<tr>
	              	<c:if test="${product.department.deptNo ge 5420 && product.department.deptNo le 5430 && product.delyn != 'Y'}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Gqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	          <button type="submit" id="regbtn" class="btn btn-primary btn-reg" onclick="validateForm('gloverDate')">저장</button>
	        </div>
	     </form>
	   </div>
	   
     <!-- Bootstrap Dark Table -->
     <div id="EuropeanAdventure" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	    		
	       <div class="card-date">
	       	<h5 class="card-header">유로피언어드벤처</h5>
	        <input type="date" name="salesDate" id="europeanDate" class="salesDate">
	       </div>
	       	
	       		<%-- Success Message --%>
					<c:if test="${not empty successMessage}">
					    <div class="alert alert-success" role="alert">
					        ${successMessage}
					    </div>
					</c:if>
					<%-- Error Message --%>
					<c:if test="${not empty errorMessage}">
					    <div class="alert alert-danger" role="alert">
					        ${errorMessage}
					    </div>
					</c:if>
					
	        <div class="table-responsive text-nowrap">
	        	<table class="table table-dark">
	          	<thead>
	            	<tr>
	              	<th>상품번호</th>
	                <th>상품</th>
	                <th>수량</th>
	                <th>파트번호</th>
	              </tr>
	            </thead>
	            <tbody class="table-border-bottom-0">
	            	<c:forEach items="${product}" var="product">
	              	<tr>
	              	<c:if test="${product.department.deptNo ge 5520 && product.department.deptNo le 5530 && product.delyn != 'Y'}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Uqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	          <button type="submit" id="regbtn" class="btn btn-primary btn-reg" onclick="validateForm('document.getElementById('europeanDate')')">저장</button>
	        </div>
	     </form>
	   </div>
</div> 

      

<script>
//페이지 ID에 해당하는 요소를 보여주는 함수
function showPage(pageId) {
    const pages = document.querySelectorAll('.card');
    pages.forEach(page => {
        page.classList.remove('active');
    });
    document.getElementById(pageId).classList.add('active'); // 주어진 pageId에 해당하는 요소에 'active' 클래스를 추가하여 보여줍니다.
}

//초기화: 'tickets' 페이지를 보여줍니다
showPage('tickets');

function validateNumberInput(inputField) {
    // 입력된 값이 숫자가 아닌 경우
    if (isNaN(inputField.value)) {
        // 경고 창 표시
        alert("숫자만 입력할 수 있습니다.");
        // 입력값 초기화
        inputField.value = "";
    }
}

function validateForm(id) {
    // 입력된 값이 비어 있는 경우
    var salesDate = document.getElementById(id)?.value?.trim();
    console.log('salesDate', salesDate)
    if (!salesDate) {
    	event.preventDefault();
        // 경고 창 표시
        alert("날짜를 지정하세요.");
        return false; // 폼 제출을 중단
    }
    return ture; // 폼 제출
}

validateForm();
</script>

</html>

<%@ include file="../layout/footer.jsp"%>