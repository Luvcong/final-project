<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더>나의 일정 추가</title>
	<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- 부트스트립트 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- font-awesome (icon) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- 풀캘린더 -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/index.global.min.js'></script>
	<!-- css-->
	<link rel="stylesheet" href="resources/css/departmentCalendar.css">
	
</head>
<body>

	<jsp:include page="../common/sidebar.jsp"/>
	<div class="pp-content">
		<div class="title-align">&nbsp;</div><h3 class="title-back-color">부서 일정 등록</h3>
			
			<div class="calendar-inner">
				<div class="jsp-include-position">
					<jsp:include page="calendarMini.jsp"/>
				</div>
				
				<div class="insertCalendarForm insertForm-rigth insertForm-position-department">
					<form id="insertCalendar" method="post" action="insertDepartmentCalendar">
						<div class="calendarWidth">
							<br>
							<button type="submit" class="btn btn-sm btn-secondary btn-rigth">일정추가</button>
							<br>
						</div>
						<br>
						<div class="calendarWidth">
							<table class="table table-sm">
								<tr>
									<th><i class="fa-solid fa-pen"></i></th>
									<td colspan="3"><input type="text" name="schTitle" id="schTitle" class="mycalendar_input mycalendar_width" placeholder="일정 제목 추가"></td>
								</tr>
								<tr>
									<th><i class="fa-solid fa-user-plus"></i></th>
									<td colspan="3"><input type="text" name="deptName" id="deptName" class="mycalendar_input mycalendar_width" value="${loginUSer.deptName} 전체 일정 등록" readonly></td>
								</tr>
								<tr>
									<th><i class="fa-solid fa-user"></i></th>
									<td><input type="text" name="empName" id="empName" readonly value="${loginUSer.empName}" class="mycalendar_input mycalendar_width"></td>
									<th><i class="fa-solid fa-user-tag"></i></th>
									<td><input type="text" name="deptId" id="deptId" readonly value="${loginUSer.deptName}" class="mycalendar_input mycalendar_width time_block"></td>
								</tr>
								<tr>
									<th><i class="fa-solid fa-clock"></i></th>
									<td colspan="3">
										<input type="date" name="startDate" id="startDate" class="mycalendar_input2 mycalendar_width2">
										<input type="time" name="startTime" id="startTime" class="mycalendar_input2 mycalendar_width2">
										<label class="switch">
											<input type="checkbox">
											<span class="slider round"></span>
										</label><p>하루종일</p><p style="display:none;">하루종일</p>
		
										<script>
											var check = $("input[type='checkbox']");
											check.click(()=>{
												$("p").toggle();
												$("input[type='time']").toggle();
												$('input[type="date"]').toggleClass('mycalendar_width3');
												/*
												if($('input[type="date"]').className == 'mycalendar_width2'){
													$('input[type="date"]').addClass += 'mycalendar_width3';
													$('input[type="date"]').removeClass ='mycalendar_width2';
												}
												else if($('input[type="date"]').className == 'mycalendar_width3'){
													$('input[type="date"]').addClass += 'mycalendar_width2';
													$('input[type="date"]').removeClass ='mycalendar_width3';
												}
												*/
											});
			
										</script>
										<br>
										<input type="date" name="endDate" id="endDate" class="mycalendar_input2 mycalendar_width2">
										<input type="time" name="endTime" id="endTime" class="mycalendar_input2 mycalendar_width2">
									</td>
									
								</tr>
								
								<tr>
									<th><i class="fa-solid fa-file"></i></th>
									<td colspan="3"><textarea type="text" name="schContent" id="schContent" class="mycalendar_input calendarTextarea" placeholder="일정 설명 추가"></textarea></td>
								</tr>
								<tr><th></th><td colspan="3"></td></tr>
							</table>
						</div>
					</form>
				</div>
			</div>    
    </div>

</body>
</html>