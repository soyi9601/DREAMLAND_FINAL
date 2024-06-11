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

<!-- Content wrapper -->
<div class="content-wrapper sd-board" id="faq-board">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">

    <div class="title sd-point">FAQ</div>

    <div class="row">
      <div class="col-md mb-4 mb-md-0">
        <ul class="category-list">
          <li class="${empty param.category ? 'on' : ''}">
            <!-- 검색 쿼리가 있을 경우 이를 포함 --> <a
            href="${contextPath}/board/faq/list.do">전체</a>
          </li>
          <li class="${param.category == '1' ? 'on' : ''}">
            <a href="${contextPath}/board/faq/sort.do?category=1">
              인사 </a>
          </li>
          <li class="${param.category == '2' ? 'on' : ''}">
            <a href="${contextPath}/board/faq/sort.do?category=2">
              경영지원 </a>
          </li>
          <li  class="${param.category == '3' ? 'on' : ''}">
            <a href="${contextPath}/board/faq/sort.do?category=3">
              안전관리 </a>
          </li>
          <li class="${param.category == '4' ? 'on' : ''}">
            <a href="${contextPath}/board/faq/sort.do?category=4">
              시설운영 </a>
          </li>
          <li class="${param.category == '5' ? 'on' : ''}">
            <a href="${contextPath}/board/faq/sort.do?category=5">
              마케팅 </a>
          </li>
          <li class="${param.category == '6' ? 'on' : ''}">
            <a href="${contextPath}/board/faq/sort.do?category=6">
              기타 </a>
          </li>
        </ul>
        <%
        String paramValue = request.getParameter("category");
        %>
        <form method="GET" action="${contextPath}/board/faq/search.do">

          <div class="search-area">
            <%
            if (paramValue != null && !paramValue.isEmpty()) {
            %>
            <input type="hidden" name="category" value="<%=paramValue%>" >
            <%
            }
            %>
            <input type="text" name="query"
                    class="form-control border-0 shadow-none"
                    placeholder="검색"
                    aria-label="Search...">

            <button type="submit" class="faq-search-btn">
              <i class="bx bx-search"></i>
            </button>
          </div>
        </form>

        <div class="accordion mt-3" id="accordionExample">
          <!-- FAQ목록들 시작-->
          <c:choose>
					  <c:when test="${empty faqBoardList}">
					    <div class="no-results">
					      검색결과가 없습니다.
					    </div>
					  </c:when>
					  <c:otherwise>
         
		          <c:forEach items="${faqBoardList}" var="faq" varStatus="vs">
		            <div class="card accordion-item">
		              <div class="accordion-header faq-title-area" id="headingTwo">
		
		                <div class="faqtitle">
		                    <span class=faq-no>${beginNo - vs.index}.</span>
		                    <span class="faq-category sd-point">
		                      [
		                      <c:if test="${faq.category==1}">인사</c:if>
		                      <c:if test="${faq.category==2}">경영지원</c:if>
		                      <c:if test="${faq.category==3}">안전관리</c:if>
		                      <c:if test="${faq.category==4}">시설운영</c:if>
		                      <c:if test="${faq.category==5}">마케팅</c:if>
		                      <c:if test="${faq.category==6}">기타</c:if>
		                      ]
		                    </span> 
		                  
		                  <span class="faq-q">Q.</span> ${faq.boardTitle} 
		                  <span style="display:none">index
		                    : ${faq.faqNo}
		                  </span> 
		                </div>
		                <div class="faqicon on"></div>
		              </div>
		              <div class="accordion-body">
		                <span class="faq-a">A.</span> ${faq.boardContents}
		              
		                <c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
		                  <div class="button-area">
		                    <button type="button" class="btn-reset btn-edit sd-btn sd-gray-bg btn-sm">편집</button>
		                    <button type="button" class="btn-reset btn-remove sd-btn sd-danger-bg btn-sm">삭제</button>
		                  </div>
		                  <input class="faqno" type="hidden" value="${faq.faqNo}">
		                </c:if>
		                
		              </div>
		            </div>
		          </c:forEach>
            </c:otherwise>
          </c:choose>
          <!-- FAQ목록들 끝  -->
        </div>
      </div>
    </div>

    <div class="sd-btn-write-area">
      <c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
        <p class="sd-btn sd-point-bg">
          <a href="${contextPath}/board/faq/write.page">작성</a>
        </p>
      </c:if>
    </div>
      
      
		<c:choose>
		  <c:when test="${empty faqBoardList}"></c:when>
		  <c:otherwise>
		    <div class="pagination">${paging}</div>
		  </c:otherwise>
		</c:choose> 
      
  </div>
  <!--/ Accordion -->

</div>
<!-- / Content -->



<script>
                    
// 슬라이드 탭
$(".accordion-header").click(function(){
  if($(this).children('.faqicon').hasClass('on')){
    $(this).children('.faqicon').removeClass('on');
    $(this).children('.faqicon').addClass('on1');
  }else{
    $(this).children('.faqicon').removeClass('on1');
    $(this).children('.faqicon').addClass('on');
  }
  $(this).siblings('.accordion-body').slideToggle(400);
})

// 편집
const fnEditFaq = () => {
  $(".btn-edit").on('click', (evt) => {
      const faqNo = $(evt.target).closest('.accordion-item').find('.faqno').val();
      location.href = '${contextPath}/board/faq/edit.do?faqNo=' + faqNo;
  });
}
// 삭제
const fnRemoveFaq = () => {
  $(".btn-remove").on('click', (evt) => {
    if(confirm('해당 게시글을 삭제할까요?')){
        const faqNo = $(evt.target).closest('.accordion-item').find('.faqno').val();
        location.href = '${contextPath}/board/faq/remove.do?faqNo=' + faqNo;
    }
  });
}

// 수정 완료 메시지
const fnAfterModifyFaq = () => {
  const modifyResult = '${modifyResult}';
  if(modifyResult !== '') {
    alert(modifyResult);
  }
}

// 삭제 완료 메시지
const fnAfterDeleteFaq = () => {
    const modifyResult = '${removeResult}';
    if(modifyResult !== '') {
      alert(modifyResult);
    }
  }

fnEditFaq();  
fnAfterModifyFaq();
fnRemoveFaq();    
fnAfterDeleteFaq(); 

          
                 
</script>


<%@ include file="../../layout/footer.jsp"%>


