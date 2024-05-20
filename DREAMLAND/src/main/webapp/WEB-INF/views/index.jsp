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
                 <div class="weather">
                   <div style="background-color : rgb(101, 178, 255); padding : 40px;color : #fff; height : 220px">
									    <div style="float : left;">
									        <div class="weather_icon"></div>
									    </div><br>
									
									    <div style="float : right; margin : -5px 0px 0px 60px; font-size : 11pt">
									            <div class="temp_min"></div>
									            <div class="temp_max"></div>
									            <div class="humidity"></div>
									            <div class="wind"></div>
									            <div class="cloud"></div>
									    </div>
									    <div style="float : right; margin-top : -45px;">
									        <div class="current_temp" style="font-size : 50pt"></div>
									        <div class="weather_description" style="font-size : 20pt"></div>
									        <div class="city" style="font-size : 13pt"></div>
									    </div>
									 </div>
                 </div>
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
             </div>
             <div class="col-md-4">
               <div class="card-body">
                 <div class="text-center"></div>
               </div>
               </div>
           </div>
         </div>
       </div>
     </div>
     
   </div>
   <!-- / Content -->            
   
   <script>
   var apiURI =" https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=6bde3279e91a83b26c3903c8ab07c8b6";
   const fnWeather = () => {
	   $.ajax({
		   type: 'GET',
		   url: apiURI,
		   data: 'json',
		   success: (resData) => {
			   console.log(resData);
		   },
		   error: (jqXHR) => {
			   alert("등록이상");
		   }
	   })
   }
   
   fnWeather();
   
   </script>


    
<%@ include file="./layout/footer.jsp" %>
