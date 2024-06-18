<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../layout/header.jsp" />
<!-- css link -->
<link rel="stylesheet" href="/resources/assets/css/calendar.css" />

<!-- FullCalendar CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.11/index.global.min.js'></script>

<!-- jQuery UI CSS -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery Library -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<body>
 <div class="container-xxl flex-grow-1 container-p-y">
<div class="card card-calendar">
      <div class="card-body">
        <div id='calendar'></div>
      </div>
    </div>
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
	                            <option value="team-meeting">회의</option>
	                            <option value="business-meeting">미팅</option>
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
	              
	                <div class="modal-footer">
	                    <button id="btn-close" type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	                    <button id="btn-save" type="submit" class="btn btn-primary">저장</button>
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
	                           <option value="work" selected>업무</option>
                             <option value="team-meeting">회의</option>
                             <option value="business-meeting">미팅</option>
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
	                    <button id="btn-modify-skd" type="submit" class="btn btn-primary">저장</button>
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
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h5 id="detail-title"></h5>
                    <p>일정기간: <span id="detail-time"></span></p>
                    <p>작성자: <span id="detail-writer"></span></p>
                    <p>카테고리: <span id="detail-category"></span></p>
                    <p>공유: <span id="detail-EmpDeptNo"></span></p>
                    <p>내용: <span id="detail-contents"></span></p>
                </div>
                <div class="modal-footer">
	                    <button id="btn-edit" type="button" class="btn btn-primary">수정</button>
	                    <button id="btn-remove" type="button" class="btn btn-danger">삭제</button>
	                    <input type="hidden" id="skdNo" name="skdNo" value="${skd.skdNo}"> 
                </div>
            </div>
        </div>
    </div> 

