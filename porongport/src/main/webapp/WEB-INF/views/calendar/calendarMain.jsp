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
	<link rel="stylesheet" href="resources/css/myCalendar.css">
	
	<script>

		// 풀캘린더 참고: https://ksyy.tistory.com/113
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
							id: mySchedule[i].schNo,
							title: mySchedule[i].schTitle,
							description: mySchedule[i].schContent,
							start: mySchedule[i].schStart,
							end: mySchedule[i].schEnd,
							color : "#f1c232",
							groupId:"M",
							regid: mySchedule[i].empName,
							source: mySchedule[i].correctionDate
				        });
					}
					
					for(i=0;  i<departmentSchedule.length; i++){
						calendar.addEvent({
							id: departmentSchedule[i].schNo,
							title: departmentSchedule[i].schTitle,
							description: departmentSchedule[i].schContent,
							start: departmentSchedule[i].schStart,
							end: departmentSchedule[i].schEnd,
							color : "#8e7cc3",
							groupId: "D",
							regid: departmentSchedule[i].empName,
							source: departmentSchedule[i].correctionDate
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
				for(i=0; i<data.length; i++){
					calendar.addEvent({
						title: data[i].meetTitle,
						description: data[i].meetContent,
						start: data[i].meetStart,
						end: data[i].meetEnd,
						color : "#8ecae6",
						regid: data[i].empName,
						source: data[i].correctionDate
			        });
				}
				},
				error:()=>{
					console.log('실패');
				}
    		})
        	
			var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
            	
            	/*select: info => {
            		var startDate = info.startStr;
            		var endDate = info.endStr;
            		$('#startDate').val(startDate);
            		$('#endDate').val(endDate);
            		
            		$("#endDate").attr("min", startDate);
             	    $("#endTime").attr("min", startTime);
            		
            		$('#insertEventModal').modal();
            		
            	},*/
            	
            	dateClick: info=>{
            		//var id = info.event._def.defId;
            		var startDate = info.dateStr;
            		var endDate = info.dateStr;
            		$('#startDate').val(startDate);
            		$('#endDate').val(endDate);
            		
            		$("#endDate").attr("min", startDate);
             	    $("#endTime").attr("min", startTime);
            		
            		$('#insertEventModal').modal();
            	},
            	
            	eventClick: (calEvent, jsEvent, view) => {
            		var allDay = calEvent.event._def.allDay;
            		
                    var schNo = parseInt(calEvent.event.id);
                   	$('#hiddenSchNo').attr("value", schNo);
                   	
                   	$('#updateEmp').text(calEvent.event.extendedProps.regid);
                   	$('#updateDate').text(calEvent.event._def.extendedProps.source);
                   	$('#hiddenSchShare').val(calEvent.event.groupId);
                    $('#eventModalLabel').text(calEvent.event.title);
                    $('#hiddenSchTitle').val(calEvent.event.title);
            	    $("#inputContent").val(calEvent.event._def.extendedProps.description);
            	    
            	    var selectStartDate = calEvent.el.fcSeg.eventRange.instance.range.start;
            	    var selectEndDate = calEvent.el.fcSeg.eventRange.instance.range.end;
            	    
            	    if((selectStartDate.getHours()-9)<0){
            	    	var startTime = (((selectStartDate.getHours()-9)+24) < 10 ? "0" + ((selectStartDate.getHours()-9)+24) : ((selectStartDate.getHours()-9)+24)) +':'
	    								+((selectStartDate.getMinutes()) < 9 ? "0" + (selectStartDate.getMinutes()) : (selectStartDate.getMinutes()));
            	    }
            	    else{
            	    	var startTime = (((selectStartDate.getHours()-9)) < 10 ? "0" + ((selectStartDate.getHours()-9)) : ((selectStartDate.getHours()-9))) +':'
										+((selectStartDate.getMinutes()) < 9 ? "0" + (selectStartDate.getMinutes()) : (selectStartDate.getMinutes()));
            	    }
            	    
            	    if((selectEndDate.getHours()-9)<0){
					    var endTime = (((selectEndDate.getHours()-9)+24) < 10 ? "0" + ((selectEndDate.getHours()-9)+24) : ((selectEndDate.getHours()-9)+24)) +':'
									  +((selectEndDate.getMinutes()) < 10 ? "0" + (selectEndDate.getMinutes()) : (selectEndDate.getMinutes()));
					}
            	    else{
						var endTime = (((selectEndDate.getHours()-9)) < 10 ? "0" + ((selectEndDate.getHours()-9)) : ((selectEndDate.getHours()-9))) +':'
			  						+((selectEndDate.getMinutes()) < 10 ? "0" + (selectEndDate.getMinutes()) : (selectEndDate.getMinutes()));
					}
            	    
            	    var startTimeCut = startTime.substr(0, 2);
            	    var endTimeCut = endTime.substr(0, 2);
					
            	   	if(endTimeCut<12){
            	   		var endDate = selectEndDate.getFullYear()+'-'
	    		 					+((selectEndDate.getMonth()+1) < 10 ? "0" + (selectEndDate.getMonth()+1) : (selectEndDate.getMonth()+1))+'-'
	    		 					+(selectEndDate.getDate() < 10 ? "0" + selectEndDate.getDate() : selectEndDate.getDate());
            	   	}
            	   	else{
            	   		var endDate = selectEndDate.getFullYear()+'-'
	    		 				+((selectEndDate.getMonth()+1) < 10 ? "0" + (selectEndDate.getMonth()+1) : (selectEndDate.getMonth()+1))+'-'
	    		 				+((selectEndDate.getDate()-1) < 10 ? "0" + (selectEndDate.getDate()-1) : (selectEndDate.getDate()-1));
	    
            	   	}
            	   	
            	   	if(14<startTimeCut){
            	   		var startDate = selectStartDate.getFullYear()+'-'
				    		 		+((selectStartDate.getMonth()+1) < 10 ? "0" + (selectStartDate.getMonth()+1) : (selectStartDate.getMonth()+1))+'-'
				    		 		+((selectStartDate.getDate()-1) < 10 ? "0" + (selectStartDate.getDate()-1) : (selectStartDate.getDate()-1));
            	   	}
            	   	else{
            	   		var startDate = selectStartDate.getFullYear()+'-'
	    		 				+((selectStartDate.getMonth()+1) < 10 ? "0" + (selectStartDate.getMonth()+1) : (selectStartDate.getMonth()+1))+'-'
	    		 				+((selectStartDate.getDate()) < 10 ? "0" + (selectStartDate.getDate()) : (selectStartDate.getDate()));
            	   	}

					if(allDay){
						var endDate = selectEndDate.getFullYear()+'-'
					 				+((selectEndDate.getMonth()+1) < 10 ? "0" + (selectEndDate.getMonth()+1) : (selectEndDate.getMonth()+1))+'-'
					 				+((selectEndDate.getDate()-1) < 10 ? "0" + (selectEndDate.getDate()-1) : (selectEndDate.getDate()-1));
					}
            	    
            	    $("#inputDateStrart").val(startDate);
            	    $("#inputDateEnd").val(endDate);
            	    
            	    $("#inputTimeStrart").val(startTime);
            	    $("#inputTimeEnd").val(endTime);
            	    
            	    $("#inputDateEnd").attr("min", startDate);
            	    $("#inputTimeEnd").attr("min", startTime);
            	    
            	    $('#eventModal').modal();
                },
            	
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
                
                customButtons: {
            		scheduleButton: { 
                        text: '회의실예약', 
                        click: event=>{ 
                        	location.href="/porong/reservation";
                        } 
            		}
            	},
            	
                headerToolbar: {
                    left: 'dayGridMonth,dayGridWeek,dayGridDay today',
                    center: 'title',
                    right: 'scheduleButton prevYear,prev,next,nextYear'
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
        
        	<form action="" method="post" id="modalClickForm">
            <div class="modal-content calendar-modal-width" style="width:600px;">
            	
                <div class="modal-header">
                    <h5 class="modal-title" id="eventModalLabel">일정제목</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						       <span aria-hidden="true">&times;</span>
					</button>
                </div>
                
                <div class="modal-body">
                
                    <div class="mb-3">
                    	<br>
                    	<label for="inputCalendar" class="form-label">기간</label><br>
                        <input type="date" class="inputform" id="inputDateStrart"  name="startDate" value=""> 
                        <input type="time" class="inputform" id="inputTimeStrart"  name="startTime" value=""> 
                         ~ 
                        <input type="date" class="inputform" id="inputDateEnd"  name="endDate" value="" min="">
                        <input type="time" class="inputform" id="inputTimeEnd"  name="endTime" value="" min=""><br>
                        <br>
                        
                        <label for="inputCalendar" class="form-label">일정내용</label>
                        <textarea class="form-control textarea-resize" rows="5" id="inputContent" name="schContent" value=""></textarea>
                        <br>
                    </div>
                    
                     <div class="modal-border">
	                    <label for="inputCalendar" class="form-label">&nbsp;&nbsp;작성자:&nbsp;</label>
		                <span id="updateEmp"></span>&nbsp;&nbsp;&nbsp;/
		                <label for="inputCalendar" class="form-label">&nbsp;&nbsp;마지막 작성일:&nbsp;</label>
						<span id="updateDate"></span>&nbsp;&nbsp;&nbsp;
						
	                 </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="updateEvent();" id="updateButton" disabled>수정하기</button>
                    <button type="button" class="btn btn-danger" onclick="deleteEvent();">삭제하기</button>
                    
	            	<input type="hidden" id="hiddenSchNo" name="schNo" value="">
	            	<input type="hidden" name="empNo" value="${loginUser.empNo}">
	            	<input type="hidden" id="hiddenSchTitle" name="schTitle" value="">
	            	<input type="hidden" id="hiddenSchShare" name="schShare" value="">
                    
                    
                    <script>
                    	function updateEvent(){
                    		$('#modalClickForm').attr('action', 'updateSchedule').submit();
                    	}
                    	
                    	function deleteEvent(){
                    		$('#modalClickForm').attr('action', 'deleteSchedule').submit();
                    	}
                    </script>
                    <script>
		                    
                    
                    	$('select').on('input', function() {
                        	if ($(this).val() !== '') {
                            	$('#updateButton').removeAttr("disabled");
                            }
                         	else {
                                $('#updateButton').attr('disabled', 'disabled');
                            }
						});
                        $('input[type=date]').on('input', function() {
                        	if ($(this).val() !== '') {
                            	$('#updateButton').removeAttr("disabled");
                        	}
                       		else {
                            	$('#updateButton').attr('disabled', 'disabled');
                        	}
                        });
                        $('input[type=time]').on('input', function() {
                            if ($(this).val() !== '') {
                            	$('#updateButton').removeAttr("disabled");
                            }
                        	else {
                               $('#updateButton').attr('disabled', 'disabled');
                            }
                        });
                        $('input[type=text]').on('input', function() {
                            if ($(this).val() !== '') {
                                $('#updateButton').removeAttr("disabled");
                            }
                            else {
                                $('#updateButton').attr('disabled', 'disabled');
                            }
                        });
						$('textarea').on('input', function() {
                         	if ($(this).val() !== '') {
                            	$('#updateButton').removeAttr("disabled");
                            }
                            else {
                                 $('button').attr('disabled', 'disabled');
                            }
                        });
                    </script>
                  
                    
                </div><!-- 모달 footer -->
                 </form>
            </div>
            
        </div>
    </div><!-- 일정조회 모달 -->
    
    <div class="modal fade" id="insertEventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
        <div class="modal-dialog">
        
            <div class="modal-content calendar-modal-width" style="width:700px;">
            	
                <div class="modal-header">
                    <h5 class="modal-title" id="eventModalLabel">일정추가</h5>
                    
                    <button type="button" class="close" data-bs-dismiss="modal">
                    	<a href="calendar" class="calendar-a-color">&times;</a>
                    </button>
                </div>
                
                <div class="modal-body">
						<div class="calendarWidth">
						<form id="insertCalendar" method="post" action="insertCalendar">
							<table class="table table-sm" id="insertSchedule">
								<tr>
									<th><i class="fa-solid fa-user-plus"></i></th>
									<td colspan="3">
										<select name="schShare" class="mycalendar_input2 mycalendar_width2">
					                    	<option value="M">나의일정</option>
					                    	<option value="D">부서일정</option>
					                    </select>
					                </td>
								</tr>
								
								<tr>
									<th><i class="fa-solid fa-pen"></i></th>
									<td colspan="3"><input type="text" name="schTitle" id="schTitle" class="mycalendar_input mycalendar_width" placeholder="일정 제목 추가" required/></td>
								</tr>
								<tr>
									<th><i class="fa-solid fa-user"></i></th>
									<td><input type="text" name="empName" id="empName" readonly value="${loginUser.empName}" class="mycalendar_input mycalendar_width" /></td>
									<input type="hidden" name="empNo" value="${loginUser.empNo}">
									<input type="hidden" name="empName" value="${loginUser.empName}">
									<th><i class="fa-solid fa-user-tag"></i></th>
									<td><input type="text" name="deptName" id="deptName" readonly value="${loginUser.deptName}" class="mycalendar_input mycalendar_width time_block" /></td>
									<input type="hidden" name="deptCode" value="${loginUser.deptCode}">
								</tr>
								
								<tr>
									<th><i class="fa-solid fa-clock"></i></th>
									
									<td colspan="3">
										<input type="date" name="startDate" id="startDate" class="mycalendar_input2 mycalendar_width2"/>
										<input type="time" name="startTime" id="startTime" class="mycalendar_input2 mycalendar_width2" />
										<label class="switch">
											<input type="checkbox" />
											<span class="slider round"></span>
										</label><p>하루종일</p><p style="display:none;">하루종일</p>
		
										<script>
											var check = $("input[type='checkbox']");
											check.click(()=>{
												$("p").toggle();
												$("input[type='time']").toggle();
												$('input[type="date"]').toggleClass('mycalendar_width3');
											});
										</script>
										
										<br>
										<input type="date" name="endDate" id="endDate" class="mycalendar_input2 mycalendar_width2"/>
										<input type="time" name="endTime" id="endTime" class="mycalendar_input2 mycalendar_width2" />
									</td>
									
								</tr>
								
								<tr>
									<th><i class="fa-solid fa-file"></i></th>
									<td colspan="3"><textarea type="text" name="schContent" id="schContent" class="mycalendar_input calendarTextarea" placeholder="일정 설명 추가"></textarea></td>
								</tr>
								<tr><th></th><td colspan="3"></td></tr>
							</table>
						</div>
                <div class="modal-footer">
					<button type="submit" class="btn btn-sm btn-secondary btn-rigth">일정추가</button>
                </div><!-- modal footer -->
                
            </div><!-- modal-body -->
		</form>
		
        </div>
    </div><!-- insert 모달 -->
    
    </div>
    
    
</body>
</html>