/**
 * 작성자 : 이소이
 * 기능   : 로그인 정보, 출퇴근 체크, 날씨 API, 캘린더 조회
 * 이력   :
 *    1) 240527
 *        - 로그인 정보, 날씨 API
 *    2) 240603
 *        - 캘린더 조회, 출퇴근 체크
 */
 
 
/* *********** 날씨 API *********** */
const weatherIconImg = document.getElementById('weather-icon');
const currentTemp = document.getElementById('current-temp');
const tempMin = document.getElementById('temp-min');
const tempMax = document.getElementById('temp-max');
const wind = document.getElementById('wind');
const cloud = document.getElementById('cloud');

var apiURI = 'https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=6bde3279e91a83b26c3903c8ab07c8b6&lang=kr&units=metric';
const fnWeather = () => {
  $.ajax({
    type: 'GET',
    url: apiURI,
    data: 'json',
    success: (resData) => {
      console.log(resData);
      const weatherIcon = resData.weather[0].icon;
      const weatherIconAdrs = 'http://openweathermap.org/img/wn/' + weatherIcon + '@2x.png';  // 날씨 icon 링크 연결
      weatherIconImg.setAttribute('src', weatherIconAdrs);  // 날씨 icon <img> 태그 src 변경
      currentTemp.textContent = resData.main.temp.toFixed(1) + 'º'; // toFixed(1) : 소수점1개까지 표시
      tempMin.textContent = resData.main.temp_min.toFixed(1) + 'º';
      tempMax.textContent = resData.main.temp_max.toFixed(1) + 'º';
      wind.textContent = resData.wind.speed + 'm/s';
      cloud.textContent = resData.clouds.all + '%';
    },
    error: (jqXHR) => {
      alert('날씨 API 연결 이상');
    }
  })
};


/* *********** 현재 시간 및 날짜 *********** */
const today = document.querySelector('.today');
const time = document.querySelector('.time');
const dayName = document.querySelector('.day-name');

function fnGetDate() {
  const todayDate = new Date();
  const days = ['일', '월', '화', '수', '목', '금', '토'];
  const days_num = todayDate.getDay();
  const year = todayDate.getFullYear();
  const month = String(todayDate.getMonth() + 1).padStart(2, "0");  // month는 0부터 시작하기 때문에 +1 해줘야함. padStart 는 두자리수로 표현할 때 앞에 0으로 나타낼 수 있음.
  const date = String(todayDate.getDate()).padStart(2, "0");
  const day = days[days_num];
  today.innerText = year + '. ' + month + '. ' + date;
  dayName.innerText =  day + '요일';
}

function fnGetTime() {
  let now = new Date();
  let hours = now.getHours();
  hours = String(hours).padStart(2, "0");
  let minutes = String(now.getMinutes()).padStart(2, "0");
  let seconds = String(now.getSeconds()).padStart(2, "0");
  let ampm = '';
  if(hours > 12) {    // 13시부터는 12시를 빼주고 앞에 0 붙여주기
    hours -= 12;    
    ampm = 'PM';
  } else {
    ampm = 'AM';
  }
  time.innerText = ampm + hours + ' : ' + minutes + ' : ' + seconds;
}


/* *********** 캘린더 *********** */
function fnCalendar() {
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('cal');
    var indexCalendar = new FullCalendar.Calendar(calendarEl, {
      height: 500,
      initialView: 'dayGridMonth',
      locale: 'ko', // 한국어 설정
      headerToolbar: {
        left: 'prev,next',
        center: 'title',
        right: 'today'
      },
      events: {display: 'background',
      id: 'a',
      title: 'my event',
      start: '2024-06-02'},
      customButtons: {          
        customToday: { // 오늘 날짜로 이동
          text: '오늘',
          click: function() {
            indexCalendar.today();
          }
        },          
      }          
    });
    indexCalendar.render();
  });
}


/* *********** 출퇴근 *********** */
/* *********** 출근 *********** */
const empNo = document.getElementById('empNo').value;
const fnWorkIn = () => {
  document.getElementById('btn-work-in').addEventListener('click', function() {
    fetch('/workIn?empNo=' + empNo, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({}) 
    })
    .then(response => response.json())
    .then(data => {
      alert(data.message);      
      this.disabled = true;
    });
  })  
}

/* *********** 퇴근 *********** */
const fnWorkOut = () => {
  document.getElementById('btn-work-out').addEventListener('click', function() {
    fetch('/workOut?empNo=' + empNo, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({}) 
    })
    .then(response => response.json())
    .then(data => {alert(data.message);});
  })  
}


/* ********************** 함수 호출 ********************** */
fnWeather();
fnGetDate();
fnGetTime(); 
setInterval(fnGetTime, 1000); 
fnCalendar(); 
fnWorkIn();
fnWorkOut();
/* ********************** ********* ********************** */


