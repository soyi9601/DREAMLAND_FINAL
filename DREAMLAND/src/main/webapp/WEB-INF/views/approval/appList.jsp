<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <c:forEach var="post" items="${postList}">
                    <tr>
                        <td class="column-doc-number">${post.documentNumber}</td>
                        <td class="column-title">${post.title}</td>
                        <td class="column-author">${post.author}</td>
                        <td class="column-date">${post.date}</td>
                        <td class="column-category">${post.category}</td>
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
   
   const fnDisplay = () => {
	   document.getElementById('display').value = '${display}';
	   document.getElementById('display').addEventListener('change', (evt) => {
	     location.href = '${contextPath}/upload/list.do?page=1&sort=${sort}&display=' + evt.target.value;
	   })
	 }

	 const fnSort = () => {
	   $(':radio[value=${sort}]').prop('checked', true);
	   $(':radio').on('click', (evt) => {
	     location.href = '${contextPath}/upload/list.do?page=${page}&sort=' + evt.target.value + '&display=${display}';
	   })
	 }

	 fnDisplay();
	 fnSort();
   
   </script>


    
<%@ include file=".././layout/footer.jsp" %>
