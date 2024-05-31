<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<jsp:include page="../../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />
<link rel="stylesheet" href="/resources/assets/vendor/fonts/boxicons.css" />


<!-- Content wrapper -->
<div class="content-wrapper">
		<!-- Content -->

		<div class="container-xxl flex-grow-1 container-p-y">
			<div class="sd-title sd-point">공지사항</div>

			<!-- Hoverable Table rows -->
			
			<div class="card sd-table-wrapper">
				<div class="table-responsive text-nowrap">
					<table class="table table-hover sd-table">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일자</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody class="table-border-bottom-0">
							<c:forEach items="${noticeBoardList}" var="notice" varStatus="vs">
								<tr>
									<td>
									<i class="fab fa-angular fa-lg text-danger me-3"></i>
									${beginNo - vs.index}
									</td>
									<td >
										<!--  <a class="noticeTitle" href="${contextPath}/board/notice/detail.do?noticeNo=${notice.noticeNo}" style="color:#777">-->
										
										<span data-notice-no="${notice.noticeNo}" class="noticeTitle">${notice.boardTitle}</span> 
										<c:if test="${notice.attachCount!=0}">
                  		<i class='bx bxs-file'></i>
                		</c:if>
                	</td>
									<td>${notice.employee.empName}</td>
									<td>${notice.boardCreateDt }</td>
									<td>${notice.hit}</td>
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
					<p class="sd-btn-write">
						<a href="${contextPath}/board/notice/write.page">작성</a>
					</p>
				</c:if>
			</div>
	</div>
		<!-- / Content -->
</div>


<script>
const fnNoticeDetail = () =>{
	

	$(document).on('click', '.noticeTitle', (evt)=>{
		//관리자의 경우, 조회수 증가 X
		if(${loginEmployee.empNo}===1 ){
		//	alert('관리자');
			location.href = '${contextPath}/board/notice/detail.do?noticeNo='+evt.target.dataset.noticeNo;
		}else{
			//관리자가 아닌 경우 조회수 증가 O
		//	alert('관리자가 아님')
			//alert(${loginEmployee.empNo});
			location.href = '${contextPath}/board/notice/updateHit.do?noticeNo='+evt.target.dataset.noticeNo;
		}
			
	})
}

fnNoticeDetail();
</script>

<%@ include file="../../layout/footer.jsp"%>