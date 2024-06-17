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
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

<!-- Content wrapper -->
<div class="content-wrapper">

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
    .text-p {
        margin: 0px 40px 20px 30px;
    }
    .btn-add {
        width: 120px;
        float: right;
        border-radius: 5px;
        background-color: rgb(42, 115, 255);
        color: #FFFFFF;
    }
    th {
        text-align: center;
        height: 47px;
        color: #fff;
    }
    .text-nowrap {
        width: 100%;
        margin-top: 30px;
        background-color: #fff;
        padding: 0 12px;
    }
    .table-hover {
        width: 100%;
    }
    .table-hover tr, #myTable tr {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
    }
    .table-hover thead {
        border-bottom: 1px solid #fff;
    }
    .table-hover thead th, #myTable tr td {
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
    .currentDate {
        margin-left: 35px;
    }
    .chkmanagement {
        margin-left: 80px;
    }
    </style>

<div class="Allmagin">

    <form method="POST" 
                enctype="multipart/form-data"
            action="${contextPath}/facility/register.do" 
            id="frm-facilityreg">
        
        <h1 class="title">시설점검</h1>
        <!-- Hoverable Table rows -->
    
        <div class="card-header">        
            <h2>시설등록 
                <button type="submit" id="regbtn" class="btn btn-primary btn-reg">저장</button>
                <a href="${contextPath}/facility/list.do" class="btn btn-primary btn-list">게시판</a>    
            </h2>    
        </div>    
        
        <div>
            <h3 class="text-title">주의점</h3>
            <p class="text-p">시설번호랑 시설명은 필수 입력해야합니다.</p>
            <p class="text-p">차트번호는 숫자만 입력 가능합니다. 파트번호는 현재  5000~5530까지부터 입력하세요.</p>
            <p class="text-p">시설파일첨부는 용량 10MB까지 가능합니다.<button type="button" class="btn btn-primary btn-add" onclick="myFunction()">추가</button></p>
        </div>

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
                <th class="last"></th>
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
</div>

<script>
//현재 날짜를 화면에 표시하는 함수
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
window.onload = showCurrentDate; // 페이지 로드 시 현재 날짜 표시 함수 호출
      
//새로운 행을 추가하는 함수
function myFunction() {
    var addRowIndex = 1;
    var table = document.getElementById("myTable");
    var row = table.insertRow(addRowIndex); // 새로운 행 삽입
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    var cell4 = row.insertCell(3);
    var cell5 = row.insertCell(4);
    var cell6 = row.insertCell(5);
    var cell7 = row.insertCell(6);
 		// 각 셀에 입력 요소 추가
    cell1.innerHTML = "<td><input type='text'  class='form-control form-control-sm deptNo' name='deptNo' id='deptNo' oninput='handleOnInput(this, 4)'></td>";
    cell2.innerHTML = "<td><input type='text'  class='form-control form-control-sm facilityName' name='facilityName' id='facilityName' oninput='handleOnInput(this, 10)'></td>";
    cell3.innerHTML = "<span id='currentDate' class='currentDate'></span>";
    cell4.innerHTML = "<td><input type='checkbox' class='chkmanagement' name='management'/></td>";
    cell5.innerHTML = "<td><textarea id='basic-default-message' class='form-control remarks' name='remarks' oninput='handleOnInput(this, 166)'></textarea></td>";
    cell6.innerHTML = "<td><input class='form-control' type='file' name='files' id='files'/></td>";
    cell7.innerHTML = "<td><button type='button' onclick='deleteRow(this)' class='btn rounded-pill btn-danger btn_delete'>삭제</button></td>";
    
    var currentDateElement = row.querySelector('#currentDate');
    if (currentDateElement) {
        var options = { year: 'numeric', month: 'long', day: 'numeric' };
        var currentDate = new Date().toLocaleDateString('ko-KR', options);
        currentDateElement.textContent = currentDate; // 새로 추가된 행의 현재 날짜 설정 
    }
    
    addRowIndex = addRowIndex + 1;
}
    
//행 삭제 함수    
function deleteRow(btn) {
    var row = btn.parentNode.parentNode; // 클릭된 버튼의 부모 행을 찾습니다.
    row.parentNode.removeChild(row);     // 테이블에서 해당 행을 제거합니다.
}

//입력 필드 길이 제한 처리 함수
function handleOnInput(el, maxlength) {
    if(el.value.length > maxlength)  {
        el.value = el.value.substr(0, maxlength); // 최대 길이 초과 시 입력 값을 자릅니다.
    }
}

//관리 체크박스 처리 함수
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

//시설 등록 폼 검증 함수
const fnRegister = () => {
    document.getElementById('frm-facilityreg').addEventListener('submit', (evt) => {
        if(document.getElementById('facilityName').value === '') {
            alert('시설명은 필수입니다.');
            evt.preventDefault();
            return;
        }
    })
}

//시설번호 범위 검증
document.getElementById('frm-facilityreg').addEventListener('submit', (evt) => {
    const deptNos = document.querySelectorAll('.deptNo');
    for (let deptNo of deptNos) {
        const value = parseInt(deptNo.value, 10);
        if (isNaN(value) || value < 5000 || value > 6000) {
            alert("시설번호는 5000에서 6000 사이의 값이어야 합니다.");
            evt.preventDefault();
            return;
        }
    }
});

//첨부 파일 크기 검증
document.getElementById('frm-facilityreg').addEventListener('submit', (evt) => {
    const fileInputs = document.querySelectorAll('input[type="file"]');
    const maxSize = 10 * 1024 * 1024; // 10MB

    for (let input of fileInputs) {
        if (input.files.length > 0) {
            const file = input.files[0];
            if (file.size > maxSize) {
                alert("파일 크기는 10MB를 초과할 수 없습니다.");
                evt.preventDefault();
                return;
            }
        }
    }
});

//시설 추가 여부 검증 함수
function fnAddCheck(event) {
    var rowCount = document.getElementById("myTable").rows.length;
    if (rowCount <= 1) { // 행이 헤더만 있는 경우
        event.preventDefault();
        alert("시설을 추가해주세요.");
    }
}

fnRegister(); // 시설 등록 폼 검증 함수 호출
fnCkgMng(); // 관리 체크박스 처리 함수 호출

//등록 버튼 클릭 시 시설 추가 여부 검증 함수 호출
document.getElementById('regbtn').addEventListener('click', function(event) {
    fnAddCheck(event);
});
</script>

<%@ include file="../layout/footer.jsp" %>