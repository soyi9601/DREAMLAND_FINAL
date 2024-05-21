<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
    
    <div id='calendar'></div>

    <!-- 일정 추가 모달 -->
    <div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">일정 추가</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="title" class="form-label">일정 제목</label>
                            <input type="text" class="form-control" id="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="start" class="form-label">시작일</label>
                            <input type="datetime-local" class="form-control" id="start" required>
                        </div>
                        <div class="mb-3">
                            <label for="end" class="form-label">종료일</label>
                            <input type="datetime-local" class="form-control" id="end" required>
                        </div>
                        <div class="mb-3">
                            <label for="category" class="form-label">카테고리</label>
                            <select id="category" class="form-select">
                                <option value="work">업무</option>
                                <option value="meeting">회의</option>
                                <option value="outing">외근</option>
                                <option value="business-trip">출장</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="color" class="form-label">색상 선택</label>
                            <select id="color" class="form-select" style="width: 100%;">
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
                            <textarea class="form-control" id="contents" style="width: 100%;" rows="3"></textarea> 
                        </div>
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
                var title = $('#title').val();
                var start = $('#start').val();
                var end = $('#end').val();
                var color = $('#color').val(); // 색상 값 가져오기

              if (!title) {
                      alert('일정 제목을 입력해주세요.');
                  } else if (start > end) {
                      alert('종료일은 시작일보다 뒤에 있어야 합니다.');
                  } else {
                      var eventData = {
                          title: title,
                          start: start,
                          end: end,
                          color: color,
                          category: category,
                          contents: contents
                      };
                      // 이벤트 추가
                      calendar.addEvent(eventData);
                      // 모달 닫기
                      $('#insertModal').modal('hide');
                      // 입력 필드 초기화
                      $('#title').val('');
                      $('#start').val('');
                      $('#end').val('');
                      $('#color').val('#FF0000');
                      $('#category').val('');
                      $('#contents').val('');
                  }
            });
        });
    </script>

<%@ include file="../layout/footer.jsp" %>    