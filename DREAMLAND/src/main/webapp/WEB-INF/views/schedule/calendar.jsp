<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<%-- <%session.setAttribute("empNo", 1);%>     --%>       
<%-- <%session.setAttribute("deptNo", 6000);%>   --%>        

<jsp:include page="../layout/header.jsp" />
<!-- FullCalendar CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.11/index.global.min.js'></script>  

<!-- moment.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>

<!-- Choices.js CDN : 멀티셀렉트, 태그입력, 검색가능한 드롭다운 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/choices.js/public/assets/styles/choices.min.css">
<script src="https://cdn.jsdelivr.net/npm/choices.js/public/assets/scripts/choices.min.js"></script>

<!-- Popper.js CDN : 툴팁 및 팝오버  -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>


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
    
    /* 공유부서 select */
    .col-md-6 {
        width: 100%; 
    }
    /* 공유부서 선택된 부서 */
    .choices__list--multiple .choices__item {
        background-color: #90b54c;
        border: #90b54c;
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
	                    <div class="row d-flex justify-content-center mt-100">
	                        <div class="col-md-6">
	                            <select id="deptNo" name="deptNo" multiple>
	                             <option value="1000">인사</option>
	                             <option value="2000">경영지원</option>
	                             <option value="3000">안전관리</option>
	                             <option value="5000">시설운영</option>
	                             <option value="6000">마케팅</option>
	                            </select>
	                        </div>
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
	          <%--           <input type="hidden" name="empNo" value="${sessionScope.employee.empNo}"> --%>
	                             <input type="hidden" name="empNo" value="1">
	              
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
	                   <div class="row d-flex justify-content-center mt-100">
	                        <div class="col-md-6">
	                            <select id="modify-deptNo" name="modify-deptNo" multiple>
	                                 <option value="1000">인사</option>
	                                 <option value="2000">경영지원</option>
	                                 <option value="3000">안전관리</option>
	                                 <option value="5000">시설운영</option>
	                                 <option value="6000">마케팅</option>
	                            </select>
	                        </div>
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
	                    <button type="button" class="btn btn-primary" id="btn-modify-skd">저장</button>
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
 
 document.addEventListener('DOMContentLoaded', function() {
	    // 전체 일정 데이터
	    var eventArray = [];
	    <c:forEach var='skd' items='${skdList}'>
	        eventArray.push({
	            id: '${skd.skdNo}',  // 일정 ID 추가
	            title: '${skd.skdTitle}',
	            start: '${skd.skdStart}',
	            end: '${skd.skdEnd}',
	            backgroundColor: '${skd.skdColor}',
	            extendedProps: {
	                contents: '${skd.skdContents}',
	                category: '${skd.skdCategory}',
	                empName: '${skd.employee.empName}',
	                sharedDepts: '<c:forEach var="dept" items="${skd.shrDept}">${dept.deptNo} </c:forEach>'
	            }
	        });
	    </c:forEach>
	    
	    // 전체 일정 데이터 확인용 (개발완료 후 삭제!!)
	    
	    console.log("전체일정 :" , eventArray);
	    
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
	              $('#skdNo').val('');  
	              $('#title').val('');
	              $('#start').val(info.dateStr + "T09:00");
	              $('#end').val(info.dateStr + "T18:00");
	              $('#category').val('work'); 
	              $('#color').val('gray'); 
	              $('#contents').val('');
	              $('#deptNo').val('');
	              $('#insertModal').modal('show'); 
	          },
	          eventClick: function(info) {
	              var sharedDeptTexts = info.event.extendedProps.sharedDepts.split(' ').map(function(deptNo) {
	                  return $("#modify-deptNo option[value='" + deptNo.trim() + "']").text();
	              }).join(', ');

	              var categoryText = $("#modify-category option[value='" + info.event.extendedProps.category + "']").text();
	              $('#detail-title').text(info.event.title);
	              $('#detail-time').text(moment(info.event.start).format('YYYY-MM-DD HH:mm') + ' ~ ' + moment(info.event.end).format('YYYY-MM-DD HH:mm'));
	              $('#detail-category').text(categoryText);
	              $('#detail-deptNo').text(sharedDeptTexts);
	              $('#detail-contents').text(info.event.extendedProps.contents);
	              $('#skdNo').val(info.event.id);
	              $('#detailModal').modal('show');
	          }
	      });

	      calendar.render(); // 캘린더 랜더링
	      
	      var multipleCancelButton = new Choices('#deptNo', {
	           removeItemButton: true,
	           maxItemCount: 5,
	           searchResultLimit: 5,
	           renderChoiceLimit: 5,
	           placeholder: true,
	           placeholderValue: '일정을 공유할 부서를 선택하세요.'
	       });
	      
	      var multipleCancelButton = new Choices('#modify-deptNo', {
	           removeItemButton: true,
	           maxItemCount: 5,
	           searchResultLimit: 5,
	           renderChoiceLimit: 5,
	           placeholder: true,
	           placeholderValue: '일정을 공유할 부서를 선택하세요.'
	       });
	      
	    /**************** 일정 등록 ****************/
       $('#frm-schedule').on('submit', function(e) {
			    e.preventDefault();
			    
			    // formData 생성 및 부서공유 선택 추가
			    var formData = $(this).serializeArray();
		        var selectedDepts = $('#deptNo').val();
		        if (selectedDepts) {
		            selectedDepts.forEach(function(dept) {
		                formData.push({name: 'deptNo', value: dept});
		            });
		        }
			
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
			                    color: $('#color').val(),
			                    extendedProps: {
			                        category: $('#category option:selected').text(),
			                        sharedDepts: selectedDepts.join(' '),
			                        contents: $('#contents').val()
			                    }
			                };
			                calendar.addEvent(newEvent);
			                // 입력 필드 초기화
			                $('#title').val('');
			                $('#start').val('');
			                $('#end').val('');
			                $('#category').val('work'); 
			                $('#deptNo').val(''); 
			                $('#color').val('gray'); 
			                $('#contents').val('');
			            } else {
			                alert('일정 등록 실패했습니다.');
			                // 입력 필드 초기화
			                $('#title').val('');
			                $('#start').val('');
			                $('#end').val('');
			                $('#category').val('work'); 
			                $('#deptNo').val('');
			                $('#color').val('gray'); 
			                $('#contents').val('');
			            }
			        },
			        error: function(jqXHR) {
			            alert(jqXHR.statusText + '(' + jqXHR.status + ')');
			        }
			    });
			});
	      
        /**************** 일정 수정 ****************/
        $('#btn-edit').on('click', function() {
            var selectedSkdNo = $('#skdNo').val();
            var event = calendar.getEventById(selectedSkdNo);
            
            $('#modify-skdNo').val(selectedSkdNo);
            $('#modify-title').val(event.title);
            $('#modify-start').val(moment(event.start).format('YYYY-MM-DDTHH:mm'));
            $('#modify-end').val(moment(event.end).format('YYYY-MM-DDTHH:mm'));
            $('#modify-deptNo').val(event.extendedProps.sharedDepts.split(' ')).trigger('change');
            $('#modify-color').val(event.backgroundColor); 
            $('#modify-contents').val(event.extendedProps.contents);
            
            $('#detailModal').modal('hide');
            $('#modifyModal').modal('show');
        });

              
           $('#btn-modify-skd').on('click', function() {
        	   // formData 생성 및 부서공유 선택 추가
               var formData = $(this).serializeArray();
                 var selectedDepts = $('#modify-deptNo').val();
                 if (selectedDepts) {
                     var shrDeptList = [];
                     selectedDepts.forEach(function(dept) {
                         shrDeptList.push({ skdNo: $('#modify-skdNo').val(), deptNo: dept });  // {skdNo, deptNo} 객채생성 -> 배열에 저장
                         console.log('공유부서 수정 : ', shrDeptList);
                     });
                     formData.push({ name: 'shrDept', value: JSON.stringify(shrDeptList) }); // formData에 shrDept 필드 추가
                 }
        	   
            var formData = {
                skdNo: parseInt($('#modify-skdNo').val()),
                skdTitle: $('#modify-title').val(),
                skdStart: $('#modify-start').val(),
                skdEnd: $('#modify-end').val(),
                skdCategory: $('#modify-category').val(),
                skdColor: $('#modify-color').val(),
                skdContents: $('#modify-contents').val(),
                shrDept: shrDeptList
            };

            
            $.ajax({
                type: "POST",
                url: "${contextPath}/schedule/modify.do",
                contentType: "application/json", // JSON 형식으로 전송
                data: JSON.stringify(formData), // 데이터를 JSON 문자열로 변환
                dataType: "json",
                success: function(resData) {
                    if (resData.modifyCount === 1) {
                        // 모달 닫기
                        $('#modifyModal').modal('hide');

                        // 업데이트된 이벤트 정보 설정
                        var event = calendar.getEventById(formData.skdNo);
                        event.setProp('title', formData.skdTitle);
                        event.setStart(formData.skdStart);
                        event.setEnd(formData.skdEnd);
                        event.setProp('color', formData.skdColor);
                        event.setExtendedProp('category', formData.skdCategory);
                        event.setExtendedProp('sharedDepts', formData.shrDept.map(dept => dept.deptNo).join(' '));
                        event.setExtendedProp('contents', formData.skdContents);
                        console.log('수정 데이터 : ' , event);
                    } else {
                        alert('일정 수정 실패했습니다.');
                    }
                },
                error: function(jqXHR) {
                    alert(jqXHR.statusText + '(' + jqXHR.status + ')');
                }
            });
        });
	   
	    	   $('#btn-remove').on('click', function() {
	    	    if(confirm('일정 삭제할까요?')){
	    	    	  const skdNo = $('#skdNo').val();
	    	        location.href = '${contextPath}/schedule/remove.do?skdNo=' + skdNo;
	    	    }
	    	  });
	    });
</script>

<%@ include file="../layout/footer.jsp" %>    