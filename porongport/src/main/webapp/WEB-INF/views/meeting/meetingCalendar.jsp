<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<style data-fullcalendar=""></style>


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


<!-- 여기가 시간데별 색주는곳

 /*
  td.fc-timeline-slot.fc-timeline-slot-lane.fc-timeline-slot-minor{
 background-color: black;
 }
 
 td.fc-timeline-slot.fc-timeline-slot-lane.fc-timeline-slot-major{
 background-color: black;
 } 
 */


</style>



<script src="https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.9/index.global.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
		
	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    selectable: true,
	    slotMinTime: '09:00',
	    slotMaxTime: '18:00',

    	 select : info=>{
 	    	var meetStartTime = info.startStr;
     		var meetEndTime = info.endStr;
     		
     		var result = meetStartTime.substr(11, 18);
     		var result2 = result.substr(0, 8);
     		var result3 = meetEndTime.substr(11, 18);
     		var result4 = result3.substr(0, 8);
  //  		console.log(result2);
  //   		console.log(result4);
     		var meetStartDay = info.startStr;
     		var meetEndDay = info.endStr;
     		
     		var startday = meetStartDay.substr(0,10);
     		var endday = meetEndDay.substr(0,10);
     		
     		$('#meetStartTime').val(result2);
     		$('#meetEndTime').val(result4);
     		
     		$('#meetStartDay').val(startday);
    		$('#meetEndDay').val(endday);
     		
     		$('#insertMeetModal').modal();
     		
 	    },
	    
	    eventClick: (calEvent, jsEvent, view) => {
    		
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
    	    
    	    var meetEndDay = selectMeetEndDay.getFullYear()+'-'
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
    	      	    
    	    $("#meetStartTime").val(meetStartTime);
    	    $("#meetEndTime").val(meetEndTime);

    	    
    	    $('#eventModal').modal();
        },
    	
        height: '160px',

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
    		meetingroomButton: { 
                text: '내일정', 
                click: function(event) { 
                	location.href="/porong/calendar";
                } 
    		}
    	},
    	
    	  headerToolbar: {	
    	      left: 'prev,next',
    	      center: 'title',
    	      right: 'meetingroomButton today'
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
    	      { id: 'a', title: '회의실'}
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
			aria-labelledby="eventModalLabel" aria-hidden="true" name="insertMeetModal">
			<div class="modal-dialog">

				<div class="modal-content calendar-modal-width"
					style="width: 700px;">

					<div class="modal-header">
						<h5 class="modal-title" id="meetModalLabel">회의실 예약신청</h5>
						<div id="checkResult" style="font-size:2em; display:none;"></div>

						       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						       <span aria-hidden="true">&times;</span>
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
										<input type="hidden" name="deptCode"
											value="${loginUser.deptCode}">
									</tr>

									<tr>
										<th><i class="fa-solid fa-clock"></i></th>
										<td colspan="5">
											<div id="times" name="times">
												<input type="date" name="meetStartDay" id="meetStartDay"
													class="mymeeting_input2 mymeeting_width2" readonly /> <input
													type="time" name="meetStartTime" id="meetStartTime"
													class="mymeeting_input2 mymeeting_width2" required readonly />
												~ <input type="date" name="meetEndDay" id="meetEndDay"
													class="mymeeting_input2 mymeeting_width2" readonly /> <input
													type="time" name="meetEndTime" id="meetEndTime"
													class="mymeeting_input2 mymeeting_width2" required readonly />
											</div>
										</td>
									</tr>
									<tr>
										<th><i class="fa-solid fa-user-group"></i></th>
										<td colspan="3"><input type="number" class="meetingform"
											id="meetPnum" name="meetPnum" style="width: 50px;" min=1
											style="width: 250px;" required>명</td>
									</tr>
									<tr>
										<th><i class="fa-solid fa-file"></i></th>
										<td colspan="3"><textarea type="text" name="meetContent"
												id="meetContent" class="mymeeting_input meetingTextarea"
												placeholder="회의 설명 추가"></textarea></td>
									</tr>

								</table>
								
								
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-sm btn-secondary btn-rigth disabled">예약신청</button>
					</div>
					<!-- modal footer -->
					
					<script>
						    	$(function(){
						    		const $timeInput = $('#times');
						    		
						    	    const $meetStartDay = $('#meetStartDay').val();
						    		const $meetStartTime = $('#meetStartTime').val();
						    		const $meetStart = $meetStartDay+'T'+$meetStartTime;
						    		console.log($meetStartDay);
						    		console.log($meetStartTime);
						   // 		console.log($timeInput);
						   // 		console.log("뭐야;;");
						    		
						    		const $checkResult = $('#checkResult');
						    		const $enrollFormSubmit = $('#insertMeeting :submit');
						    		
						    	$(document).on('click',$timeInput,function(){
						    			if($timeInput.val().length >=0){
						    				$.ajax({
						    					url : 'dbtimeCheck',
						    					data : {checkId : $timeInput.val()},
						    					success : function(result){
						    						console.log(result);
						    						
						    						if(result =='N'){
						    							$checkResult.show().css('color','crimson').text('중복된 예약이 존재합니다');
						    							$enrollFormSubmit.attr('disabled', true);
						    						}else {
						    							$checkResult.show().css('color','lightgreen').text('예약이 가능 합니다');
						    							$enrollFormSubmit.removeAttr('disabled');
						    						}
						    					},
						    					error : function(){
						    						console.log('예약중복체크용 ajax실패')
						    					}
						    				});
						    			}
						    			else{
						    				$checkResult.hide();
						    				$enrollFormSubmit.attr('disabled',true);
						    			}
						    		})
						    		
						    	})
								</script>
				 	
					
					</div>
					<!-- modal-body -->
					</form>
					
				
			</div>
			
			
		</div>
	</div>

</body>
</html>