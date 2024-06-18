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

<Style>
	input[type="radio"] {
    pointer-events: none; /* 마우스 이벤트를 비활성화하여 클릭이 무시되도록 함 */
    cursor: not-allowed; /* 마우스 커서를 바꾸어 클릭이 불가능한 상태임을 나타냄 */
}
</Style>


<!-- Content wrapper -->
<div class="content-wrapper sd-board">
    <!-- Content -->

    <div class="container-xxl flex-grow-1 container-p-y">
      <div class="title sd-point">시설점검목록</div>
        
      <!-- Hoverable Table rows -->
      
      <div class="card sd-table-wrapper">
        <div class="table-responsive text-nowrap">
          <table class="table table-hover sd-table">
            <thead>
              <tr>
              	<th>번호</th>
                <c:if test="${loginEmployee.role eq 'ROLE_ADMIN'}">
                	<th>선택</th>
                </c:if>
                <th>시설명</th>
                <th>점검일자</th>
                <th>관리유무</th>
              </tr>
            </thead>
            <tbody class="table-border-bottom-0">
            	<c:forEach items="${loadFacilityList}" var="facility" varStatus="vs">
            		<tr>
            			<td>
            				<i class="fab fa-angular fa-lg text-danger me-3"></i>
            					${beginNo - vs.index}
            		  </td>
            		  <c:if test="${loginEmployee.role eq 'ROLE_ADMIN'}">
            		  	<td><input type="checkbox" name="facilityChk" value="${facility.facilityNo}" data-idx="${beginNo - vs.index}"/></td>
            		  </c:if>
            		  <td data-facility-name="${facility.facilityName}" class="facilityName">${facility.facilityName}</td>
            		  <td data-notice-no="${facility.facilityNo}" class="facilityline">${facility.facilityDate}</td>
            		  <td>
            		  	<c:if test="${facility.management eq 1}">
    									<input type="radio" checked="checked">
										</c:if>
										<c:if test="${facility.management eq 0}">
    									<input type="radio">
										</c:if>
            		  </td>
            		</tr>
            	</c:forEach>	
            </tbody>
          </table>
        </div>
      </div>
      <!--/ Hoverable Table rows -->
      

      <div class="sd-btns-area">
        <div>
          <c:if test="${loginEmployee.role eq 'ROLE_ADMIN'}">
            <button id="list-edit-btn" class="btn-reset sd-btn sd-gray-bg">편집</button>
            <button id="list-del-btn" class="btn-reset sd-btn sd-danger-bg">삭제</button>
          </c:if>
        </div>
        <c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
	        <div class="btn-reset sd-btn sd-point-bg" >
	          <a href="${contextPath}/facility/write.page">작성</a>
	        </div>
	      </c:if>
      </div>
      <div class="pagination">${paging}</div>
  </div>
    <!-- / Content -->
</div>
</body>

<script>
//상세 페이지로 이동하는 함수
const fnNoticeDetail = () =>{
    $(document).on('click', '.facilityName', (evt)=>{
        let facilityNo = $(evt.target).data('notice-no');
        if (facilityNo !== "undefined") {
            location.href = '${contextPath}/facility/detail.do?facilityNo=' + facilityNo;
        }
    });
};

fnNoticeDetail();

//공지사항 목록에서 편집 버튼 클릭 시 처리하는 함수
const fnFacilityListEdit = () => {
    $(document).on('click', '#list-edit-btn', (evt) => {
        let checked = $("input[name='facilityChk']:checked");
        if (checked.length == 1) {
            let facilityNo = checked.val(); // facilityNo 변수 정의
         		// 편집 페이지로 이동하는 폼 생성 및 제출
            let form = $('<form action="${contextPath}/facility/edit.do" method="post">' +
                '<input type="hidden" name="facilityNo" value="' + facilityNo + '"></input>' + '</form>');
            $('body').append(form);
            form.submit();
        } else {
            alert("편집할 게시글을 하나만 선택하세요");
        }
    })
}

fnFacilityListEdit();

//공지사항 목록에서 삭제 버튼 클릭 시 처리하는 함수
const fnfacilityListDel = () => {
    $(document).on('click', '#list-del-btn', (evt) => {
        let checked = $("input[name='facilityChk']:checked");

        if (checked.length > 0) {
            let no = [];
            let idx = [];

            checked.each(function () {
                no.push($(this).val());	// 선택된 시설번호 배열에 추가
                idx.push($(this).data("idx"));	// 선택된 인덱스 배열에 추가
            });

            let msg = checked.length == 1 ?
                '삭제할까요?' :
                idx.join(",") + '번 게시글을(를) 삭제할까요?';
            
            if (confirm(msg)) { // 확인 여부 다이얼로그 표시
            	const url = `${contextPath}/facility/removeNo.do`;
            		
                // 선택된 게시글 삭제 AJAX 요청
                $.ajax({
                    url: url, 
                    type: "POST",
                    data: { no: no },
                    traditional: true,
                    success: function (response) {
                        if (response === '삭제되었습니다.') {
                            alert("삭제되었습니다.");
                            loadFacilityList(); // 목록 갱신
                        } else {
                            alert("삭제할 게시글이 없습니다.");
                        }
                    },
                    error: function (xhr, status, error) {
                        alert("삭제 요청 중 오류가 발생했습니다.");
                    }
                });
            }
        } else {
            alert("삭제할 게시글을 선택하세요.");
        }
    });

    function loadFacilityList() {
        location.reload(); // 페이지 새로고침
    }
};

fnfacilityListDel();

//삭제 결과를 알리는 함수
const fnRemoveResult = () => {
    const removeResult = '${removeResult}';
    if (removeResult !== '') {
        alert(removeResult);
    }
};

fnRemoveResult();

</script>

<%@ include file="../layout/footer.jsp"%>

</html>