<script>
  // 전역변수
  var calendar; 
  var empNo = '${loginEmployee.empNo}'; // 로그인한 사용자의 사원번호
  var deptNo = '${loginEmployee.deptNo}'; // 로그인한 사용자의 부서번호


   // 일정 데이터 설정 + fullCalendar 초기화
   const fnGetSkdList = () => {

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
       
       // 캘린더 요소 선택 및 FullCalendar 초기화
       var calendarEl = document.getElementById('calendar');
       calendar = new FullCalendar.Calendar(calendarEl, { // 전역 변수로 참조
           headerToolbar: {
               left: 'prev,next today',
               center: 'title',
               right: 'dayGridMonth,timeGridWeek,timeGridDay'
           },
           locale: 'ko',
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
           eventTimeFormat: { // 시간 형식 설정
               hour: 'numeric',
               meridiem: 'short' // 'short'을 사용하여 am/pm으로 표시
             },
           // 일정 클릭하면 상세보기 모달 오픈 (함수 호출)
           eventClick: fnShowDetailModal ,
           dayCellContent: function(info) {
     	      // 날짜 텍스트를 숫자만 남기고 '일'을 제거
     	      var number = document.createElement('span');
     	      number.classList.add('fc-daygrid-day-number');
     	      number.innerHTML = info.date.getDate(); // 날짜를 숫자로 표시

     	      if (info.view.type === 'dayGridMonth') {
     	        return {
     	          html: number.outerHTML
     	        };
     	      } else {
     	        return {
     	          domNodes: []
     	        };
     	      }
     	    } 
        });
        calendar.render();  // 캘린더 랜더링
     }
   
   // 일정 상세보기
   const fnShowDetailModal = (info) => {
	   var selectedSkdNo = info.event.id;
    
    // 선택된 일정 상세 데이터 가져오기
    $.ajax({
        type: 'GET',
        url: "${contextPath}/schedule/detail.do",
        data: { skdNo: selectedSkdNo },
        success: function(schedule) {
            // 선택한 일정 데이터 상세보기 모달창에 입력
            $('#skdNo').val(schedule.skdNo);
            $('#detail-title').text(schedule.skdTitle);
            $('#detail-time').text(moment(schedule.skdStart).format('YYYY-MM-DD HH:mm') + ' ~ ' + moment(schedule.skdEnd).format('YYYY-MM-DD HH:mm'));
            $('#detail-writer').text(schedule.employee.empName);
            $('#detail-contents').text(schedule.skdContents);
            // 카테고리 한글 변환
            var categoryText = {
                'work': '업무',
                'team-meeting': '회의',
                'business-meeting' : '미팅',
                'outing': '외근',
                'business-trip': '출장'
            }[schedule.skdCategory];
            $('#detail-category').text(categoryText);

            // 공유 항목
            var sharedItemsText = schedule.sharedItems.map(function(item) {
                var label, value;
                if (item.includes("사원")) {
                    label = item.substring(0, item.indexOf('E'));
                    value = item.substring(item.indexOf('E'));
                } else if (item.includes("부서")) {
                    label = item.substring(0, item.indexOf('D'));
                    value = item.substring(item.indexOf('D'));
                }
                return label;
            }).join(', ');

            $('#detail-EmpDeptNo').text(sharedItemsText);

            // 일정 작성자가 현재 로그인한 사원과 동일한 경우에만 수정/삭제 버튼 표시
            if (schedule.employee.empNo == empNo) {
                $('#btn-edit').show();
                $('#btn-remove').show();
            } else {
                $('#btn-edit').hide();
                $('#btn-remove').hide();
            }

            $('#detailModal').modal('show');
        },
        error: function(jqXHR) {
            alert(jqXHR.statusText + '(' + jqXHR.status + ')');
        }
    });
}

   // 공유 사원,부서 자동완성 검색 (jQuery UI Autocomplete) -> 일정등록, 일정수정에 사용
   const fnEmpDeptList = (inputId, resultId) => { 
       $('#' + inputId).autocomplete({
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
                   error: function(jqXHR) { // 실패
                       alert(jqXHR.statusText + '(' + jqXHR.status + ')');
                   }
               });
           },
           // 옵션
           focus: function(evt, ui){ return false; }, // 방향키로 자동완성 키워드 선택 가능
           minLength: 1, // 최소 글자 수 설정
           delay: 300, // 검색 딜레이 시간 (밀리초 단위)
           autoFocus: true,
           appendTo: '#' + resultId,  // 선택 항목 출력할 요소 (div)
           select: function(event, ui) {
               // 선택된 항목 처리
               var selectedItem = ui.item.value;
               $("#" + resultId).append(
                   '<button class="selectItem btn btn-primary btn-sm m-1">' + ui.item.label + 
                   '<input type="hidden" name="shrNo" value="' + selectedItem + '" data-type="' + ui.item.type + '">' +
                   '</button>'
               );
               $('#' + inputId).val(''); // 검색창 초기화
               return false; // 기본 동작 막기
           },
           open: function() {
               $(".ui-autocomplete").addClass("dropdown-menu show"); // 부트스트랩 드롭다운 스타일 적용
           }
       });

       // 선택된 항목 삭제 (버튼 클릭)
       $('#' + resultId).on('click', '.selectItem', function() {
           $(this).remove();
       });

       // 모달 창이 닫힐 때 선택한 항목 초기화
       $('#insertModal, #modifyModal').on('hidden.bs.modal', function() {
    	     $('#' + resultId).empty();
           $('#' + inputId).val('');
       });
       // 모달이 열릴 때마다 자동 완성 기능을 재설정
       $('#insertModal, #modifyModal').on('shown.bs.modal', function () {
           fnEmpDeptList(inputId, resultId);
       });
   };

   // 일정 등록
   const fnRegisterSkd = () => {
       $('#frm-schedule').on('submit', function(e) {
          e.preventDefault(); // 폼의 기본 제출 동작 (새로고침)을 막음

           var formData = $(this).serializeArray();
           var selectedItems = $('#empDept-result input[name="shrNo"]').map(function() {
               return $(this).val();
           }).get();

           selectedItems.forEach(function(item) {
               formData.push({ name: 'shrNo', value: item });
           });

           $.ajax({
               type: 'POST',
               url: '${contextPath}/schedule/register.do',
               data: formData,
               dataType: 'json',
               success: function(resData) {
                   if (resData.insertSkdCount === 1) { 
                       $('#insertModal').modal('hide');
                       var newEvent = {
                           id: resData.skdNo, 
                           title: $('#title').val(), 
                           start: $('#start').val(),
                           end: $('#end').val(),
                           backgroundColor: $('#color').val(),
                           extendedProps: {
                               category: $('#category').val(), 
                               contents: $('#contents').val(), 
                               writer: '${loginEmployee.empName}', 
                               empNo: '${loginEmployee.empNo}',
                               sharedItems: selectedItems.map(function(item) {
                                   return {
                                       value: item,
                                       type: item.startsWith('E') ? '사원' : '부서'
                                   };
                               })
                           }
                       };
                       calendar.addEvent(newEvent);  //fullcalendar에 일정 추가
                       $('#frm-schedule')[0].reset(); 
                       $('#empDept-result').empty(); 
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
   };

   const fnModifySkd = () => {
	    // 상세 일정 모달창에서 수정 버튼 클릭
	    $('#btn-edit').on('click', function() {
	        var selectedSkdNo = $('#skdNo').val();   // 현재 선택된 일정 ID 가져오기
	       
	        // 선택된 일정 상세 데이터 가져오기
	        $.ajax({
	            type: 'GET',
	            url: '${contextPath}/schedule/detail.do',
	            data: { skdNo: selectedSkdNo },
	            success: function(schedule) {
	                // 선택한 일정 데이터 수정 모달창에 입력
	                $('#modify-skdNo').val(schedule.skdNo);
	                $('#modify-title').val(schedule.skdTitle);
	                $('#modify-start').val(schedule.skdStart);
	                $('#modify-end').val(schedule.skdEnd);
	                $('#modify-category').val(schedule.skdCategory);
	                $('#modify-color').val(schedule.skdColor);
	                $('#modify-contents').val(schedule.skdContents);

	                // scheduleDto 에 저장된 공유 항목
	                var sharedItems = schedule.sharedItems;

	                $('#modify-empDept-result').empty(); // 공유 항목 초기화
	                sharedItems.forEach(function(item) { // 저장된 공유 항목 배열을 forEach 로 꺼내기
	                    var label, value;                // label : 사원명 or 부서명, value : 사원번호 or 부서번호
	                    if (item.includes('사원')) {     // '사원' 포함
	                        label = item.substring(0, item.indexOf('E')); // '사원' 이전 label 로 설정
	                        value = item.substring(item.indexOf('E'));    // 'E'   이후 value 로 설정
	                    } else if (item.includes('부서')) { // '부서' 포함
	                        label = item.substring(0, item.indexOf('D'));
	                        value = item.substring(item.indexOf('D'));
	                    }
	                    // 선택된 공유 항목을 버튼으로 표시
	                    $('#modify-empDept-result').append(
	                        '<button class="selectItem btn btn-primary btn-sm m-1">' + label + // label 을 버튼 텍스트로 설정
	                        '<input type="hidden" name="shrNo" value="' + value + '">' +       // value 는 hidden 값으로 설정
	                        '</button>'
	                    );
	                });

	              // 자동완성 초기화
                if ($('#modify-shrEmpDept').data('ui-autocomplete')) { // 초기화 상태일 경우 (ui-autocomplete :  Autocomplete의 데이터 키, 자동완성 위젯의 초기화 상태 확인 가능)
                    $('#modify-shrEmpDept').autocomplete('destroy');   // 자동완성 초기화 (destroy :  jQuery UI Autocomplete 위젯 제거하는 메소드)
                }
	              
	              // 새로운 자동완성을 생성하기 위해 함수 호출 (사원, 부서 검색 기능)
                fnEmpDeptList('modify-shrEmpDept', 'modify-empDept-result');
                
                // 상세보기 모달 숨기고 수정 모달 오픈
                $('#detailModal').modal('hide');
                $('#modifyModal').modal('show');
                
	            },
	            error: function(jqXHR) {
	                alert(jqXHR.statusText + '(' + jqXHR.status + ')');
	            }
	        });
	    });
	    
	    // 일정 수정 폼
	    $('#frm-modify-schedule').on('submit', function(e) {
	        e.preventDefault();

	        // 입력된 데이터 객체로 저장
	        var formData = {
	            skdNo: parseInt($('#modify-skdNo').val()), // 일정 번호
	            skdTitle: $('#modify-title').val(), // 일정 제목
	            skdStart: $('#modify-start').val(), // 시작 시간
	            skdEnd: $('#modify-end').val(),     // 종료 시간
	            skdCategory: $('#modify-category').val(), // 카테고리
	            skdColor: $('#modify-color').val(),       // 일정 색상
	            skdContents: $('#modify-contents').val(), // 내용
	            sharedItems: [] // 공유 항목 (사원 및 부서)
	        };
	        
	        // 기존 공유 항목을 추가
	        $('#modify-empDept-result input[name="shrNo"]').each(function() {
	            formData.sharedItems.push($(this).val());
	        });
	        // 서버로 수정된 일정 데이터 전송
	        $.ajax({
	            type: 'POST',
	            url: '${contextPath}/schedule/modify.do',
	            contentType: 'application/json',
	            data: JSON.stringify(formData),
	            dataType: 'json',
	            success: function(resData) {
	                if (resData.modifyCount === 1) {  // 일정 수정 성공
	                    $('#modifyModal').modal('hide'); // 모달 닫기

	                    // 수정된 일정 fullCalendar 에 업데이트
	                    var event = calendar.getEventById(formData.skdNo);
	                    event.setProp('title', formData.skdTitle);
	                    event.setStart(formData.skdStart);
	                    event.setEnd(formData.skdEnd);
	                    event.setProp('backgroundColor', formData.skdColor);
	                    event.setExtendedProp('category', formData.skdCategory);
	                    event.setExtendedProp('contents', formData.skdContents);
	                    event.setExtendedProp('sharedItems', formData.sharedItems);

	                    calendar.render();
	                    $('#frm-modify-schedule')[0].reset(); // 폼 초기화
	                    $('#modify-empDept-result').empty();  // 선택된 항목 초기화
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


   const fnRemoveSkd = () => {
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

 fnGetSkdList();
 //모달이 열릴 때마다 자동완성 함수 호출
 $('#insertModal').on('shown.bs.modal', function() {fnEmpDeptList('shrEmpDept', 'empDept-result');}); // 일정 등록
 $('#modifyModal').on('shown.bs.modal', function() {fnEmpDeptList('modify-shrEmpDept', 'modify-empDept-result');}); // 일정 수정
 fnRegisterSkd();
 fnModifySkd();
 fnRemoveSkd();
 
</script>
    

<!-- <script src="../assets/js/pages-calendar.js"></script> -->
<%@ include file="../layout/footer.jsp" %>    