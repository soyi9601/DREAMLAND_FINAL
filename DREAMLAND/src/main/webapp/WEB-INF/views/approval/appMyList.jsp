<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<jsp:include page="./../layout/apv-header.jsp" />  
  <!-- Content wrapper -->
  <div class="content-wrapper">
   <!-- Content -->

   <div class="container-xxl flex-grow-1 container-p-y">
       <div class="col-12 col-md-6 col-lg-6">
           <div class="col-6 mb-4">
              <div class="post-list-container">
                                     <h2 class="text-nowrap mb-2 text-primary">내 문서</h2>
              		<br>
          <div class="btn-group" role="group" aria-label="Basic example">
       				    <button type="button"  class="btn btn-secondary status-btn active" data-kind="total" >전체</button>
                  <button  type="button" class="btn btn-secondary status-btn" data-kind="wait">진행 중</button>
                  <button type="button" class="btn btn-secondary status-btn" data-kind="complete">승인</button>
                  <button type="button"  class="btn btn-secondary status-btn" data-kind="rejected">반려</button>
                  <button type="button"  class="btn btn-secondary status-btn" data-kind="temp">임시저장</button>
                </div>
                
					   <br>
					   <br>
					<table class="table">
					
					    <thead>
        <tr>
          <th>문서번호</th>
          <th>제목</th>
          <th>작성자</th>
          <th>작성일시</th>
          <th>문서상태</th>
        </tr>
      </thead>
        <tbody class="table-border-bottom-0" id="list">

         </tbody>
    </table>
  
            
                        <div class="tab-content">
                     <nav aria-label="Page navigation">
                         <ul class="pagination justify-content-center" id="pagingArea"></ul>
                       </nav>
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
   const list= document.getElementById("list");
	FnRequestAppList(kind, 1, 'DESC', 20, id);
	
    
	
   kindbtn.forEach(element => {
		    element.addEventListener('click', evt => {
		    	kindbtn.forEach(function(button) {
		                button.classList.remove('active');
		            });
		    	
		    	kind = evt.target.dataset.kind;
		    	 evt.target.classList.add('active');
		    	FnRequestAppList(kind, 1, 'DESC', 20, id);
		    });
		  });

   
   function  FnRequestAppList(kind, page, sort, display, id) { 
	   $('#list').empty();
 	   $.ajax({
		     // 요청
		     type: 'GET',
		     url: '${contextPath}/approval/'+ kind +'MyList.do?page='+page +'&sort='+ sort+ '&display=' +display +'&empNo=' + id,
		     // 응답
		     dataType: 'json',
		     success: (resData) => { 
		       totalPage = resData.totalPage;
		       $.each(resData.approvalList, (i, approval) => {
		    	   var state;
		    	   if(approval.apvCheck == 0) {
		    		   state = '진행중'
		    	   } else if(approval.apvCheck == 1) {
		    		   state = '승인'
		    	   } else if(approval.apvCheck == 2) {
		    		   state = '반려'
		    	   }else if(approval.apvCheck == 3) {
		    		   state = '임시저장'
		    	   }
		    	   list.innerHTML += '<tr class="approval" data-apv-no="'+  approval.apvNo  + '"><td data-apv-no="' +  approval.apvNo  + '">' + approval.apvNo  + '</td><td data-apv-no="' +  approval.apvNo  + '">' + approval.apvTitle + '</td><td data-apv-no="' +  approval.apvNo  + '">' + approval.empName + '</td><td data-apv-no="' +  approval.apvNo  + '">' + approval.apvWriteDate+ '</td><td data-apv-no="' +  approval.apvNo  + '">' + state + '</td></tr>';
		         
		       })
		       	       $('#pagingArea').empty();
		       $('#pagingArea').append(resData.paging);
		        clickableElements = document.querySelectorAll('#paging');
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
