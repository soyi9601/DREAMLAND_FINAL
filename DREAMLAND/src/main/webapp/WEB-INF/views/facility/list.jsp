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
<div class="content-wrapper">
    <!-- Content -->

    <div class="container-xxl flex-grow-1 container-p-y">
      <div class="sd-title sd-point">시설점검목록</div>
        
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
      
      <div>${paging}</div>
      
      <div class="sd-btn-write-area">
        <c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
          <button id="list-edit-btn">편집</button>
          <button id="list-del-btn">삭제</button>
          <p class="sd-btn-write">
            <a href="${contextPath}/facility/write.page">작성</a>
          </p>
        </c:if>
      </div>
  </div>
    <!-- / Content -->
</div>
</body>

<script>
const fnNoticeDetail = () =>{
    $(document).on('click', '.facilityline', (evt)=>{
        let facilityNo = $(evt.target).data('notice-no');
        if (facilityNo !== "undefined") {
            console.log(facilityNo); 
            location.href = '${contextPath}/facility/detail.do?facilityNo=' + facilityNo;
        }
    });
};

fnNoticeDetail();

const fnFacilityListEdit = () => {
    $(document).on('click', '#list-edit-btn', (evt) => {
        let checked = $("input[name='facilityChk']:checked");
        if (checked.length == 1) {
            let facilityNo = checked.val(); // facilityNo 변수 정의
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

const fnfacilityListDel = () => {
    $(document).on('click', '#list-del-btn', (evt) => {
        let checked = $("input[name='facilityChk']:checked");

        if (checked.length > 0) {
            let no = [];
            let idx = [];

            checked.each(function () {
                no.push($(this).val());
                idx.push($(this).data("idx"));
                console.log(checked);
            });

            let msg = checked.length == 1 ?
                '삭제할까요?' :
                idx.join(",") + '번 게시글을(를) 삭제할까요?';
            
            if (confirm(msg)) {
            	const url = `${contextPath}/facility/removeNo.do`;
                console.log("AJAX 요청 URL: ", url); // URL 확인용 로그
            	
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
                        console.error("Error:", error);
                        alert("삭제 요청 중 오류가 발생했습니다.");
                    }
                });
            }
        } else {
            alert("삭제할 게시글을 선택하세요.");
        }
    });

    function loadFacilityList() {
        location.reload();
    }
};

fnfacilityListDel();

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