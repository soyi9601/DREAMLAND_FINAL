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
 		</style>

  

<body>

		<label for="pageSelect">파트 선택</label>
			<select id="pageSelect" onchange="showPage(this.value)">
    		<option value="tickets">티켓</option>
    		<option value="Zootopia">주토피아</option>
    		<option value="MagicLand">매직랜드</option>
    		<option value="AmericanAdventure">아메리칸어드벤처</option>
    		<option value="GloverFair">글로버페어</option>
    		<option value="EuropeanAdventure">유로피언어드벤처</option>
			</select>
   
     <!-- Bootstrap Dark Table -->
     <div id="tickets" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	       <div>
	        <button type="submit" id="regbtn" class="btn-reg" onclick="validateForm()">저장</button>
	        <input type="date" name="salesDate" id="salesDate">
	       </div>
	       	<h5 class="card-header">티켓</h5>
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
	              	<c:if test="${product.department.deptNo == 5000}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Tqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	        </div>
	     </form>
	   </div>
  
   
     <!-- Bootstrap Dark Table -->
     <div id="Zootopia" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	    		
	       <div>
	        <button type="submit" id="regbtn" class="btn-reg" onclick="validateForm()">저장</button>
	        <input type="date" name="salesDate" id="salesDate">
	       </div>
	       	<h5 class="card-header">주토피아</h5>
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
	              	<c:if test="${product.department.deptNo ge 5120 && product.department.deptNo le 5130}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Jqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	        </div>
	     </form>
	   </div>
	   
     <!-- Bootstrap Dark Table -->
     <div id="MagicLand" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	    		
	       <div>
	        <button type="submit" id="regbtn" class="btn-reg" onclick="validateForm()">저장</button>
	        <input type="date" name="salesDate" id="salesDate">
	       </div>
	       	<h5 class="card-header">매직랜드</h5>
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
	              	<c:if test="${product.department.deptNo ge 5220 && product.department.deptNo le 5230}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Mqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	        </div>
	     </form>
	   </div>
	   
     <!-- Bootstrap Dark Table -->
     <div id="AmericanAdventure" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	    		
	       <div>
	        <button type="submit" id="regbtn" class="btn-reg" onclick="validateForm()">저장</button>
	        <input type="date" name="salesDate" id="salesDate">
	       </div>
	       	<h5 class="card-header">아메리칸어드벤처</h5>
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
	              	<c:if test="${product.department.deptNo ge 5320 && product.department.deptNo le 5330}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Aqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	        </div>
	     </form>
	   </div>
	   
     <!-- Bootstrap Dark Table -->
     <div id="GloverFair" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	    		
	       <div>
	        <button type="submit" id="regbtn" class="btn-reg" onclick="validateForm()">저장</button>
	        <input type="date" name="salesDate" id="salesDate">
	       </div>
	       	<h5 class="card-header">글로버페어</h5>
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
	              	<c:if test="${product.department.deptNo ge 5420 && product.department.deptNo le 5430}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Gqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	        </div>
	     </form>
	   </div>
	   
     <!-- Bootstrap Dark Table -->
     <div id="EuropeanAdventure" class="card">
			 <form method="POST" 
	    			 action="${contextPath}/sales/salesreg.do" 
	    			 id="frm-salesreg">    		
	    		
	       <div>
	        <button type="submit" id="regbtn" class="btn-reg" onclick="validateForm()">저장</button>
	        <input type="date" name="salesDate" id="salesDate">
	       </div>
	       	<h5 class="card-header">유로피언어드벤처</h5>
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
	              	<c:if test="${product.department.deptNo ge 5520 && product.department.deptNo le 5530}"> 
	                	<td><input type="hidden" name="productNo" value="${product.productNo}">${product.productSctCd}</td>
	                  <td><i class="fab fa-angular fa-lg text me-3"></i> <strong>${product.productNM}</strong>
	                  <td><input type="text" name="qty" class="Uqty" oninput="validateNumberInput(this)"></td>
	                  <td><input type="hidden" name="deptNo" value="${product.department.deptNo}">${product.department.deptNo}</td>
	                </tr>
	               	</c:if>
	              </c:forEach>
	            </tbody>
	          </table>
	        </div>
	     </form>
	   </div>
 

      
</body>

<script>
function showPage(pageId) {
    const pages = document.querySelectorAll('.card');
    pages.forEach(page => {
        page.classList.remove('active');
    });
    document.getElementById(pageId).classList.add('active');
}

// Initialize to show the first page
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

function validateForm() {
    // 입력된 값이 비어 있는 경우
    var salesDate = document.getElementById("salesDate").value.trim();
    if (!salesDate) {
    		event.preventDefault();
        // 경고 창 표시
        alert("날짜를 지정하세요.");
        return false; // 폼 제출을 중단
    }
    return true; // 폼 제출
}
</script>

</html>


	
	
