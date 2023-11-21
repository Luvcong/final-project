<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 예약</title>
<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 풀캘린더 -->
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/index.global.min.js'></script>
<!-- css-->
<link rel="stylesheet" href="resources/css/meeting.css">

<jsp:include page="../common/sidebar.jsp" />


<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

	<div class="pp-content">
	<h2 class="title-align">회의실 예약하기</h2>
	<jsp:include page="../calendar/calendarMini.jsp" />
			
			<div class="insertMeetingForm insertForm-rigth insertForm-position ">
		<form id="insertMeeting" method="post" action="insertMeeting">
			<div class="myCalendar-btn meetingWidth"></div>
			<table class="table">
				<thead>
				</thead>
				<tbody>
					<tr>
						<th><i class="fa-solid fa-pen"></i></th>
						<td colspan="3"><input type="text" class="meetingform" id="meetTitle"
							placeholder="회의제목을 입력해주세요" name="meetTitle" style="width:520px;" required></td>
					</tr>
					<tr>
						<th><i class="fa-solid fa-building"></i></th>
						<td colspan="3">회의실</td>
					</tr>
					<tr>
						<th><i class="fa-solid fa-user"></i></th>
						<td><input type="text" class="meetingform" value="${loginUser.empName}"
							name="meetName" readonly></td>
						<th><i class="fa-solid fa-user-tag"></i></th>
						<td><input type="text" name="deptId" id="deptId" readonly value="${loginUser.deptName}" style="width: 250px;" class="meetingform" /></td>
					</tr>
					<tr>
						<th><i class="fa-solid fa-clock"></i></th>
						
						<td colspan="3"><input type="date" class="meetingStartDay"
							id="meetStartDay" class="meeting_input2 meeting-width2" name="meetStartDay">
							<select name="meetStartTime" id="meetStartTime"
							class="meeting_input2 meeting_width2">
								<option value="09:00">09:00</option>
								<option value="09:30">09:30</option>
								<option value="10:00">10:00</option>
								<option value="10:30">10:30</option>
								<option value="11:00">11:00</option>
								<option value="11:30">11:30</option>
								<option value="12:00">12:00</option>
								<option value="12:30">12:30</option>
								<option value="13:00">1:00</option>
								<option value="13:30">1:30</option>
								<option value="14:00">2:00</option>
								<option value="14:30">2:30</option>
								<option value="15:00">3:00</option>
								<option value="15:30">3:30</option>
								<option value="16:00">4:00</option>
								<option value="16:30">4:30</option>
								<option value="17:00">5:00</option>
								<option value="17:30">5:30</option>
						</select> <label class="switch"> <input type="checkbox"> <span class="slider round"></span>
						</label>
							<p>하루종일</p>
							<p style="display: none;">하루종일</p> <script>
											var check = $("input[type='checkbox']");
											check.click(()=>{
												$("p").toggle();
												$("select").toggle();
												$('input[type="date"]').toggleClass('meeting-width3');
										
											});
			
										</script> <br> <label for="meetingEndDay"></label><input
							type="date" class="meetingEndDay"id="meetEndDay" name="meetEndDay"><label
							for="meetingEndTime"></label> 
							<select name="meetEndTime" id="meetEndTime" class="meeting_input2 meeting_width2">
								<option value="09:30">09:30</option>
								<option value="10:00">10:00</option>
								<option value="10:30">10:30</option>
								<option value="11:00">11:00</option>
								<option value="11:30">11:30</option>
								<option value="12:00">12:00</option>
								<option value="12:30">12:30</option>
								<option value="13:00">1:00</option>
								<option value="13:30">1:30</option>
								<option value="14:00">2:00</option>
								<option value="14:30">2:30</option>
								<option value="15:00">3:00</option>
								<option value="15:30">3:30</option>
								<option value="16:00">4:00</option>
								<option value="16:30">4:30</option>
								<option value="17:00">5:00</option>
								<option value="17:30">5:30</option>
								<option value="18:00">6:00</option>
						</select>
						※하루종일/장기간예약시 미리 연락바랍니다</td>

					</tr>
					<tr>
						<th><i class="fa-solid fa-user-group"></i></th>
						<td colspan="3"><input type="number" class="meetingform"
							id="meetPnum" name="meetPnum" style="width: 50px;"
							min=1 style="width: 250px;" required>명</td>
					</tr>
					<tr>
						<th><i class="fa-solid fa-file"></i></th>
						<td colspan="3"><textarea type="text" name="meetContent" id="meetContent"
								class="meetingform meeting_input meetingTextarea"
								placeholder="일정 설명 추가" required style="width: 520px;"></textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="btns" align="center">
				<button type="submit" class="btn btn-info">신청하기</button>
				<button type="reset" class="btn btn-danger">취소</button>
			</div>
			</form>
		</div>
	</div>
	
	



</body>
</html>