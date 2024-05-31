<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<jsp:include page="../../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/sd_css.css" />




<!-- Content wrapper -->
<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">

    <div class="sd-title sd-point">FAQ게시판</div>

    <div class="row">
      <div class="col-md mb-4 mb-md-0">
        <ul class="faq-category-list">
          <li>
            <!-- 검색 쿼리가 있을 경우 이를 포함 --> <a
            href="${contextPath}/board/faq/list.do">전체</a>
          </li>
          <li><a href="${contextPath}/board/faq/sort.do?category=1"">
              1번 카테고리 </a></li>
          <li><a href="${contextPath}/board/faq/sort.do?category=2">
              2번 카테고리 </a></li>
          <li><a href="${contextPath}/board/faq/sort.do?category=3">
              3번 카테고리 </a></li>
          <li><a href="${contextPath}/board/faq/sort.do?category=4">
              4번 카테고리 </a></li>
          <li><a href="${contextPath}/board/faq/sort.do?category=5">
              5번 카테고리 </a></li>

        </ul>
        <%
        String paramValue = request.getParameter("category");
        %>
        <form method="GET" action="${contextPath}/board/faq/search.do">

          <div>
            <%
            if (paramValue != null && !paramValue.isEmpty()) {
            %>
            <input type="hidden" name="category" value="<%=paramValue%>">
            <%
            }
            %>
            <input type="text" name="query">

            <button type="submit">검색</button>
          </div>
        </form>



        <div class="accordion mt-3" id="accordionExample">

          <div class="card accordion-item">
            <h2 class="accordion-header" id="headingTwo">
              <button type="button" class="accordion-button collapsed"
                data-bs-toggle="collapse" data-bs-target="#accordionTwo"
                aria-expanded="false" aria-controls="accordionTwo">
                Accordion Item 2</button>
            </h2>
            <div id="accordionTwo" class="accordion-collapse collapse"
              aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
              <div class="accordion-body">Dessert ice cream donut oat
                cake jelly-o pie sugar plum cheesecake. Bear claw dragée oat
                cake dragée ice cream halvah tootsie roll. Danish cake oat cake
                pie macaroon tart donut gummies. Jelly beans candy canes carrot
                cake. Fruitcake chocolate chupa chups.</div>
            </div>
          </div>

          <!--  -->
          <div class="card accordion-item">
            <div class="accordion-header sdheader" id="headingTwo">
              <div class="sdtitle"></div>
              <div class="sdicon on"></div>
            </div>
            <div class="accordion-body">ㄴㅇㅎㄴㅇㅎㄴㅇㅎㄴㅇㅎㄶ</div>
          </div>
          <!--  -->
          <!-- 이거 -->
          <c:forEach items="${faqBoardList}" var="faq" varStatus="vs">
            <div class="card accordion-item">
              <div class="accordion-header faqheader" id="headingTwo">

                <div class="faqtitle">
                  
                    <span class=faq-no>${beginNo - vs.index}</span>
                    <span class="faq-category sd-point">
                      [
                      <c:if test="${faq.category==1}">인사</c:if>
                      <c:if test="${faq.category==2}">경영지원</c:if>
                      <c:if test="${faq.category==3}">안전관리</c:if>
                      <c:if test="${faq.category==4}">시설운영</c:if>
                      <c:if test="${faq.category==5}">마케팅</c:if>
                      ]
                    </span> 
                  
                  
                  <span class="faq-q">Q.</span> ${faq.boardTitle} 
                  <span style="display:none">index
                    : ${faq.faqNo}
                  </span> 
                  <span>${faq.employee.empName}gg</span>
                </div>
                <div class="faqicon on"></div>
              </div>
              <div class="accordion-body">
                <span class="faq-a">A.</span> ${faq.boardContents}
              
                <c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
                  <button type="button" class="btn-edit btn btn-warning btn-sm">편집</button>
                  <button type="button" class="btn-remove btn btn-danger btn-sm">삭제</button>
                  <input class="faqno" type="hidden" value="${faq.faqNo}">
                </c:if>
              </div>
            </div>
          </c:forEach>
          <!--  -->



        </div>
      </div>

    </div>
${loginEmployee.role}
    <div class="sd-btn-write-area">
      <c:if test="${loginEmployee.role eq 'ROLE_ADMIN' }">
        <p class="sd-btn-write">
          <a href="${contextPath}/board/faq/write.page">작성</a>
        </p>
      </c:if>
      
      
    </div>
    <div>${paging}</div>
  </div>
  <!--/ Accordion -->



  <!--/ Advance Styling Options -->
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
                    
//var frmBtn = $('#frm-btn');
/*
const fnEditFaq = () => {
  $(".btn-edit").on('click', (evt)=>{
    alert($(evt.target));
    location.href = '${contextPath}/board/faq/edit.do?faqNo='+$(evt.target).next().val();
  })
   
}
*/
                    
const fnEditFaq = () => {
  $(".btn-edit").on('click', (evt) => {
    //alert('gggg');
      const faqNo = $(evt.target).closest('.accordion-item').find('.faqno').val();
      location.href = '${contextPath}/board/faq/edit.do?faqNo=' + faqNo;
  });
}

const fnRemoveFaq = () => {
  $(".btn-remove").on('click', (evt) => {
    if(confirm('해당 게시글을 삭제할까요?')){
        const faqNo = $(evt.target).closest('.accordion-item').find('.faqno').val();
        location.href = '${contextPath}/board/faq/remove.do?faqNo=' + faqNo;
    }
  });
}

const fnAfterModifyFaq = () => {
  const modifyResult = '${modifyResult}';
  if(modifyResult !== '') {
    alert(modifyResult);
  }
}

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


