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
                      <tr>
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
                        </tr> 
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