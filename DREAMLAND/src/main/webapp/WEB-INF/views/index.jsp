<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="./layout/header.jsp" />  

<!-- Content wrapper -->
<div class="content-wrapper">
 <!-- Content -->
	<div class="container-xxl flex-grow-1 container-p-y">
	  <div class="row">
	    <div class="col-lg-6">
		    <div class="row">
			    <div class="col-6 mb-4">
					  <h2 class="py-3 mb-4">
						  안녕하세요. <span class="user-name"> OOO</span>님
						</h2>	    
			    </div>
			    <div class="col-6 mb-4 py-3">
			       <div class="button-wrapper text-end">
	            <button type="submit" class="btn btn-primary mb-4">
	              <span class="d-none d-sm-block">출근</span>
	            </button>
	            <button type="submit" class="btn btn-danger mb-4">
	              <span class="d-none d-sm-block">퇴근</span>
	            </button>
	          </div>
	        </div>		    
		    </div>
	    </div>
	  </div>
	  <div class="row">
	    <div class="col-12 col-lg-6">
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
	               <div class="col-md">
	                <div class="row">
	                  <div id="weather-icon-wrap" class="col-md-6">
	                    <img id="weather-icon">
	                  </div>
	                  <div id="current-temp" class="col-md-6 display-3"></div>
	               </div>  
	               </div>
	                <div>
	                  <div id="temp-min"></div>
	                  <div id="temp-max"></div>
	                  <div id="wind"></div>
	                  <div id="cloud"></div>
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
	    <div class="col-12 col-lg-6">
	      <h4 class="mb-4">
	       <span class="today"></span><span class="time"></span>
	      </h4> 
	        <div class="row">
	          <div class="col-md-8">
	            <div class="card">캘린더</div>
	          </div>
	          <div class="col-md-4">
	            <div class="main-news-wrap">
	              <div class="btn rounded-pill btn-outline-secondary mb-4 py-3">안읽은 쪽지<br/><strong class="msg-count">0</strong> 건입니다.</div>
	              <div class="btn rounded-pill btn-outline-success mb-4 py-3">대기 전자문서<br/><strong class="wait-count">0</strong> 건입니다.</div>
	              <div class="btn rounded-pill btn-outline-info py-3">진행 전자문서<br/><strong class="continue-count">0</strong> 건입니다.</div>
	            </div>
	          </div>
	        </div>
	    </div>
	  </div>
	  
	</div>
  <!-- / Content -->            
 
	<script>
	
	/* 날씨 API */
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
	   tempMin.textContent = '최저기온 : ' + resData.main.temp_min.toFixed(1) + 'º';
	   tempMax.textContent = '최고기온 : ' + resData.main.temp_max.toFixed(1) + 'º';
	   wind.textContent = resData.wind.speed + 'm/s';
	   cloud.textContent = resData.clouds.all + '%';
	  },
	  error: (jqXHR) => {
	   alert('날씨 API 연결 이상');
	  }
	 })
	};
	
	fnWeather();
	
	/* 현재 시간 및 날짜 */
	const today = document.querySelector('.today');
	const time = document.querySelector('.time');
	
	function getTime() {
		let now = new Date();
		let hours = now.getHours();
		let minutes = String(now.getMinutes()).padStart(2, "0");
		let seconds = String(now.getSeconds()).padStart(2, "0");
		let ampm = '';
		if(hours > 12) {
			hours -= 12;
			hours = String(hours).padStart(2, "0");
			ampm = 'PM';
		} else {
			ampm = 'AM';
		}
		time.innerText = ampm + hours + ':' + minutes + ':' + seconds;
	}
	
	getTime();
	setInterval(getTime, 1000);
	</script>


  
<%@ include file="./layout/footer.jsp" %>
