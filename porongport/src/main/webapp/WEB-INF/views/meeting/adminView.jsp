<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<link rel="stylesheet" href="resources/css/adminCalendar.css">
</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />
	<div class="pp-content">
	
	<div class="calendar-inner">
		<div class="jsp-include-position">
			<jsp:include page="calendarMini.jsp" />
		<div>	
		
			<div class="insertCalendarForm insertForm-rigth insertForm-position-department">
				<div class="calendar-table-right">
					<table class="borderTable">
						<tr>
							<th>&nbsp;&nbsp;&nbsp;예약현황</th>
							<td><a href="reservationStatus" class="btn">+&nbsp;&nbsp;</button></a>
						</tr>
						<tr>
							<td>
								<ul>
									<li>[확정] 2023-11-27 10:00~12:00 | 인사부: 김유저 대리</li>
									<li>[확정] 2023-11-26 11:00~12:00 | 비품부: 이유저 과장</li>
									<li>[확정] 2023-11-25 14:00~15:00 | 영업부: 홍유저 사원</li>
									<li>[확정] 2023-11-25 14:00~15:00 | 영업부: 홍유저 사원</li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
				
				<br><br><br>
				
				<div class="calendar-table-right">
					<table class="borderTable">
						<tr>
							<th>&nbsp;&nbsp;&nbsp;예약승인</th>
							<td><a href="reservationApprove" class="btn">+&nbsp;&nbsp;</a></td>
						</tr>
						<tr>
							<td>
								<ul>
									<li>[신청] 2023-11-27 10:00~12:00 | 인사부: 김유저 대리</li>
									<li>[신청] 2023-11-26 11:00~12:00 | 비품부: 이유저 과장</li>
									<li>[신청] 2023-11-25 14:00~15:00 | 영업부: 홍유저 사원</li>
									<li>[신청] 2023-11-25 14:00~15:00 | 영업부: 홍유저 사원</li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
				
			</div>
		
		</div>
	</div>

</body>
</html>