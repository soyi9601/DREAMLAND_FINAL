<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />

<style>
    .Allmagin {
        margin: 0px 200px 100px 200px;
    }
    .title {
        padding: 40px 40px 0px 30px;
        color: #90B54C;
    }
    .card-header {
        background-color: rgb(189,189,189,0.5);
        padding: 40px 40px 20px 30px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    .btn-list {
        width: 120px;
        float: right;
        margin-right: 20px;
        background-color: #90B54C;
        color: #FFFFFF;
    }
    .btn-reg {
        width: 120px;
        float: right;
        background-color: rgb(42, 115, 255);
        color: #FFFFFF;
    }
    .text-title {
        margin: 10px 40px 10px 30px;
    }
    .btn-add {
        width: 120px;
        float: right;
        border-radius: 5px;
        background-color: rgb(42, 115, 255);
        color: #FFFFFF;
    }
    .text-p {
        margin: 0px 40px 20px 30px;
    }
    th {
        text-align: center;
        height: 47px;
        color: #fff;
    }
    .text-nowrap {
        width: 100%;
        margin-top: 30px;
        background-color: #233446;
        padding: 0 12px;
    }
    .add_table {
        width: 100%;
    }
    .add_table tr, #myTable tr {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
    }
    .add_table thead {
        border-bottom: 1px solid #fff;
    }
    .add_table thead th, #myTable tr td {
        flex: 1;
        border: none;
        line-height: 47px;
    }
    #myTable tr {
        margin: 4px 0;
    }
    .last, #myTable tr td:last-child {
        max-width: 70px;
    }
    .form-control-sm {
        height: 20px;
    }
</style>

<!-- Content wrapper -->
<div class="content-wrapper">
    <div class="Allmagin">
        <form method="POST" action="${contextPath}/sales/productreg.do" id="frm-productreg">
            <h1 class="title">매출</h1>
            <!-- Bootstrap Dark Table -->
            <div class="card-header">
                <h2>상품등록
                    <button type="submit" id="regbtn" class="btn btn-primary btn-reg">저장</button>
                    <a href="${contextPath}/sales/productlist.do" class="btn btn-primary btn-list">목록</a>
                </h2>
            </div>
            <c:if test="${not empty requestScope.errorMessage}">
                <div class="alert alert-danger">
                    ${requestScope.errorMessage}
                </div>
            </c:if>
            <div>
                <h3 class="text-title">주의점</h3>
                <p class="text-p">추가버튼을 누르면 입력화면이 나옵니다.</p>
                <p class="text-p">상품번호는 숫자만 입력 가능합니다. 티켓의 상품번호는 10번대 나머지 상품들은 20번부터 입력해야합니다.</p>
                <p class="text-p">상품은 글자만 입력 가능합니다. 가격은 숫자만 입력 가능합니다. </p>
                <p class="text-p">차트번호는 숫자만 입력 가능합니다. 파트번호는 현재 5000~5530번까지 입력해야합니다.
                    <button type="button" class="btn btn-primary btn-add" onclick="myFunction()">추가</button>
                </p>
            </div>
            <div class="table-responsive text-nowrap">
                <table class="add_table">
                    <thead>
                        <tr>
                            <th>상품번호</th>
                            <th>상품</th>
                            <th>가격</th>
                            <th>파트번호</th>
                            <th class="last"></th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0" id="myTable">
                    </tbody>
                </table>
            </div>
        </form>
    </div>
</div>

