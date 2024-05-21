<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../layout/header.jsp" />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.11/index.global.min.js'></script>  

    <div id='calendar'></div>
    <dialog>
      <div>제목 테스트</div>
        <button>닫기</button>
    </dialog>
    
    <script>
    
      // 전역변수
      var calendar;

      // DOMContent 가 로드되면 실행되는 함수
      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        let popup = document.querySelector('dialog');

        calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
          headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
          },
          editable: true,
          googleCalendarApiKey: '',
          events: {
            googleCalendarId: ''
          },
          eventClick: function(info) {
            info.jsEvent.preventDefault(); // don't let the browser navigate
            // alert('Event: ' + info.event.title); 제목 테스트
            console.log(info.event.extendedProps.description);
            // 일정 제목, 상세내용 팝업 생성
            popup.querySelector('div').innerHTML = `
             <h3>${info.event.title}</h3>
             <div>${info.event.extendedProps.description}</div>
            `;
            popup.setAttribute('open','open');
          }, 
          dateClick : function (info) {
            console.log("Clicked event occurs : date = " + info.dateStr);
            addEventToCalendar({ start: info.dateStr });
          }
        });
        calendar.render();
        // 일정 팝업 닫기
        popup.querySelector('button').addEventListener('click', ()=>{
          popup.removeAttribute('open');
        })
      });

      function addEventToCalendar(evt) {
        calendar.addEvent(evt);
      }

    </script>


<%@ include file="../layout/footer.jsp" %>    