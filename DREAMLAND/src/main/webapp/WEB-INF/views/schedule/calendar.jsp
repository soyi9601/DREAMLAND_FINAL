<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../layout/header.jsp" />
<!-- FullCalendar CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.11/index.global.min.js'></script>  

<!-- jQuery UI CSS -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery Library -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
 /*    body {
        margin: 40px 10px;
        padding: 0;
        font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
        font-size: 14px;
    } */
    
    #calendar {
        max-width: 1100px;
        margin: 0 auto;
    }

</style>
<body>
    
	<div class="container mt-5">
	    <div id='calendar'></div>
	</div>
	
	<!-- 일정 등록 모달 -->
	<form id="frm-schedule">
	  <div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">일정 추가</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                    <div class="mb-3">
	                        <label for="title" class="form-label">제목</label>
	                        <input type="text" class="form-control" id="title" name="title" required>
	                    </div>
	                    <div class="mb-3">
	                        <label for="start" class="form-label">시작일</label>
	                        <input type="datetime-local" class="form-control" id="start" name="start" required>
	                    </div>
	                    <div class="mb-3">
	                        <label for="end" class="form-label">종료일</label>
	                        <input type="datetime-local" class="form-control" id="end" name="end" required>
	                    </div>
	                    <div class="mb-3">
	                        <label for="category" class="form-label">카테고리</label>
	                        <select id="category" name="category" class="form-select">
	                            <option value="work" selected>업무</option>
	                            <option value="meeting">회의</option>
	                            <option value="outing">외근</option>
	                            <option value="business-trip">출장</option>
	                        </select>
	                    </div>
	                    <div class="mb-3">
                        <label for="shrEmpDept" class="form-label">공유할 사원 또는 부서 검색</label>
                        <input id="shrEmpDept" type="text" class="form-control" placeholder="사원 또는 부서명 입력">
                        <div id="empDept-result"></div>
                      </div>
	                    <div class="mb-3">
	                        <label for="color" class="form-label">일정색상</label>
	                        <select id="color" name="color" class="form-select" style="width: 100%;">
	                          <option value="gray"   style="color:#808080;" selected>회색</option>
	                          <option value="red"    style="color:#FF0000;">빨간색</option>
	                          <option value="orange" style="color:#FFA500;">주황색</option>
	                          <option value="yellow" style="color:#FFFF00;">노란색</option>
	                          <option value="green"  style="color:#008000;">초록색</option>
	                          <option value="blue"   style="color:#0000FF;">파란색</option>
	                          <option value="indigo" style="color:#000080;">남색</option>
	                          <option value="purple" style="color:#800080;">보라색</option>
	                        </select>
	                    </div>
	                    <div class="mb-3">
	                        <label for="contents" class="form-label">내용</label>
	                        <textarea class="form-control" id="contents" name="contents" style="width: 100%;" rows="3"></textarea> 
	                    </div>
	                    <!-- 세션 정보 -->
	                    <input type="hidden" name="empNo" value="${loginEmployee.empNo}"> 
	                    <!-- <input type="hidden" name="empNo" value="2">  --> 
	              
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	                    <button type="submit" class="btn btn-primary" id="btn-save">저장</button>
	                </div>   
	                </div>
	            </div>
	        </div>
	    </div>
	</form>

	<!-- 일정 수정 모달 -->
  <form id="frm-modify-schedule">
	 <div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">일정 수정</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	               <div class="modal-body">
	                   <div class="mb-3">
	                       <label for="modify_subject" class="form-label">제목</label>
	                       <input type="text" class="form-control" id="modify-title" name="title" required>
	                   </div>
	                   <div class="mb-3">
	                       <label for="modify-start" class="form-label">시작일</label>
	                       <input type="datetime-local" class="form-control" id="modify-start" name="start" required>
	                   </div>
	                   <div class="mb-3">
	                       <label for="modify-end" class="form-label">종료일</label>
	                       <input type="datetime-local" class="form-control" id="modify-end" name="end" required>
	                   </div>
	                   <div class="mb-3">
	                       <label for="modify-category" class="form-label">카테고리</label>
	                       <select id="modify-category" name="category" class="form-select">
	                           <option value="work">업무</option>
	                           <option value="meeting">회의</option>
	                           <option value="outing">외근</option>
	                           <option value="business-trip">출장</option>
	                       </select>
	                   </div>
	                   <div class="mb-3">
                        <label for="modify-shrEmpDept" class="form-label">공유할 사원 또는 부서 검색</label>
                        <input id="modify-shrEmpDept" type="text" class="form-control" placeholder="사원 또는 부서명 입력">
                        <div id="modify-empDept-result"></div>
                     </div>
	                    <div class="mb-3">
	                        <label for="modify-color" class="form-label">일정색상</label>
	                        <select id="modify-color" name="color" class="form-select" style="width: 100%;">
	                            <option value="gray"   style="color:#808080;">회색</option>
	                            <option value="red"    style="color:#FF0000;">빨간색</option>
	                            <option value="orange" style="color:#FFA500;">주황색</option>
	                            <option value="yellow" style="color:#FFFF00;">노란색</option>
	                            <option value="green"  style="color:#008000;">초록색</option>
	                            <option value="blue"   style="color:#0000FF;">파란색</option>
	                            <option value="indigo" style="color:#000080;">남색</option>
	                            <option value="purple" style="color:#800080;">보라색</option>
	                        </select>
	                    </div>
	                    <div class="mb-3">
	                        <label for="modify-contents" class="form-label">내용</label>
	                        <textarea class="form-control" id="modify-contents" name="contents" style="width: 100%;" rows="3"></textarea>
	                    </div>
	                    <input type="hidden" id="modify-skdNo" name="${skd.skdNo}">
	                </div>
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	                    <button type="submit" class="btn btn-primary" id="btn-modify-skd">저장</button>
	                </div>
	          </div>
	      </div>
	  </div>
 </form>

  <!-- 일정 상세보기 모달 -->
    <div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <!--     <h5 class="modal-title" id="detailModalLabel">일정 상세보기</h5> -->
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h5 id="detail-title"></h5>
                    <p>일정기간: <span id="detail-time"></span></p>
                    <p>작성자: <span id="detail-writer"></span></p>
                    <p>카테고리: <span id="detail-category"></span></p>
                    <p>공유부서: <span id="detail-deptNo"></span></p>
                    <p>내용: <span id="detail-contents"></span></p>
                </div>
                <div class="modal-footer">
                    <!-- <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button> -->
	                    <button type="button" class="btn btn-primary" id="btn-edit">수정</button>
	                    <button type="button" class="btn btn-danger" id="btn-remove">삭제</button>
	                    <input type="hidden" id="skdNo" name="skdNo" value="${skd.skdNo}">
                </div>
            </div>
        </div>
    </div> 

