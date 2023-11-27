<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<style data-fullcalendar=""></style>
<link href="/docs/dist/demo-to-codepen.css" rel="stylesheet">


<style>
html, body {
	margin: 0;
	padding: 0;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	font-size: 14px;
}

#calendar {
	max-width: 1100px;
	margin: 40px auto;
	height: 230px;
}
</style>



<script src="https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.9/index.global.min.js"></script>

<script src="/docs/dist/demo-to-codepen.js"></script>
<link rel="stylesheet" href="resources/css/meeting.css">


<script>
	document.addEventListener('DOMContentLoaded', function() {
	  var calendarEl = document.getElementById('calendar');

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
						color : "#f1c232"
						
			        });
				}
				
				for(i=0;  i<departmentSchedule.length; i++){
					calendar.addEvent({
						id: departmentSchedule[i].schNo,
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
					start: data[i].meetStartTime,
					end: data[i].meetEndTime,
					color : "#8ecae6"
		        });
			}
			},
			error:()=>{
				console.log('실패');
			}
		})
	  
	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    selectable: true,
	    slotMinTime: '09:00',
	    slotMaxTime: '18:00',

	    dateClick: info=>{
    		var meetStartTime = info.dateStr;
    		var meetEndTime = info.dateStr;
    		$('#meetStartTime').val(meetStartTime);
    		$('#meetEndTime').val(meetEndTime);
    		
    		$('#insertMeetModal').modal();
    	},
    	
	    select : info=>{
	    	var meetStartTime = info.startStr;
    		var meetEndTime = info.endStr;
    		$('#meetStartTime').val(meetStartTime);
    		$('#meetEndTime').val(meetEndTime);
    		
    		$('#insertMeetModal').modal();
	    },
	    
	    
	    eventClick: (calEvent, jsEvent, view) => {
            //console.log(calEvent.event._def.publicId);
    		
            $('#meetNo').val(calEvent.event._def.publicId);
            
            $('#eventModalLabel').text(calEvent.event._def.title);
    	    
    	    var selectMeetStartDay = calEvent.el.fcSeg.eventRange.instance.range.start;
    	    
    	    var meetStartDay = selectMeetStartDay.getFullYear()+'-'
	 		+((selectMeetStartDay.getMonth()+1) < 10 ? "0" + (selectMeetStartDay.getMonth()+1) : (selectMeetStartDay.getMonth()+1))+'-'
	 		+((selectMeetStartDay.getDate()) < 10 ? "0" + (selectMeetStartDay.getDate()) : (selectMeetStartDay.getDate()));

    	  
    	    if((selectMeetStartDay.getHours()-9)<0){
    	    	var meetStartTime = (((selectMeetStartDay.getHours()-9)+24) < 10 ? "0" + ((selectMeetStartDay.getHours()-9)+24) : ((selectMeetStartDay.getHours()-9)+24)) +':'
								+((selectMeetStartDay.getMinutes()) < 9 ? "0" + (selectMeetStartDay.getMinutes()) : (selectMeetStartDay.getMinutes()));
    	    }
    	    else{
    	    	 var startTime = (((selectMeetStartDay.getHours()-9)) < 10 ? "0" + ((selectMeetStartDay.getHours()-9)) : ((selectMeetStartDay.getHours()-9))) +':'
 								+((selectMeetStartDay.getMinutes()) < 9 ? "0" + (selectMeetStartDay.getMinutes()) : (selectMeetStartDay.getMinutes()));
    	    }
    	    
    	    var selectMeetEndDay = calEvent.el.fcSeg.eventRange.instance.range.end;
    	    
    	    var meetEndDaye = selectMeetEndDay.getFullYear()+'-'
	 		+((selectMeetEndDay.getMonth()+1) < 10 ? "0" + (selectMeetEndDay.getMonth()+1) : (selectMeetEndDay.getMonth()+1))+'-'
	 		+((selectMeetEndDay.getDate()) < 10 ? "0" + (selectMeetEndDay.getDate()) : (selectMeetEndDay.getDate()));

    	    
    	      	    if((selectMeetEndDay.getHours()-9)<0){
    	    	var endTime = (((selectMeetEndDaye.getHours()-9)+24) < 10 ? "0" + ((selectMeetEndDay.getHours()-9)+24) : ((selectMeetEndDay.getHours()-9)+24)) +':'
								+((selectMeetEndDay.getMinutes()) < 10 ? "0" + (selectMeetEndDay.getMinutes()) : (selectMeetEndDay.getMinutes()));
    	    }
    	    else{
    	    	var meetEndTime = (((selectMeetEndDay.getHours()-9)) < 10 ? "0" + ((selectMeetEndDay.getHours()-9)) : ((selectMeetEndDay.getHours()-9))) +':'
							 +((selectMeetEndDay.getMinutes()) < 10 ? "0" + (selectMeetEndDay.getMinutes()) : (selectMeetEndDay.getMinutes()));
    	    }
    	      	    
    	    $("#meetStartDay").val(meetStartDay);
            $("#meetEndDay").val(meetEmdDay);
    	    
    	    $("#meetStartTime").val(meetStartTime);
    	    $("#meetEndTime").val(meetEndTime);
    	    
    	    $('#eventModal').modal();
        },
    	
        height: '230px',
        width:'100%',

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
                click: function(event) { 
                	location.href="/porong/reservation";
                } 
    		}
    	},
    	
    	  headerToolbar: {
    	      left: 'prev,next',
    	      center: 'title',
    	      right: 'today'
    	    },
    	    initialView: 'resourceTimelineDay',
    	    aspectRatio: 1.5,
    	    resourceAreaColumns: [
    	      {
    	        field: 'title',
    	        headerContent: '회의실'
    	      }
    	      
    	    ],
    	    resources: [
    	      { id: 'a', title: '회의실 A'},
    	      { id: 'b', title: '회의실 B'},
    	      { id: 'c', title: '회의실 C'}
    	    ]
    	  });
    	  calendar.render();
    	});
	    
	    
	  
	
	
