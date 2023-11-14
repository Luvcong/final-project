<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home>캘린더</title>

	 <link rel="stylesheet" href="resources/css/calendar.css">
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
    
    	<div class="sec_cal">
			<div class="cal_nav">
			    <a href="javascript:;" class="nav-btn go-prev">prev</a>
			    <div class="year-month"></div>
			    <a href="javascript:;" class="nav-btn go-next">next</a>
			</div>
			<div class="cal_wrap">
				<div class="days">
					<div class="day">MON</div>
			      	<div class="day">TUE</div>
			      	<div class="day">WED</div>
			      	<div class="day">THU</div>
			      	<div class="day">FRI</div>
			      	<div class="day">SAT</div>
			      	<div class="day">SUN</div>
			    </div>
			<div class="dates"></div>
			</div>
		</div>
    
    
    
    </div>  <!-- content -->
    
</body>
</html>