<script>
//새로운 행을 추가하는 함수
function myFunction() {
    var table = document.getElementById("myTable"); // 테이블 요소를 가져옵니다.
    var row = table.insertRow(0);	// 테이블의 첫 번째 위치에 새로운 행을 추가합니다.
    var cell1 = row.insertCell(0); // 각 셀을 추가합니다.
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    var cell4 = row.insertCell(3);
    var cell5 = row.insertCell(4);
    
 		// 각 셀에 입력 필드와 삭제 버튼을 추가합니다.
    cell1.innerHTML = "<input type='text' name='productSctCd' class='form-control form-control-sm SctCd' oninput='handleOnInput(this, 2)'>";
    cell2.innerHTML = "<input type='text' name='productNM' class='form-control form-control-sm productNM' oninput='handleOnInput(this, 10)'>";
    cell3.innerHTML = "<input type='text' name='price' class='form-control form-control-sm price'>";
    cell4.innerHTML = "<input type='text' name='deptNo' class='form-control form-control-sm PdeptNo' oninput='handleOnInput(this, 4)'>";
    cell5.innerHTML = "<button type='button' onclick='deleteRow(this)' class='btn rounded-pill btn-danger btn_delete'>삭제</button>";
}

//행을 삭제하는 함수
function deleteRow(btn) {
    var row = btn.parentNode.parentNode; // 클릭된 버튼의 부모 행을 찾습니다.
    row.parentNode.removeChild(row); // 테이블에서 해당 행을 제거합니다.
}

//입력 필드의 길이를 제한하는 함수
function handleOnInput(el, maxlength) {
    if(el.value.length > maxlength)  {
        el.value = el.value.substr(0, maxlength);
    }
}

//상품번호 입력 필드의 유효성을 검사하는 함수
function fnCheckSctCd(event) {
    let inputs = document.querySelectorAll('.SctCd');
    let regSctCd = /^\d+$/; // 숫자만 입력되도록 정규 표현식 수정

    inputs.forEach(inpSctCd => {
        if (!inpSctCd.value || !regSctCd.test(inpSctCd.value)) {
            event.preventDefault();
            alert('상품번호는 숫자만 입력 가능하며, 공백은 허용되지 않습니다.');
            return;
        }
      return fnCheckNM(event);
    });
}

//상품명 입력 필드의 유효성을 검사하는 함수
function fnCheckNM(event) {
    let inputs = document.querySelectorAll('.productNM');
    let regProductNM = /^[^\s]+$/; // 공백이 아닌 문자열만 입력되도록 정규 표현식 수정

    inputs.forEach(inpProductNM => {
        if (!inpProductNM.value || !regProductNM.test(inpProductNM.value)) {
            event.preventDefault();
            alert('상품은 공백을 제외한 문자만 입력 가능합니다.');
            return;
        }
      return  fnCheckprice(event);
    });
}

//가격 입력 필드의 유효성을 검사하는 함수
function fnCheckprice(event) {
    let inputs = document.querySelectorAll('.price');
    let regprice = /^\d+$/; // 숫자만 입력되도록 정규 표현식 수정

    inputs.forEach(inpprice => {
        if (!inpprice.value || !regprice.test(inpprice.value)) {
            event.preventDefault();
            alert('가격은 숫자만 입력 가능하며, 공백은 허용되지 않습니다.');
            return;
        }
      return fnCheckPdeptNo(event);
    });
}

//파트번호 입력 필드의 유효성을 검사하는 함수
function fnCheckPdeptNo(event) {
    let inputs = document.querySelectorAll('.PdeptNo');
    let regPdeptNo = /^[5-6]\d{3}$/; // 5000에서 6000 사이의 숫자만 입력되도록 정규 표현식 수정

    inputs.forEach(inpPdeptNo => {
        if (!inpPdeptNo.value || !regPdeptNo.test(inpPdeptNo.value)) {
            event.preventDefault();
            alert('파트번호는 5000에서 6000 사이의 숫자만 입력 가능하며, 공백은 허용되지 않습니다.');
            return;
        }
    });
}

//추가 버튼 클릭 시 입력 필드 유효성 검사 함수를 호출하는 함수
function fnAddCheck(event) {
    var rowCount = document.getElementById("myTable").rows.length;

    if (rowCount === 0) {
        event.preventDefault();
        alert("상품을 추가해주세요.");
         return;
    }
    return fnCheckSctCd(event);
}

//등록 버튼 클릭 시 fnAddCheck 함수를 호출합니다.
document.getElementById('regbtn').addEventListener('click', function(event) {
    fnAddCheck(event);
});
</script>

<%@ include file="../layout/footer.jsp" %>