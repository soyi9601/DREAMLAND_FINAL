<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee"
    value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />
<link rel="stylesheet" href="/resources/assets/vendor/fonts/boxicons.css" />

 		
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
        <c:if test="${not empty requestScope.errorMessage}">
        	<div class="alert alert-danger">
            ${requestScope.errorMessage}
        	</div>
    		</c:if>
        
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

                    
                    </tbody>
                </table>
            </div>
        </div> 
    </form>
</body>

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
	  cell1.innerHTML = "<td><input type='text' name='productSctCd' class='SctCd'></td>";
	  cell2.innerHTML = "<td><i class='fab fa-bootstrap fa-lg text me-3'></i> <strong><input type='text' name='productNM' class='productNM'></strong></td>";
	  cell3.innerHTML = "<td><input type='text' name='price' class='price'></td>";
	  cell4.innerHTML = "<td><input type='text' name='deptNo' class='PdeptNo'></td>";
	  cell5.innerHTML = "<td><button type='button' onclick='deleteRow(this)' class='btn_delete'>Delect</button></td>";
	  addRowIndex = addRowIndex + 1;
	}

function deleteRow(btn) {
		console.log('btn', btn)
	  var row = btn.parentNode.parentNode; // 클릭된 버튼의 부모 행을 찾습니다.
		console.log('row', row)
	  row.parentNode.removeChild(row);     // 테이블에서 해당 행을 제거합니다.
	}


const fnaddCheck = () => {	
	document.getElementById('regbtn').addEventListener('click', function(event) {
	    // 테이블에 추가된 행의 개수를 가져옵니다.
	    var rowCount = document.getElementById("myTable").rows.length;

	    // 추가된 행이 없는 경우 저장을 막고 알림을 표시합니다.
	    if (rowCount === 0) {
	        // 폼을 제출하지 않습니다.
	        event.preventDefault();
	        // 사용자에게 알림을 표시합니다.
	        alert("상품을 추가해주세요.");
	    }
	});
}

const fnCheckSctCd = () => {
    let inputs = document.querySelectorAll('.SctCd');
    let regSctCd = /^\d+$/; // 숫자만 입력되도록 정규 표현식 수정
    
    inputs.forEach(inpSctCd => {
    if (!inpSctCd.value || !regSctCd.test(inpSctCd.value)) {
    		event.preventDefault();
    		alert('상품번호는 숫자만 입력 가능하며, 공백은 허용되지 않습니다.');
        return;
    		} 
    });
}

const fnCheckNM = () => {
		let inputs = document.querySelectorAll('.productNM');
    let regProductNM = /^[^\s]+$/; // 공백이 아닌 문자열만 입력되도록 정규 표현식 수정
    
    inputs.forEach(inpProductNM => { 
    if (!inpProductNM.value || !regProductNM.test(inpProductNM.value)) {
        event.preventDefault();
        alert('상품은 공백을 제외한 문자만 입력 가능합니다.');
        NMCheck = false;
        return;
    		}
    });
}

const fnCheckprice = () => {
		let inputs = document.querySelectorAll('.price');
    let regprice = /^\d+$/; // 숫자만 입력되도록 정규 표현식 수정
    
    inputs.forEach(inpprice  => {   
    if (!inpprice.value || !regprice.test(inpprice.value)) {
    		event.preventDefault();
    		alert('가격은 숫자만 입력 가능하며, 공백은 허용되지 않습니다.');
    		priceCheck = false;
        return;
   		 } 
    });
}

const fnCheckPdeptNo = () => {
		let inputs = document.querySelectorAll('.PdeptNo');
    let regPdeptNo = /^\d+$/; // 숫자만 입력되도록 정규 표현식 수정
    
    inputs.forEach(inpPdeptNo	=> {
    if (!inpPdeptNo.value || !regPdeptNo.test(inpPdeptNo.value)) {
    		event.preventDefault();
    		alert('파트번호은 숫자만 입력 가능하며, 공백은 허용되지 않습니다.');
    		PdeptNoCheck = false;
        return;
    		} 
    });
}

document.getElementById('regbtn').addEventListener('click', fnCheckSctCd);
document.getElementById('regbtn').addEventListener('click', fnCheckNM);
document.getElementById('regbtn').addEventListener('click', fnCheckprice);
document.getElementById('regbtn').addEventListener('click', fnCheckPdeptNo);

fnaddCheck();
</script>

	
</html>
