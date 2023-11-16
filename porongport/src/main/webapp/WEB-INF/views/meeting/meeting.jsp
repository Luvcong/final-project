<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 예약</title>
<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- 풀캘린더 -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/index.global.min.js'></script>
	<!-- css-->
	<link rel="stylesheet" href="resources/css/calendar.css">
	<jsp:include page="../common/sidebar.jsp" />
	 <meta name="viewport" content="width=device-width, initial-scale=1">
	  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
	  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<style>
	.meetingroom{
	width: 40%;
    height: 100%;
	margin: auto;
	}
	
	.meetingcontent{
	text-align: start;
	}
	
	.table{
	size : 50%;
	}
	
	.meetingform{
	border:none;
	}
	.meetingStartDay, .meetingStartTime, .meetingEndDay, .meetingEndTime{
	border-radius: 10px;
	border: 1px solid gray;
	}
	.meetingroom > h2{
	text-align: center;	
	}
	
	</style>
	
	</head>
<body>
	<div class="pp-content">
		<div class="meetingroom">
			<h2>회의실 예약하기</h2>
			<table class="table">
				<thead>

				</thead>
				<tbody>
					<tr>
						<td><label for="meetingtitle">회의 제목 </label></td>
						<td><input type="text" class="meetingform" id="meetingtitle"
							placeholder="회의제목을 입력해주세요" name="mettingtitle" required></td>
					</tr>
					<tr>
						<td><label for="meetingrooms">회의실 장소</label></td>
						<td>회의실</td>
					</tr>
					<tr>
						<td><label for="reservationer">예약자</label></td>
						<td><input type="text" class="meetingform" value="김건희"
							name="name" style="width: 80px;" readonly></td>
					</tr>
					<tr>
						<td><label for="meetingStartDay">예약시간</label>
						<td><input type="date" class="meetingStartDay"> <label
							for="meetingStartTime"></label> <select name="meetingStartTime"
							id="meetingStartTime" class="meetingStartTime" name="meetingStartTime">
								<option value="900">9:00</option>
								<option value="930">9:30</option>
								<option value="1000">10:00</option>
								<option value="1030">10:30</option>
								<option value="1100">11:00</option>
								<option value="1130">11:30</option>
								<option value="1200">12:00</option>
								<option value="1230">12:30</option>
								<option value="1300">1:00</option>
								<option value="1330">1:30</option>
								<option value="1400">2:00</option>
								<option value="1430">2:30</option>
								<option value="1500">3:00</option>
								<option value="1530">3:30</option>
								<option value="1600">4:00</option>
								<option value="1630">4:30</option>
								<option value="1700">5:00</option>
								<option value="1730">5:30</option>
								<option value="1800">6:00</option>
						</select> ~ <label for="meetingEndDay"></label> <input type="date"
							class="meetingEndDay"> <label for="meetingEndTime"></label>
							<select name="meetingEndTime" id="meetingEndTime"
							 class="meetingEndTime">
								<option value="900">9:00</option>
								<option value="930">9:30</option>
								<option value="1000">10:00</option>
								<option value="1030">10:30</option>
								<option value="1100">11:00</option>
								<option value="1130">11:30</option>
								<option value="1200">12:00</option>
								<option value="1230">12:30</option>
								<option value="1300">1:00</option>
								<option value="1330">1:30</option>
								<option value="1400">2:00</option>
								<option value="1430">2:30</option>
								<option value="1500">3:00</option>
								<option value="1530">3:30</option>
								<option value="1600">4:00</option>
								<option value="1630">4:30</option>
								<option value="1700">5:00</option>
								<option value="1730">5:30</option>
								<option value="1800">6:00</option>
						</select></td>

					</tr>
					<tr>
						<td><label for="meetingpeople">참여인원 </label></td>
						<td><input type="number" class="meetingform"
							id="meetingpeople" name="meetingpeople" style="width: 50px;"
							min=1 required>명</td>
					</tr>
					<tr>
						<td><label for="meetingcontent">내용 </label></td>
						<td><input type="text" class="meetingform"
							id="meetingcontent" name="meetingcontent"
							style="width: 500px; height: 300px;" required></td>
					</tr>
				</tbody>
			</table>
			<div class="btns" align="center">
				<button type="submit" class="btn btn-info">신청하기</button>
				<button type="reset" class="btn btn-danger">취소</button>
			</div>
		</div>
	</div>



</body>
</html>