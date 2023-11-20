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
		document.addEventListener('DOMContentLoaded', ()=>{
			$.ajax({
				url: 'calendarMain',
				success:list=>{
					//console.log(list.mySchedule);
					var mySchedule = list.mySchedule;
					var departmentSchedule = list.departmentSchedule;
					//console.log(mySchedule[0].schTitle);
					
					for(i=0;  i<mySchedule.length; i++){
						calendar.addEvent({
							title: mySchedule[i].schTitle,
							description: mySchedule[i].schContent,
							start: mySchedule[i].schStart,
							end: mySchedule[i].schEnd,
							color : "#f1c232"
				        });
					}
					
					for(i=0;  i<departmentSchedule.length; i++){
						calendar.addEvent({
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
                initialView: 'dayGridMonth',
                dayMaxEvents: true,
                
                eventDidMount: function(info) {
                    var tooltip = new Tooltip(info.el, {
                      title: info.event.extendedProps.description,
                      placement: 'top',
                      trigger: 'hover',
                      container: 'body',
                      html: true
                    });
                 }
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