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
    <div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">일정 추가</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="frm-schedule">
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
                                <option value="work">업무</option>
                                <option value="meeting">회의</option>
                                <option value="outing">외근</option>
                                <option value="business-trip">출장</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="color" class="form-label">색상 선택</label>
                            <select id="color" name="color" class="form-select" style="width: 100%;">
                              <option value="gray" style="color:#808080;">기본색상</option>
                              <option value="red" style="color:#FF0000;">빨간색</option>
                              <option value="orange" style="color:#FFA500;">주황색</option>
                              <option value="yellow" style="color:#FFFF00;">노란색</option>
                              <option value="green" style="color:#008000;">초록색</option>
                              <option value="blue" style="color:#0000FF;">파란색</option>
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
                        <!-- <input type="hidden" name="deptNo" value="${sessionScope.user.deptNo}">  -->
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" id="btn-save">저장</button>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                dayMaxEvents: true,           // 이벤트 오버되면 높이 제한
                dateClick: function(info) {
                    // 클릭한 날짜를 모달의 시작일과 종료일로 설정
                    $('#start').val(info.dateStr + "T09:00");
                    $('#end').val(info.dateStr + "T18:00");
                    // 모달 표시
                    $('#insertModal').modal('show');
                },
                events: [] // 이벤트 데이터
            });
            calendar.render();

            $('#btn-save').on('click', function() {
                var formData = $('#frm-schedule').serialize(); // 폼 데이터 직렬화

                $.ajax({
                    type: 'POST',
                    url: '${contextPath}/schedule/register.do',
                    data: formData,
                    success: function(response) {
                        if (response === 'success') {
                            var title = $('#title').val();
                            var start = $('#start').val();
                            var end = $('#end').val();
                            var color = $('#color').val();

                            calendar.addEvent({
                                title: title,
                                start: start,
                                end: end,
                                color: color
                            });

                            $('#insertModal').modal('hide');
                            $('#frm-schedule')[0].reset(); // 폼 초기화
                        } else {
                            alert('일정 등록에 실패했습니다.');
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('일정 등록에 실패했습니다.');
                    }
                });
            });
        });
    </script>

<%@ include file="../layout/footer.jsp" %>    