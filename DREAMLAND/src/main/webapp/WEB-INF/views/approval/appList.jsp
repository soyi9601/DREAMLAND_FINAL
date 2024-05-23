<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="./../layout/approvalList-header.jsp" />  


 
  <!-- Content wrapper -->
  <div class="content-wrapper">
   <!-- Content -->

   <div class="container-xxl flex-grow-1 container-p-y">
       <div class="col-12 col-md-6 col-lg-6">
           <div class="col-6 mb-4">
              <div class="post-list-container">
        <table class="post-list-table">
            <thead>
                <tr>
                    <th>문서 번호</th>
                    <th>제목</th>
                    <th>기안자</th>
                    <th>기안일</th>
                    <th>구분</th>
                </tr>
            </thead>
            <tbody id="post-list-body">
                <c:forEach var="approval" items="${approvalList}">
                    <tr class="approval">
                        <td class="column-doc-number"  style= "border: none;">${approval.apvNo}</td>
                        <td class="column-title" style= "border: none;">${approval.apvTitle}</td>
                        <td class="column-author" style= "border: none;">${approval.empNo}</td>
                        <td class="column-date" style= "border: none;">${approval.apvWriteDate}</td>
                        <td class="column-category" style= "border: none;">${approval.apvKinds}</td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot>
               <td colspan="4">${paging}</td>
            </tfoot>
        </table>
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
   
	 
	 const fnDetail = () => {
		   const approvalElements = document.getElementsByClassName('approval');

	        Array.from(approvalElements).forEach(element => {
	            element.addEventListener('click', (evt) => {
	                console.log(evt.target.parentElement.firstElementChild.textContent);
	            });
	        });
	 }
	 
	 fnDetail();
   
   </script>


    
<%@ include file=".././layout/footer.jsp" %>
