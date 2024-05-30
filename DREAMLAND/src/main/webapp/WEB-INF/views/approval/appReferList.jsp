<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<jsp:include page="./../layout/approvalList-header.jsp" />  

  <!-- Content wrapper -->
  <div class="content-wrapper">
   <!-- Content -->

   <div class="container-xxl flex-grow-1 container-p-y">
       <div class="col-12 col-md-6 col-lg-6">
           <div class="col-6 mb-4">
              <div class="post-list-container">
   						  <div>
       				    <button class="status-btn" data-kind="total">전체</button>
                  <button class="status-btn" data-kind="wait">진행 중</button>
                  <button class="status-btn" data-kind="complete">승인</button>
                  <button class="status-btn" data-kind="rejected">반려</button>
                </div>
            <div id="post-list-body">
            </div>
        <div class="footer">
            문서 수 : <span id="document-count">0</span>
            <div class="pagination">
                <span>1</span>
            </div>
        </div>
    </div>
             </div>
         </div>
       </div>
     </div>


   
   <script>
   
   var kind ='total';
   var clickableElements;
   const id=${loginEmployee.empNo}; 
   kindbtn = document.querySelectorAll('.status-btn');
   
   kindbtn.forEach(element => {
		    element.addEventListener('click', evt => {
		    	kind = evt.target.dataset.kind;
		    	FnRequestAppList(kind, 1, 'DESC', 20, id);
		    });
		  });

   
   function  FnRequestAppList(kind, page, sort, display, id) { 
	   $('#post-list-body').empty();
 	   $.ajax({
		     // 요청
		     type: 'GET',
		     url: '${contextPath}/approval/'+ kind +'MyReferList.do?page='+page +'&sort='+ sort+ '&display=' +display +'&empNo=' + id,
		     // 응답
		     dataType: 'json',
		     success: (resData) => { 
		       totalPage = resData.totalPage;
		       $.each(resData.approvalList, (i, approval) => {
		         str = '<div class="approval" data-apv-no="' +  approval.apvNo  + '">';
		         str += '<span data-apv-no="' +  approval.apvNo  + '">' + approval.apvNo  + '</span>';
		         str += '<span data-apv-no="' +  approval.apvNo  + '">' + approval.apvTitle + '</span>';
		         str += '<span data-apv-no="' +  approval.apvNo  + '">' + approval.empNo + '</span>';
		         str += '<span data-apv-no="' +  approval.apvNo  + '">' + approval.apvWriteDate+ '</span>';
		         str += '<span data-apv-no="' +  approval.apvNo  + '">' + approval.apvKinds + '</span>';
		         str += '</div>';
		         $('#post-list-body').append(str);
		       })
		       $('#post-list-body').append(resData.paging);
		        clickableElements = document.querySelectorAll('.paging');
				  clickableElements.forEach(element => {
				    element.addEventListener('click', evt => {
				      FnRequestAppList(kind,evt.target.dataset.page, 'DESC', 20, id );
				    });
				  });
				  
			        clickableElements2 = document.querySelectorAll('.approval');
					  clickableElements2.forEach(element => {
					    element.addEventListener('click', evt => {
					      window.location.href = '${contextPath}/approval/detail.do?apvNo='+ evt.target.dataset.apvNo+'&kind=' + kind ;
					    });
					  });

		     },
		     error: (jqXHR) => {
		       alert(jqXHR.statusText + '(' + jqXHR.status + ')');
		     }
		   });
   }
     
   </script>

	

    
<%@ include file=".././layout/footer.jsp" %>
