<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="./layout/header.jsp" />  
 
  <!-- Content wrapper -->
  <div class="content-wrapper">
   <!-- Content -->

   <div class="container-xxl flex-grow-1 container-p-y">
     <div class="row">
       <div class="col-12 col-md-6 col-lg-6">
         <div class="row">
           <div class="col-6 mb-4">
             <div class="card">
               <div class="card-body text-center">
                 <div class="card-title">
                   사진
                   
                 </div>
                 <span class="fw-semibold d-block mb-1">OO팀 OOO 주임<br/>111@example.com<br/>02-1234-5678</span>
               </div>
             </div>
           </div>
           <div class="col-6 mb-4">
             <div class="card">
               <div class="card-body">
                 <div class="card-title">
                   <h5 class="text-nowrap mb-2">오늘의 날씨</h5>                   
                 </div>
                 <div>날씨 API</div>
               </div>
             </div>
           </div>
           <div class="col-12 mb-4">
             <div class="card">
               <div class="card-body">
                 <div class="gap-3">
                   <div>
                     <div class="card-title">
                       <h5 class="text-nowrap mb-2">공지사항</h5>
                     </div>
                     <div class="table-responsive text-nowrap">
										    <table class="table">
										      <thead class="table-light">
										        <tr>
										          <th scope="col">공지번호</th>
										          <th scope="col">내용</th>
										        </tr>
										      </thead>
										      <tbody class="table-border-bottom-0">
										        <tr>
										          <td scope="col"><span class="fw-medium">1</span></td>
										          <td scope="col">Albert Cook</td>
										        </tr>
										        <tr>
                              <td scope="col"><span class="fw-medium">2</span></td>
                              <td scope="col">Albert Cook</td>
                            </tr>
										        <tr>
                              <td scope="col"><span class="fw-medium">3</span></td>
                              <td scope="col">Albert Cook</td>
                            </tr>
										      </tbody>
										    </table>
										  </div>
                   </div>
                 </div>
               </div>
             </div>
           </div>
         </div>
       </div>
       <div class="col-12 col-lg-6 order-2 mb-4">
         <div class="card">
           <div class="row row-bordered g-0">
             <div class="col-md-8">
               <h5 class="card-header m-0 me-2 pb-3">Total Revenue</h5>
               <div id="totalRevenueChart" class="px-2"></div>
             </div>
             <div class="col-md-4">
               <div class="card-body">
                 <div class="text-center">
                   <div class="dropdown">
                     <button
                       class="btn btn-sm btn-outline-primary dropdown-toggle"
                       type="button"
                       id="growthReportId"
                       data-bs-toggle="dropdown"
                       aria-haspopup="true"
                       aria-expanded="false"
                     >
                       2022
                     </button>
                     <div class="dropdown-menu dropdown-menu-end" aria-labelledby="growthReportId">
                       <a class="dropdown-item" href="javascript:void(0);">2021</a>
                       <a class="dropdown-item" href="javascript:void(0);">2020</a>
                       <a class="dropdown-item" href="javascript:void(0);">2019</a>
                     </div>
                   </div>
                 </div>
               </div>
               <div id="growthChart"></div>
               <div class="text-center fw-semibold pt-3 mb-2">62% Company Growth</div>

               <div class="d-flex px-xxl-4 px-lg-2 p-4 gap-xxl-3 gap-lg-1 gap-3 justify-content-between">
                 <div class="d-flex">
                   <div class="me-2">
                     <span class="badge bg-label-primary p-2"><i class="bx bx-dollar text-primary"></i></span>
                   </div>
                   <div class="d-flex flex-column">
                     <small>2022</small>
                     <h6 class="mb-0">$32.5k</h6>
                   </div>
                 </div>
                 <div class="d-flex">
                   <div class="me-2">
                     <span class="badge bg-label-info p-2"><i class="bx bx-wallet text-info"></i></span>
                   </div>
                   <div class="d-flex flex-column">
                     <small>2021</small>
                     <h6 class="mb-0">$41.2k</h6>
                   </div>
                 </div>
               </div>
             </div>
           </div>
         </div>
       </div>
     </div>
     
   </div>
   <!-- / Content -->            
   
   <script>
   
   
   </script>


    
<%@ include file="./layout/footer.jsp" %>
