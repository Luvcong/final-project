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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.0/main.min.css" integrity="sha512-RlGItx9qaGz5r3Cx5rJxnjwG7Hn5xYeZgg7UuTY6U8Vn9pB6GdV6UuB6Urg2w+uCV6VQZ0d6YRakD5P/0j9/3g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.0/main.min.js" integrity="sha512-6LVuZgtGndnEYf7Gn8T+9XyjTqmlfwwanMnD8gJv+L3TR4di4KzYXDZt8v4zXGyEORJyRjWkF8bsSfC3/4M4jYg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- 풀캘린더 -->
	<script src='https://unpkg.com/popper.js/dist/umd/popper.min.js'></script>
	<script src='https://unpkg.com/tooltip.js/dist/umd/tooltip.min.js'></script>
	
	<!-- css-->
	<link rel="stylesheet" href="resources/css/calendar.css">
	<script>

		document.addEventListener('DOMContentLoaded', () => {
			
			
			$.ajax({
				url: 'schedule',
				data: { 
					empNo: ${loginUser.empNo},
					deptCode : '${loginUser.deptCode}'
				},
				success:list=>{
					//console.log(list.mySchedule);
					var mySchedule = list.mySchedule;
					var departmentSchedule = list.departmentSchedule;
					//console.log(mySchedule[0].schTitle);
					//console.log(mySchedule[3].schEnd);
					
					for(i=0; i<mySchedule.length; i++){
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
				url: 'meetingRoom',
				success:data=>{
					
				//console.log(data[0].meetTitle);
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
            	eventClick: (calEvent, jsEvent, view) => {
                    console.log(calEvent);
            		
                    $('#eventModalLabel').text(calEvent.event._def.title);
            	    $("#inputContent").val(calEvent.event._def.extendedProps.description);
            	    
            	    //var date = new Date();
            	    var selectStartDate = calEvent.el.fcSeg.eventRange.instance.range.start;
            	    
            	    var startDate = selectStartDate.getFullYear()+'-'
            	    		 		+((selectStartDate.getMonth()+1) < 10 ? "0" + (selectStartDate.getMonth()+1) : (selectStartDate.getMonth()+1))+'-'
            	    		 		+((selectStartDate.getDate()) < 10 ? "0" + (selectStartDate.getDate()) : (selectStartDate.getDate()));
            	    
            	    if((selectStartDate.getHours()-9)<0){
            	    	var startTime = (((selectStartDate.getHours()-9)+24) < 10 ? "0" + ((selectStartDate.getHours()-9)+24) : ((selectStartDate.getHours()-9)+24)) +':'
	    								+((selectStartDate.getMinutes()) < 9 ? "0" + (selectStartDate.getMinutes()) : (selectStartDate.getMinutes()));
            	    }
            	    else{
            	    	 var startTime = (((selectStartDate.getHours()-9)) < 10 ? "0" + ((selectStartDate.getHours()-9)) : ((selectStartDate.getHours()-9))) +':'
 	    								+((selectStartDate.getMinutes()) < 9 ? "0" + (selectStartDate.getMinutes()) : (selectStartDate.getMinutes()));
            	    }
            	    
            	    var selectEndDate = calEvent.el.fcSeg.eventRange.instance.range.end;
            	    //console.log(selectEndDate);
            	    
            	    var endDate = selectEndDate.getFullYear()+'-'
				    		 		+((selectEndDate.getMonth()+1) < 10 ? "0" + (selectEndDate.getMonth()+1) : (selectEndDate.getMonth()+1))+'-'
				    		 		+((selectEndDate.getDate()) < 10 ? "0" + (selectEndDate.getDate()) : (selectEndDate.getDate()));
    
            	    if((selectEndDate.getHours()-9)<0){
            	    	var endTime = (((selectEndDate.getHours()-9)+24) < 10 ? "0" + ((selectEndDate.getHours()-9)+24) : ((selectEndDate.getHours()-9)+24)) +':'
	    								+((selectEndDate.getMinutes()) < 10 ? "0" + (selectEndDate.getMinutes()) : (selectEndDate.getMinutes()));
            	    }
            	    else{
            	    	var endTime = (((selectEndDate.getHours()-9)) < 10 ? "0" + ((selectEndDate.getHours()-9)) : ((selectEndDate.getHours()-9))) +':'
	    							 +((selectEndDate.getMinutes()) < 10 ? "0" + (selectEndDate.getMinutes()) : (selectEndDate.getMinutes()));
            	    }
            	    
            	    
            	    //console.log(calEvent.el.fcSeg.eventRange.instance.range.start);
            	    //console.log(startDate);
            	    //console.log(startTime);
            	    //console.log(calEvent.el.fcSeg.eventRange.instance.range.start);
            	    //console.log(endDate);
            	    //console.log(endTime);
            	    
            	    $("#inputDateStrart").val(startDate);
            	    $("#inputDateEnd").val(endDate);
            	    
            	    $("#inputTimeStrart").val(startTime);
            	    $("#inputTimeEnd").val(endTime);
            	    
            	    $('#eventModal').modal();
            	    
                },
            	
                // Tool Bar 목록 document : https://fullcalendar.io/docs/toolbar
                height: '750px',

                eventDidMount: function(info) {
                    var tooltip = new Tooltip(info.el, {
                      title: info.event.extendedProps.description,
                      minDate: '0',
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
                dayMaxEvents: true,
                minDate: 0

			});
            calendar.render();
        });
		
		function saveEvent() {
			  // 이벤트 정보
			  var title = document.getElementById('inputCalendar').value;
			
			  // 모달 폼 숨기기
			  var eventModal = new bootstrap.Modal(document.getElementById('eventModal'));
			  eventModal.hide();
			  
			
			}
	</script>
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">

		<div id='calendar' class="calendarWidthMain calendarCenter"></div>
		
		<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
        <div class="modal-dialog">
        
            <div class="modal-content calendar-modal-width" style="width:600px;">
            	
                <div class="modal-header">
                    <h5 class="modal-title" id="eventModalLabel">일정제목</h5>
                    <button type="button" class="close" data-bs-dismiss="modal">
                    	<a href="calendar" class="calendar-a-color">&times;</a>
                    </button>
                </div>
                
                <div class="modal-body">
                
                    <div class="mb-3">
                    	<br>
                    	<label for="inputCalendar" class="form-label">기간</label><br>
                        <input type="date" class="inputform" id="inputDateStrart" value=""> 
                        <input type="time" class="inputform" id="inputTimeStrart" value=""> 
                         ~ 
                        <input type="date" class="inputform" id="inputDateEnd" value="">
                        <input type="time" class="inputform" id="inputTimeEnd" value=""><br>
                        <br>
                        
                        <label for="inputCalendar" class="form-label">일정내용</label>
                        <textarea class="form-control textarea-resize" rows="5" id="inputContent"></textarea>
                        <br>
                    </div>
                    
                    <div class="modal-border">
                    <label for="inputCalendar" class="form-label">&nbsp;&nbsp;작성자:&nbsp;</label>
			        <span>이승철</span>&nbsp;&nbsp;&nbsp;/
			        <label for="inputCalendar" class="form-label">&nbsp;&nbsp;수정일:&nbsp;</label>
			        <span>2023-11-22</span>&nbsp;&nbsp;&nbsp;
			        </div>
                </div>
                
                <div class="modal-footer">
                    <a type="button" class="btn btn-secondary" onclick="updateEvent();">수정하기</a>
                    <a type="button" class="btn btn-danger" onclick="deleteEvent();">삭제하기</a>
                    
                    <form action="" method="post" id="modalClickForm">
	            		<input type="hidden" name="schNo" value="">
	            		<input type="hidden" name="empNo" value="${loginUser.empNo}">
	            	</form>
                    
                    <script>
                    	function updateEvent(){
                    		$('#modalClickForm').attr('action', 'deleteSchedule').submit();
                    	}
                    	
                    	function deleteEvent(){
                    		$('#modalClickForm').attr('action', 'updateSchedule').submit();
                    	}
                    </script>
                    
                    
                </div>
                
            </div>
            
        </div>
    </div>
    
    </div>
    
    
</body>
</html>