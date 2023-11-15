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
	<!-- css-->
	<link rel="stylesheet" href="resources/css/calendar.css">
	<script>
		calendar.setOption('height', 500);
	</script>
</head>
<body>



	<!-- 참고용: https://eastshine12.tistory.com/48 -->
	<!-- 풀캘린더사용법: https://chobopark.tistory.com/245#google_vignette -->
	<!-- 풀캘린더사용법: https://velog.io/@faulty337/Spring-boot-fullCalendar-ajax-%ED%99%9C%EC%9A%A9 -->

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
		
	    <script>
			document.addEventListener('DOMContentLoaded', function() {
				var calendarEl = document.getElementById('calendar');
	        	var calendar = new FullCalendar.Calendar(calendarEl, {
	        	height: '750px',
	          	initialView: 'dayGridMonth'
	        });
	        	calendar.render();
	      	});
			
	    </script>
	    	
		<div id='calendar' class="calendarWidthMain calendarCenter">
		
		</div>    
	    
    </div>
    
</body>
</html>