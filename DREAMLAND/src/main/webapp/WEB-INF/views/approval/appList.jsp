<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
<jsp:include page="./../layout/approvalList-header.jsp" />  

  <!-- Content wrapper -->
  <div class="content-wrapper">
   <!-- Content -->

   <div class="container-xxl flex-grow-1 container-p-y">
       <div class="col-12 col-md-6 col-lg-6">
           <div class="col-6 mb-4">
              <div class="post-list-container">
   						  <div>
       				    <button class="status-btn" id="전체">전체</button>
                  <button class="status-btn2" id="대기">대기</button>
                  <button class="status-btn3" id="확인">확인</button>
                  <button class="status-btn4" id="완료">완료</button>
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
   <!-- / Content -->            
   
   <script>
   
   var buttonvalue =0;
   
   document.addEventListener('DOMContentLoaded', () => {
	    const buttons = document.querySelectorAll('button[class^="status-btn"]');

	    buttons.forEach(button => {
	        button.addEventListener('click', () => {
	            console.log(button.id);
	            // 추가적인 로직을 여기에 작성하세요
	            // 예: 특정 상태에 따른 처리
	            switch (button.id) {
	                case '전체':
	                	buttonvalue =0;
	                    break;
	                case '대기':
	                	buttonvalue =1;
	                    break;
	                case '확인':
	                	buttonvalue =2;
	                    break;
	                case '완료':
	                	buttonvalue =3;
	                    break;
	                default:
	                	buttonvalue =4;
	                    break;
	            }
	        });
	    });
	});


   
   
   const fnGetApprovalList = () => {
	   
	   
	   
	   
	   
	   
	   let str ='';
	   // page 에 해당하는 목록 요청
	   
	   
	     switch (buttonvalue) {
                case 0:
             	   $.ajax({
             		     // 요청
             		     type: 'GET',
             		     url: '${contextPath}/approval/totalList.do',
             		     // 응답
             		     dataType: 'json',
             		     success: (resData) => {  // resData = {"blogList": [], "totalPage": 10}
             		       totalPage = resData.totalPage;
             		       $.each(resData.approvalList, (i, approval) => {
             		    	   
             		         str = '<div class="approval" data-apv-no="' +  approval.apvNo  + '">';
             		         str += '<span>' + approval.apvNo  + '</span>';
             		         str += '<span>' + approval.apvTitle + '</span>';
             		         str += '<span>' + approval.empNo + '</span>';
             		         str += '<span>' + approval.apvWriteDate+ '</span>';
             		         str += '<span>' +approval.apvKinds + '</span>';
             		         str += '</div>';
             		         $('#post-list-body').append(str);
             		         
             		       })
             		       str += resData.paging
             		       $('#post-list-body').append(str);
             		     },
             		     error: (jqXHR) => {
             		       alert(jqXHR.statusText + '(' + jqXHR.status + ')');
             		     }
             		   });
                    break;
                case 1:
              	   $.ajax({
           		     // 요청
           		     type: 'GET',
           		     url: '${contextPath}/approval/waitList.do',
           		     // 응답
           		     dataType: 'json',
           		     success: (resData) => {  // resData = {"blogList": [], "totalPage": 10}
           		       totalPage = resData.totalPage;
           		       $.each(resData.approvalList, (i, approval) => {
           		    	   
           		         str = '<div class="approval" data-apv-no="' +  approval.apvNo  + '">';
           		         str += '<span>' + approval.apvNo  + '</span>';
           		         str += '<span>' + approval.apvTitle + '</span>';
           		         str += '<span>' + approval.empNo + '</span>';
           		         str += '<span>' + approval.apvWriteDate+ '</span>';
           		         str += '<span>' +approval.apvKinds + '</span>';
           		         str += '</div>';
           		         $('#post-list-body').append(str);
           		         
           		       })
           		       str += resData.paging
           		       $('#post-list-body').append(str);
           		     },
           		     error: (jqXHR) => {
           		       alert(jqXHR.statusText + '(' + jqXHR.status + ')');
           		     }
           		   });
                    break;
                case 2:
              	   $.ajax({
           		     // 요청
           		     type: 'GET',
           		     url: '${contextPath}/approval/comfirmList.do',
           		     // 응답
           		     dataType: 'json',
           		     success: (resData) => {  // resData = {"blogList": [], "totalPage": 10}
           		       totalPage = resData.totalPage;
           		       $.each(resData.approvalList, (i, approval) => {
           		    	   
           		         str = '<div class="approval" data-apv-no="' +  approval.apvNo  + '">';
           		         str += '<span>' + approval.apvNo  + '</span>';
           		         str += '<span>' + approval.apvTitle + '</span>';
           		         str += '<span>' + approval.empNo + '</span>';
           		         str += '<span>' + approval.apvWriteDate+ '</span>';
           		         str += '<span>' +approval.apvKinds + '</span>';
           		         str += '</div>';
           		         $('#post-list-body').append(str);
           		         
           		       })
           		       str += resData.paging
           		       $('#post-list-body').append(str);
           		     },
           		     error: (jqXHR) => {
           		       alert(jqXHR.statusText + '(' + jqXHR.status + ')');
           		     }
           		   });
                    break;
                case 3:
              	   $.ajax({
           		     // 요청
           		     type: 'GET',
           		     url: '${contextPath}/approval/completeList.do',
           		     // 응답
           		     dataType: 'json',
           		     success: (resData) => {  // resData = {"blogList": [], "totalPage": 10}
           		       totalPage = resData.totalPage;
           		       $.each(resData.approvalList, (i, approval) => {
           		    	   
           		         str = '<div class="approval" data-apv-no="' +  approval.apvNo  + '">';
           		         str += '<span>' + approval.apvNo  + '</span>';
           		         str += '<span>' + approval.apvTitle + '</span>';
           		         str += '<span>' + approval.empNo + '</span>';
           		         str += '<span>' + approval.apvWriteDate+ '</span>';
           		         str += '<span>' +approval.apvKinds + '</span>';
           		         str += '</div>';
           		         $('#post-list-body').append(str);
           		         
           		       })
           		       str += resData.paging
           		       $('#post-list-body').append(str);
           		     },
           		     error: (jqXHR) => {
           		       alert(jqXHR.statusText + '(' + jqXHR.status + ')');
           		     }
           		   });
                    break;
                default:
                    break;
            }
	   
	   

	   
	 }
   
   fnGetApprovalList();
   
   </script>

	

    
<%@ include file=".././layout/footer.jsp" %>
