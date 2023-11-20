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
    	document.addEventListener('DOMContentLoaded', function() {
        	var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                // Tool Bar 목록 document : https://fullcalendar.io/docs/toolbar
                height: '750px',
                headerToolbar: {
                    left: 'dayGridMonth,dayGridWeek,dayGridDay',
                    center: 'title',
                    right: 'today prevYear,prev,next,nextYear'
                },

                selectable: true,
                selectMirror: true,
                navLinks: true,
                editable: false,
               
                dayMaxEvents: true, 
                // 이벤트 객체 필드 document : https://fullcalendar.io/docs/event-object
                events: [
                    {
                    title: 'All Day Event',
                    start: '2023-11-14'
                    },
                    {
                    title: 'Long Event111',
                    start: '2023-11-15',
                    end: '2023-11-16'
                    },
                    {
                   	// 그룹아이디: 999이 회의실 예약
                    groupId: 999,
                    title: 'Repeating Event',
                    start: '2023-11-17T16:00'
                    },
                    {
                    groupId: 999,
                    title: 'Repeating Event',
                    start: '2023-11-18T16:00'
                    },
                    {
                    title: 'Conference',
                    start: '2023-11-20',
                    end: '2023-11-23'
                    }
                ]
            });
            calendar.render();
        });
		
	
    </script>
</html>
</head>
<body>

	<!-- 참고용: https://eastshine12.tistory.com/48 -->
	<!-- 풀캘린더사용법: https://chobopark.tistory.com/245#google_vignette -->
	<!-- 풀캘린더사용법: https://velog.io/@faulty337/Spring-boot-fullCalendar-ajax-%ED%99%9C%EC%9A%A9 -->

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
		<div id='calendar' class="calendarWidthMain calendarCenter">
		</div>
    </div>
    
</body>
</html>