<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home>캘린더</title>

	<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- 풀캘린더 -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/index.global.min.js'></script>
    
    <!-- 풀캘린더 모달 -->
    <!-- FullCalendar dependencies -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.0/main.min.css" integrity="sha512-RlGItx9qaGz5r3Cx5rJxnjwG7Hn5xYeZgg7UuTY6U8Vn9pB6GdV6UuB6Urg2w+uCV6VQZ0d6YRakD5P/0j9/3g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.0/main.min.js" integrity="sha512-6LVuZgtGndnEYf7Gn8T+9XyjTqmlfwwanMnD8gJv+L3TR4di4KzYXDZt8v4zXGyEORJyRjWkF8bsSfC3/4M4jYg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- css-->
	<link rel="stylesheet" href="resources/css/calendar.css">

	<script src='https://unpkg.com/popper.js/dist/umd/popper.min.js'></script>
	<script src='https://unpkg.com/tooltip.js/dist/umd/tooltip.min.js'></script>
	<script>

		document.addEventListener('DOMContentLoaded', () => {

			$.ajax({
				url: 'schedule',
				success:list=>{
					//console.log(list.mySchedule);
					var mySchedule = list.mySchedule;
					var departmentSchedule = list.departmentSchedule;
					//console.log(mySchedule[0].schTitle);
					
					for(i=0;  i<mySchedule.length; i++){
						calendar.addEvent({
							title: mySchedule[i].schTitle,
							description: mySchedule[i].schContent,
							start: mySchedule[i].schStart,
							end: mySchedule[i].schEnd,
							color : "#f1c232"
				        });
					}
					
					for(i=0;  i<departmentSchedule.length; i++){
						calendar.addEvent({
							title: departmentSchedule[i].schTitle,
							description: departmentSchedule[i].schContent,
							start: departmentSchedule[i].schStart,
							end: departmentSchedule[i].schEnd,
							color : "#8e7cc3"
				        });
					}
					
				},
				error:()=>{
					console.log('실패');
				}
        	})
        	
        	$.ajax({
					url: 'calendarMini',
					success:data=>{
						
					console.log(data[0].meetTitle);
					for(i=0;  i<data.length; i++){
						calendar.addEvent({
							title: data[i].meetTitle,
							description: data[i].meetContent,
							start: data[i].meetStart,
							end: data[i].meetEnd,
							color : "#8ecae6"
				        });
					}
					},
					error:()=>{
						console.log('실패');
					}
        	})
        	
			var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
            	/*
            	eventClick: function(info){
            		alertify.alert(info.event.title, '기간: '+info.event.start+'<br>'+'내용: '+info.event.extendedProps.description);
            	},
            	*/
            	eventClick: function (calEvent, jsEvent, view) {
                    /*
            		event = calEvent;
                    $('#inputTitle').val(event.title);
                    $('#eventModalLabel').text('세부일정');
                    $('#eventModal').modal();
                    */
                    $('#eventModalLabel').text('세부일정');
            	    $("#inputTitle").val(calEvent.title);
            	    $("#inputContent").val(calEvent.description);
            	    $('#eventModal').modal();
                },
            	
                // Tool Bar 목록 document : https://fullcalendar.io/docs/toolbar
                height: '750px',

                eventDidMount: function(info) {
                    var tooltip = new Tooltip(info.el, {
                      title: info.event.extendedProps.description,
                      placement: 'top',
                      trigger: 'hover',
                      container: 'body'
                    });
                },
                
                headerToolbar: {
                    left: 'dayGridMonth,dayGridWeek,dayGridDay',
                    center: 'title',
                    right: 'today prevYear,prev,next,nextYear'
                },

                selectable: true,
                selectMirror: true,
                navLinks: true,
                editable: false,
                initialView: 'dayGridMonth',
                dayMaxEvents: true
                
			});
            calendar.render();
        });
		
		function saveEvent() {
			  // 이벤트 정보를 입력란에서 가져오세요.
			  var title = document.getElementById('inputTitle').value;
			
			  // 모달 폼을 숨기세요.
			  var eventModal = new bootstrap.Modal(document.getElementById('eventModal'));
			  eventModal.hide();
			}
	</script>
</html>
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">

		<div id='calendar' class="calendarWidthMain calendarCenter">
		</div>
		<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="eventModalLabel">New Event</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- 여기에 이벤트 정보 입력란을 추가하세요. 예: -->
                    <div class="mb-3">
                        <label for="inputTitle" class="form-label">일정제목</label>
                        <input type="text" class="form-control" id="inputTitle">
                        <br>
                        <label for="inputTitle" class="form-label">일정내용</label>
                        <input type="text" class="form-control" id="inputContent">
                        <br>
                        <label for="inputTitle" class="form-label">기간</label>
                        <input type="date" class="form-control" id="inputDate">~<input type="date" class="form-control" id="inputDate">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-secondary">수정하기</button>
                    <button type="button" class="btn btn-danger" onclick="deleteEvent();">삭제하기</button>
                </div>
            </div>
        </div>
    </div>
    </div>
    
</body>
</html>