<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더>나의 일정 추가</title>
	<!-- 부트스트립트 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- css-->
	<link rel="stylesheet" href="resources/css/myCalendar.css">
</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />
	<div class="pp-content">
		
		<div>
		
			<form id="insertCalendar" method="post" action="insertMyCalendar">
				<div class="calendarWidth">
					<table class="table table-sm table-bordered">
						<tr>
							<th>일정제목</th>
							<td colspan="3"><input type="text" name="" id="" class="mycalendar_input"></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><input type="text" name="empName" id="empName" readonly value="${loginUser.empName}" class="mycalendar_input"></td>
							<th>부서</th>
							<td><input type="text" name="deptId" id="deptId" readonly value="${loginUser.deptName}" class="mycalendar_input"></td>
						</tr>
						<tr>
							<th>시작일</th>
							<td><input type="date" name="" id="" class="mycalendar_input"></td>
							<th>종료일</th>
							<td><input type="date" name="" id="" class="mycalendar_input"></td>
						</tr>
						
						<tr>
							<th>일정내용</th>
							<td colspan="3"><textarea type="text" name="" id="" class="mycalendar_input calendarTextarea"></textarea></td>
						</tr>
					</table>
				</div>
				<br>
				<div class="myCalendar-btn">
					<button type="submit" class="btn btn-sm btn-secondary">일정추가</button>
				</div>
			</form>
			
		</div>    
	    
    </div>

</body>
</html>