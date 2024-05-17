<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../layout/header.jsp" />  

   <div class="container mt-4">
     <h2 class="mb-3">올해 근무 정보</h2>
     
     <div class="row g-4 mb-5">
         <div class="col-md-6">
             <div class="p-3 border bg-light">
                 <h4>근태 현황</h4>
                 <p id="late_count">지각 : <span id="lateCount">0</span>회</p>
                 <p id="early_leave_count">조기퇴근 : <span id="earlyLeaveCount">0</span>회</p>
                 <p id="absence_count">결근 : <span id="absenceCount">0</span>회</p>
             </div>
         </div>
         <div class="col-md-6">
             <div class="p-3 border bg-light">
                 <h4>근무 시간</h4>
                 <p id="total_work_days">총 근무일수: <span id="totalWorkDays">0</span>일</p>
                 <p id="total_work_hours">총 근무시간: <span id="totalWorkHours">0</span>시간</p>
                 <p id="average_work_hours">평균 근무시간: <span id="averageWorkHours">0</span>시간</p>
             </div>
         </div>
     </div>
   </div>
   <div class="container mt-5">
       <div class="row">
           <div class="col-md-6">
               <label for="startDate">시작일:</label>
               <input type="date" id="startDate" class="form-control">
           </div>
           <div class="col-md-6">
               <label for="endDate">종료일:</label>
               <input type="date" id="endDate" class="form-control">
           </div>
       </div>
       <div class="row mt-3">
           <div class="col-md-12">
               <button id="searchButton" class="btn btn-primary">검색</button>
           </div>
       </div>
       <div class="row mt-3">
           <div class="col-md-12">
               <table class="table table-striped" id="resultsTable">
                   <thead>
                       <tr>
                           <th>날짜</th>
                           <th>출근시간</th>
                           <th>퇴근시간</th>
                           <th>총 근무시간</th>
                           <th>근무 상태</th>
                       </tr>
                   </thead>
                   <tbody>
                       <!-- 검색 결과가 여기에 표시됩니다 -->
                   </tbody>
               </table>
           </div>
       </div>
   </div>

   <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   <script>
       document.getElementById('searchButton').addEventListener('click', function() {
           var startDate = new Date(document.getElementById('startDate').value);
           var endDate = new Date(document.getElementById('endDate').value);
           if (startDate > endDate) {
               alert('시작일은 종료일보다 이전이어야 합니다.');
               return;
           }
           var resultsBody = document.querySelector('#resultsTable tbody');
           resultsBody.innerHTML = ''; // 테이블 초기화

           // 시뮬레이션을 위한 임시 데이터 생성 로직
           for (var date = startDate; date <= endDate; date.setDate(date.getDate() + 1)) {
               var formattedDate = date.toISOString().split('T')[0];
               resultsBody.innerHTML += `
                   <tr>
                       <td>${formattedDate}</td>
                       <td>09:00</td>
                       <td>18:00</td>
                       <td>9시간</td>
                       <td>정상</td>
                   </tr>
               `;
           }
       });
   </script>

    
<%@ include file="../layout/footer.jsp" %>    