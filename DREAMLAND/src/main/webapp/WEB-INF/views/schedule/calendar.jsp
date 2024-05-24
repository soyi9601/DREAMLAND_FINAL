<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<%session.setAttribute("empNo", 1);%>           
<%session.setAttribute("deptNo", 6000);%>           

<jsp:include page="../layout/header.jsp" />
<!-- FullCalendar CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.11/index.global.min.js'></script>  

<!-- moment.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>


<style>
    body {
        margin: 40px 10px;
        padding: 0;
        font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
        font-size: 14px;
    }
    #calendar {
        max-width: 1100px;
        margin: 0 auto;
    }
</style>
<body>
    
    <div class="container mt-5">
        <div id='calendar'></div>
    </div>

     <!-- 일정 추가 모달 -->
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
                            <label for="title" class="form-label">일정 제목</label>
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
                            <label for="color" class="form-label">색상 선택</label>
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
                        <!-- 세션 정보를 전달하는 숨겨진 필드 -->
                        <input type="hidden" name="empNo" value="${sessionScope.empNo}">
                        <input type="hidden" name="deptNo" value="${sessionScope.deptNo}">
                        <!-- <input type="hidden" name="deptNo" value="${sessionScope.user.deptNo}">  -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" class="btn btn-primary" id="btn-save">저장</button>
                </div>   
                </div>
            </div>
        </div>
    </div>
</form>

 <script>
        document.addEventListener('DOMContentLoaded', function() {
            
        	 // 전체 일정 데이터
            var eventArray = [];
            <c:forEach var="skd" items="${skdList}">
                eventArray.push({
                    title: "${skd.skdTitle}",
                    start: "${skd.skdStart}",
                    end: "${skd.skdEnd}",
                    color: "${skd.skdColor}"
                });
            </c:forEach>
            
            // 전체 일정 데이터 확인용 (개발완료 후 삭제!!)
            console.log(eventArray);
            
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                dayMaxEvents: true, // 일정 오버되면 높이 제한
                events: eventArray, // 일정 캘린더에 표시
                dateClick: function(info) {
                    $('#start').val(info.dateStr + "T09:00"); // 클릭한 날짜를 모달의 시작일과 종료일로 설정
                    $('#end').val(info.dateStr + "T18:00");
                    $('#insertModal').modal('show'); // 모달창 표시
                }
            });

            calendar.render(); // 캘린더 렌더링

            /**************** 일정 등록 ****************/
            $('#frm-schedule').on('submit', function(e) {
                e.preventDefault();
                var formData = $(this).serialize();

                $.ajax({
                    type: "POST",
                    url: "${contextPath}/schedule/register.do",
                    data: formData,
                    dataType: "json",
                    success: function(resData) {
                        if (resData.insertSkdCount === 1) {
                        	// 모달 닫기
                            $('#insertModal').modal('hide');
                            // 새로운 이벤트 추가
                            var newEvent = {
                                title: $('#title').val(),
                                start: $('#start').val(),
                                end: $('#end').val(),
                                color: $('#color').val()
                            };
                            calendar.addEvent(newEvent);
                            // 입력 필드 초기화
                            $('#title').val('');
                            $('#start').val('');
                            $('#end').val('');
                            $('#category').val('work'); 
                            $('#color').val('gray'); 
                            $('#contents').val('');
                        } else {
                            alert('일정 등록 실패했습니다.');
                            // 입력 필드 초기화
                            $('#title').val('');
                            $('#start').val('');
                            $('#end').val('');
                            $('#category').val('work'); 
                            $('#color').val('gray'); 
                            $('#contents').val('');
                        }
                    },
                    error: function(jqXHR) {
                        alert(jqXHR.statusText + '(' + jqXHR.status + ')');
                    }
                });
            });
        });
    </script>

<%@ include file="../layout/footer.jsp" %>    