</script>

</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />
	<div class="pp-content">
		<div id='calendar'></div>
		<div class="modal fade" id="insertMeetModal" tabindex="-1"
			aria-labelledby="eventModalLabel" aria-hidden="true">
			<div class="modal-dialog">

				<div class="modal-content calendar-modal-width"
					style="width: 700px;">

					<div class="modal-header">
						<h5 class="modal-title" id="meetModalLabel">회의실 예약신청</h5>

						<button type="button" class="close" data-bs-dismiss="meet">
							<a href="calendar" class="calendar-a-color">&times;</a>
						</button>
					</div>

					<div class="modal-body">
						<div class="calendarWidth">
							<form id="insertMeeting" method="post" action="insertMeeting">
								<table class="table table-sm" id="insertSchedule">

									<tr>
										<th><i class="fa-solid fa-pen"></i></th>
										<td colspan="3"><input type="text" name="meetTitle"
											id="inputmeetTitle" class="mymeeting_input mymeeting_width"
											placeholder="회의 제목 추가" required /></td>
									</tr>
									<tr>
										<th><i class="fa-solid fa-user"></i></th>
										<td><input type="text" name="empName" id="empName"
											readonly value="${loginUser.empName}"
											class="mymeeting_input mymeeting_width" /></td>
										<input type="hidden" name="empNo" value="${loginUser.empNo}">
										<th><i class="fa-solid fa-user-tag"></i></th>
										<td><input type="text" name="deptName" id="deptName"
											readonly value="${loginUser.deptName}"
											class="mymeeting_input mymeeting_width time_block" /></td>
										<input type="hidden" name="deptCode" value="${loginUser.deptCode}">
									</tr>

									<tr>
										<th><i class="fa-solid fa-clock"></i></th>
										<td colspan="5">
											<input type="date" name="meetStartDay"	id="meetStartDay" class="mymeeting_input2 mymeeting_width2" readonly/>
											<input type="time" name="meetStartTime"	id="meetStartTime" class="mymeeting_input2 mymeeting_width2" required /> ~
											<input type="date" name="meetEndDay"	id="meetEndDay" class="mymeeting_input2 mymeeting_width2" readonly/>
											<input type="time" name="meetEndTime" id="meetEndTime" class="mymeeting_input2 mymeeting_width2" required />
										</td>
									</tr>
									<tr>
										<th><i class="fa-solid fa-user-group"></i></th>
										<td colspan="3"><input type="number" class="meetingform"
											id="meetPnum" name="meetPnum" style="width: 50px;"
											min=1 style="width: 250px;" required>명</td>
									</tr>
									<tr>
										<th><i class="fa-solid fa-file"></i></th>
										<td colspan="3">
										<textarea type="text" name="meetContent" id="meetContent" class="mymeeting_input meetingTextarea" placeholder="회의 설명 추가"></textarea>
										</td>
									</tr>
									
								</table>
						</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-sm btn-secondary btn-rigth">예약신청</button>
						</div>
						<!-- modal footer -->

					</div>
					<!-- modal-body -->
					</form>

				
			</div>
			<!-- insert 모달 -->

		</div>
	</div>

</body>
</html>