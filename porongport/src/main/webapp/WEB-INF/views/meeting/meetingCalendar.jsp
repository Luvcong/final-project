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
	    slotMinTime: '09:00', // 회의실 예약이 가능한 시작시간
	    slotMaxTime: '18:00', // 회의실 예약이 가능한 마지막시간

    	 select : info=>{
 	    	var meetStartTime = info.startStr; //회의실 시작시간
     		var meetEndTime = info.endStr;     //회의실 끝나는시간
    //풀캘린더에서 제공하는 날짜형식은 2023-12-11T00:00:00+09:00 으로 제공하기 때문에
     		var starttime = meetStartTime.substr(11, 8); 
	//					11번째부터 8자리로 시작시간을 뽑는다
     		var endtime = meetEndTime.substr(11, 8);
	//					11번째부터 8자리로 끝시간을 뽑는다
	
     		var meetStartDay = info.startStr;
     		var meetEndDay = info.endStr;
     		
     		var startday = meetStartDay.substr(0,10);
	//					0~8자리로 시작날짜를 뽑는다
     		var endday = meetEndDay.substr(0,10);
	//					0~8자리로 끝날짜를 뽑는다 		
     		$('#meetStartTime').val(starttime);
     		$('#meetEndTime').val(endtime);
     		
     		$('#meetStartDay').val(startday);
    		$('#meetEndDay').val(endday);
     		
     		$('#insertMeetModal').modal();
     		
 	    },
	    
	    eventClick: (calEvent, jsEvent, view) => {
	    	
    		
            $('#meetNo').val(calEvent.event._def.publicId);
            
            $('#eventModalLabel').text(calEvent.event._def.title);
    	    
    	    var smsd = calEvent.el.fcSeg.eventRange.instance.range.start; //selectMeetStartDay
    	    var smed = calEvent.el.fcSeg.eventRange.instance.range.end; //selectMeetEndDay
    	    
    	    var smsd = smsd.getFullYear()+'-'
	 		+((smsd.getMonth()+1) < 10 ? "0" + (smsd.getMonth()+1) : (smsd.getMonth()+1))+'-'
	 		+((smsd.getDate()) < 10 ? "0" + (smsd.getDate()) : (smsd.getDate()));
    	  
    	    if((smsd.getHours()-9)<0){
    	    	var meetStartTime = (((smsd.getHours()-9)+24) < 10 ? "0" + ((smsd.getHours()-9)+24) : ((smsd.getHours()-9)+24)) +':'
								+((smsd.getMinutes()) < 9 ? "0" + (smsd.getMinutes()) : (smsd.getMinutes()));
    	    }
    	    else{
    	    	 var startTime = (((smsd.getHours()-9)) < 10 ? "0" + ((smsd.getHours()-9)) : ((smsd.getHours()-9))) +':'
 								+((smsd.getMinutes()) < 9 ? "0" + (smsd.getMinutes()) : (smsd.getMinutes()));
    	    }
    	    
    	    
    	    var smed = smed.getFullYear()+'-'
	 		+((smed.getMonth()+1) < 10 ? "0" + (smed.getMonth()+1) : (smed.getMonth()+1))+'-'
	 		+((smed.getDate()) < 10 ? "0" + (smed.getDate()) : (smed.getDate()));

    	    
    	      	    if((smed.getHours()-9)<0){
    	    	var endTime = (((smed.getHours()-9)+24) < 10 ? "0" + ((smed.getHours()-9)+24) : ((smed.getHours()-9)+24)) +':'
								+((smed.getMinutes()) < 10 ? "0" + (smed.getMinutes()) : (smed.getMinutes()));
    	    }
    	    else{
    	    	var meetEndTime = (((smed.getHours()-9)) < 10 ? "0" + ((smed.getHours()-9)) : ((smed.getHours()-9))) +':'
							 +((smed.getMinutes()) < 10 ? "0" + (smed.getMinutes()) : (smed.getMinutes()));
    	    }
    	      	    
    	    $("#meetStartTime").val(meetStartTime);
    	    $("#meetEndTime").val(meetEndTime);
    	    
    	    $('#eventModal').modal();
        },
    	
        height: '160px',
        
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
		<!-- 			
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
					
					</form>
				<!-- modal-body -->	
				
				
			</div>
			
			
		</div>
	</div>

</body>
</html>