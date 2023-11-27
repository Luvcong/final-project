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
}
</style>



<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.9/index.global.min.js"></script>


<script src="/docs/dist/demo-to-codepen.js"></script>


<script>
	document.addEventListener('DOMContentLoaded', function() {
	  var calendarEl = document.getElementById('calendar');

	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    selectable: true,
	    dateClick : function(info) {
	            alert('clicked ' + info.dateStr + ' on resource '
	                  + info.resource.id);
	    },
	    select : function(info) {
	            alert('selected ' + info.startStr + ' to ' + info.endStr
	                  + ' on resource ' + info.resource.id);
	    },
	    headerToolbar: {
	      left: 'today prev,next',
	      center: 'title',
	      right: 'resourceTimelineDay,resourceTimelineWeek'
	    },
	    initialView: 'resourceTimelineDay',
	    aspectRatio: 1.5,
	    resourceAreaColumns: [
	      {
	        field: 'title',
	        headerContent: 'Room'
	      }
	      
	    ],
	    resources: [
	      { id: 'a', title: 'Auditorium A'}
	      
	    ]
	  });

	  calendar.render();
	});
</script>

</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />
	<div class="pp-content">
		<div style="height:100px;">
			<div id='calendar'></div>
			<!-- Cloudflare Pages Analytics -->
			<script defer
				src='https://static.cloudflareinsights.com/beacon.min.js'
				data-cf-beacon='{"token": "dc4641f860664c6e824b093274f50291"}'></script>
			<!-- Cloudflare Pages Analytics -->
		</div>
	</div>

</body>
</html>