<script>
// 전역변수
  var calendar; 

  /*  
  document.addEventListener('DOMContentLoaded', function() {
       fnInitCalendar();
       setupAutocomplete('shrEmpDept', 'empDept-result');
       setupAutocomplete('modify-shrEmpDept', 'modify-empDept-result');
       initFormHandlers();
       initModifyHandlers();
       initRemoveHandlers();
   }); */

   // 일정 데이터 설정 + fullCalendar 초기화
   const fnInitCalendar = () => {
     
       // 로그인된 사용자의 사원번호와 부서번호 가져오기
       var empNo = '${loginEmployee.empNo}';
       var deptNo = '${loginEmployee.deptNo}';

       console.log("사원번호 :" + empNo);
       console.log("부서번호 :" + deptNo);

       // 필터링된 일정 리스트 이벤트 배열에 추가
       var eventArray = [];
       <c:forEach var='skd' items='${skdList}'>
       eventArray.push({
           id: '${skd.skdNo}',                 // 일정 ID
           title: '${skd.skdTitle}',           // 제목
           start: '${skd.skdStart}',           // 시작 시간
           end: '${skd.skdEnd}',               // 종료 시간
           backgroundColor: '${skd.skdColor}', // 일정 색상
           extendedProps: {               
               contents: '${skd.skdContents}', // 내용
               category: '${skd.skdCategory}', // 카테고리
               writer: '${skd.employee.empName}', // 작성자
               empNo: '${skd.employee.empNo}',    // 작성자 사원번호
               sharedItems: '<c:forEach var="dept" items="${skd.shrDept}">${dept.deptNo} </c:forEach>'.trim().split(' ').map(function(deptNo) {
                     return {                    
                         value: deptNo.trim(), // 공유부서
                         type: '부서'
                     };
                 }).concat('<c:forEach var="emp" items="${skd.shrEmp}">${emp.empNo} </c:forEach>'.trim().split(' ').map(function(empNo) {
                     return {                   
                         value: empNo.trim(), // 공유사원
                         type: '사원'
                     };
                 }))
             }
         });
       </c:forEach>

       console.log("전체일정 :", eventArray);
       
       // 캘린더 요소 선택 및 FullCalendar 초기화
       var calendarEl = document.getElementById('calendar');
       calendar = new FullCalendar.Calendar(calendarEl, { // 전역 변수로 참조
           headerToolbar: {
               left: 'prev,next today',
               center: 'title',
               right: 'dayGridMonth,timeGridWeek,timeGridDay'
           },
           dayMaxEvents: true,
           events: eventArray,
           dateClick: function(info) {
               $('#skdNo').val('');
               $('#title').val('');
               $('#start').val(info.dateStr + "T09:00");
               $('#end').val(info.dateStr + "T18:00");
               $('#category').val('work');
               $('#color').val('gray');
               $('#contents').val('');
               $('#shrEmpDept').val('');
               $('#insertModal').modal('show');
           },
           // 일정 상세보기 이벤트
           eventClick: function(info) { 
               var categoryText = $("#modify-category option[value='" + info.event.extendedProps.category + "']").text();

               $('#detail-title').text(info.event.title);
               $('#detail-time').text(moment(info.event.start).format('YYYY-MM-DD HH:mm') + ' ~ ' + moment(info.event.end).format('YYYY-MM-DD HH:mm'));
               $('#detail-writer').text(info.event.extendedProps.writer);
               $('#detail-category').text(categoryText);
               var sharedItemsText = info.event.extendedProps.sharedItems.map(function(item) {
                   return $("#modify-shrEmpDept option[value='" + item.value + "']").text() + " (" + item.type + ")";
               }).join(', ');
               $('#detail-deptNo').text(sharedItemsText);
               $('#detail-contents').text(info.event.extendedProps.contents);
               $('#skdNo').val(info.event.id);
               
               // 일정 작성자가 현재 로그인한 사원과 동일한 경우에만 수정/삭제 버튼 표시
               if (info.event.extendedProps.empNo == empNo) {
                   $('#btn-edit').show();
                   $('#btn-remove').show();
               } else {
                   $('#btn-edit').hide();
                   $('#btn-remove').hide();
               }

               $('#detailModal').modal('show');
           }
       });

       calendar.render();
   }
   
   // 공유 사원,부서 자동완성 검색 (jQuery UI Autocomplete)
   const fnEmpDeptList = (evt) => {
       $("#shrEmpDept").autocomplete({
           source: function(request, response) {  // source :  사용자가 입력한 검색어 기반으로 자동완성 함수
         $.ajax({
             type: 'GET',
             url: "${contextPath}/schedule/searchEmpDeptList",
             dataType: "json",
             data: { query: request.term },// 사용자가 입력한 검색어 (query) -> 서버로 전송
             success: function(resData) {  // 성공
            response(                      // 서버로부터 받은 데이터를 처리하여 자동완성 결과로 변환 
              $.map(resData.employees.concat(resData.departments), function(item) {
                 if (item.empName) {
                    // 사원
                    return {
                    	 label: item.empName + " (사원)",
                       value: "E" + item.empNo, // 접두사 'E' 추가 (서버 측에서 분별하기 위함)
                       type: "사원"
                     };
                 } else if (item.deptName) {
                    // 부서
                    return {
                    	label: item.deptName + " (부서)",
                      value: "D" + item.deptNo, // 접두사 'D' 추가 (서버 측에서 분별하기 위함)
                      type: "부서"
                   };
                 }
              })
           );
         },
           error: (jqXHR) => { // 실패
             alert(jqXHR.statusText + '(' + jqXHR.status + ')');
           }
        });
      }
      // 옵션
      ,focus : function(evt, ui){ return false; } // 방향키로 자동완성 키워드 선택 가능
      ,minLength: 1 // 최소 글자 수 설정
      ,delay: 300 // 검색 딜레이 시간 (밀리초 단위)
      ,autoFocus: true 
      ,appendTo: '#empDept-result'  // 검색 항목 출력할 요소 (div)
      ,select: function(event, ui) {
         // 선택된 항목 처리
         var selectedItem = ui.item.value;
         var resultContainerId = 'empDept-result'; // 선택된 항목을 표시할 컨테이너 ID
         $("#" + resultContainerId).append(
             '<button class="selectItem btn btn-primary btn-sm">' + ui.item.label + 
              '<input type="hidden" name="shrNo" value="' + selectedItem + '" data-type="' + ui.item.type + '">' +
             '</button>'
         );
         $('#shrEmpDept').val(''); // 입력 필드 초기화
         return false; // 기본 동작 막기
       }
   }); 
       
      // 선택된 항목 삭제 (버튼 클릭)
      $('#empDept-result').on('click', '.selectItem', function() {
          $(this).remove();
      });    
      
      // 모달창 닫힐 때 선택한 항목 초기화
       $('#insertModal, #modifyModal').on('hidden.bs.modal', function () {  // hidden.bs.modal : 부트스트랩 이벤트 (모달 닫히면 발생)
           $('#empDept-result').empty(); // 선택한 항목 초기화
           $('#shrEmpDept').val('');     // 입력 필드 비움
       });
   }
   
   // 일정 등록
   const fnRegisterSkd = () => {
       $('#frm-schedule').on('submit', function(e) {
           e.preventDefault(); // 폼의 기본 제출 동작 (새로고침)을 막음
           
           // 폼 데이터 배열에 저장
           var formData = $(this).serializeArray();
           // 선택된 사원 및 부서 배열 저장
           var selectedItems = $('#empDept-result input[name="shrNo"]').map(function() {
        	   return $(this).val();
           }).get();
           
           console.log("선택된 공유: ", selectedItems); 

           // 선택된 항목을 formData에 추가
           selectedItems.forEach(function(item) {
               formData.push({ name: 'shrNo', value: item });
           });
           
           $.ajax({
               type: "POST",
               url: "${contextPath}/schedule/register.do",
               data: formData,
               dataType: "json",
               success: function(resData) { 
                   if (resData.insertSkdCount === 1) {  // 일정 등록 성공
                       $('#insertModal').modal('hide'); // 모달 닫기
                       // 새로운 일정 이벤트 
                       var newEvent = {
                           id: resData.skdNo,  // 일정번호를 id로 사용
                           title: $('#title').val(), // 제목
                           start: $('#start').val(), // 시작 시간
                           end: $('#end').val(),     // 종료 시간
                           backgroundColor: $('#color').val(),  // 일정 색상
                           extendedProps: {
                               category: $('#category').val(),  // 카테고리
                               sharedItems: selectedItems.map(function(item) {
                                   return {
                                	    value: item,
                                      type: item.startsWith('E') ? '사원' : '부서'
                                   };
                               }),
                               contents: $('#contents').val(),      // 내용
                               writer: '${loginEmployee.empName}',  // 현재 로그인한 사용자명
                               empNo: empNo                         // 현재 로그인한 사용자 번호
                           }
                       };
                       // 캘린더에 새로운 일정 추가
                       calendar.addEvent(newEvent);  
                       calendar.render();   // 랜더링
                       $('#frm-schedule')[0].reset();  // 폼 초기화
                       $('#empDept-result').empty();   // 선택된 사원, 부서 항목 초기화
                   } else {
                       alert('일정 등록 실패했습니다.');
                       $('#frm-schedule')[0].reset();
                       $('#empDept-result').empty();
                   }
               },
               error: function(jqXHR) {
                   alert(jqXHR.statusText + '(' + jqXHR.status + ')');
               }
           });
       });
   }

   const fnModifySkd = () => {
	     // 상세 일정 모달창에서 수정 버튼 클릭
       $('#btn-edit').on('click', function() {
           var selectedSkdNo = $('#skdNo').val();   // 현재 선택된 일정 ID 가져오기
           var event = calendar.getEventById(selectedSkdNo); // FullCalendar에서 해당 일정 이벤트 가져오기
           
           // 선택한 일정 데이터 수정 모달창에 입력
           $('#modify-skdNo').val(selectedSkdNo);
           $('#modify-title').val(event.title);
           $('#modify-start').val(moment(event.start).format('YYYY-MM-DDTHH:mm'));
           $('#modify-end').val(moment(event.end).format('YYYY-MM-DDTHH:mm'));
           $('#modify-category').val(event.extendedProps.category);
           $('#modify-color').val(event.backgroundColor);
           $('#modify-contents').val(event.extendedProps.contents);
           
           // 공유 항목
           var sharedItems = event.extendedProps.sharedItems;
           //$('#modify-empDept-result').empty(); // 기존 선택한 항목 초기화
           sharedItems.forEach(function(item) {
            $('#modify-empDept-result').append(
                '<button class="selectItem btn btn-primary btn-sm m-1">' + item.label +
                '<input type="hidden" name="shrNo" value="' + item.value + '" data-type="' + item.type + '">' +
                '</button>'
             );
          });
           
           // 자동 완성 함수 호출
           fnEmpDeptList('modify-shrEmpDept', 'modify-empDept-result');
           
           // 상세보기 모달 숨기고 수정 모달 오픈
           $('#detailModal').modal('hide');
           $('#modifyModal').modal('show');
       });
       
	     // 일정 수정 폼
       $('#frm-modify-schedule').on('submit', function(e) {
           e.preventDefault();

           /* var formData = $(this).serializeArray();
           var selectedItems = $('#modify-empDept-result input[name="shrNo"]').map(function() {
               return $(this).val();
           }).get();
           selectedItems.forEach(function(item) {
               formData.push({ name: 'shrNo', value: item });
           }); */
           
           // 폼 데이터를 객체 형태로 저장
           var formData = {
               skdNo: parseInt($('#modify-skdNo').val()), // 일정 번호
               skdTitle: $('#modify-title').val(), // 일정 제목
               skdStart: $('#modify-start').val(), // 시작 시간
               skdEnd: $('#modify-end').val(), // 종료 시간
               skdCategory: $('#modify-category').val(), // 카테고리
               skdColor: $('#modify-color').val(), // 일정 색상
               skdContents: $('#modify-contents').val(), // 내용
               sharedItems: [] // 공유 항목 (사원 및 부서)
           };
           
           // 선택된 사원 및 부서 항목을 배열로 저장
           var selectedItems = $('#modify-empDept-result input[name="shrNo"]').map(function() {
               return {
                   value: $(this).val(),
                   type: $(this).data('type') // data-type 속성값
               };
           }).get();
           
           // 디버깅용
           console.log("선택된 공유(수정): ", selectedItems);
           
           // 선택된 항목을 formData.sharedItems에 추가
           formData.sharedItems = selectedItems;
           
           $.ajax({
               type: "POST",
               url: "${contextPath}/schedule/modify.do",
               contentType: "application/json",
               data: JSON.stringify(formData),
               dataType: "json",
               success: function(resData) {
                   if (resData.modifyCount === 1) {  // 일정 수정 성공
                       $('#modifyModal').modal('hide'); // 모달 닫기

                       // 수정된 일정 이벤트 객체 생성
                       var event = calendar.getEventById(formData.skdNo);
                       event.setProp('title', formData.skdTitle);
                       event.setStart(formData.skdStart);
                       event.setEnd(formData.skdEnd);
                       event.setProp('backgroundColor', formData.skdColor);
                       event.setExtendedProp('category', formData.skdCategory);
                       event.setExtendedProp('contents', formData.skdContents);
                       event.setExtendedProp('sharedItems', selectedItems.map(function(item) {
                           return {
                               value: item.value,
                               type: item.type
                           };
                       }));

                       calendar.render();
                       $('#frm-modify-schedule')[0].reset();
                       $('#modify-empDept-result').empty(); // 선택된 항목 초기화
                   } else {
                       alert('일정 수정 실패했습니다.');
                   }
               },
               error: function(jqXHR) {
                   alert(jqXHR.statusText + '(' + jqXHR.status + ')');
               }
           });
       });
   }

   const initRemoveHandlers = () => {
       $('#btn-remove').on('click', function() {
           if (confirm('일정 삭제할까요?')) {
               const skdNo = $('#skdNo').val();

               $.ajax({
                   type: "POST",
                   url: "${contextPath}/schedule/remove.do",
                   data: { skdNo: skdNo },
                   success: function(resData) {
                       if (resData.removeCount === 1) {
                           var event = calendar.getEventById(skdNo);
                           event.remove();
                           $('#detailModal').modal('hide');
                       } else {
                           alert('일정 삭제 실패했습니다.');
                       }
                   },
                   error: function(jqXHR) {
                       alert(jqXHR.statusText + '(' + jqXHR.status + ')');
                   }
               });
           }
       });
   }

 fnInitCalendar();
 fnEmpDeptList();
 fnModifySkd();
 initModifyHandlers();
 initRemoveHandlers();
 
 
</script>
    

<!-- <script src="../assets/js/pages-calendar.js"></script> -->
<%@ include file="../layout/footer.jsp" %>    