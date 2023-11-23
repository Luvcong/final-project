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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

	<div class="pp-content">
	<h2 class="title-align">회의실 예약하기</h2>
	<jsp:include page="../calendar/calendarMini.jsp" />
			
			<div class="insertMeetingForm insertForm-rigth insertForm-position">
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
						
						<td colspan="3">
						<input type="date" name="meetStartDate" id="meetStartDate" class="meeting_input2 meeting-width2">
						<input type="time" name="meetStartTime" id="meetStartTime" class="meeting_input2 meeting-width2" >
							<!-- 
							<select name="meetStartTime" id="meetStartTime"
							class="meeting_input2 meeting_width2">
								<option value="09:00">09:00</option><option value="09:30">09:30</option>
								<option value="10:00">10:00</option><option value="10:30">10:30</option>
								<option value="11:00">11:00</option><option value="11:30">11:30</option>
								<option value="12:00">12:00</option><option value="12:30">12:30</option>
								<option value="13:00">1:00</option>
								<option value="13:30">1:30</option><option value="14:00">2:00</option>
								<option value="14:30">2:30</option><option value="15:00">3:00</option>
								<option value="15:30">3:30</option><option value="16:00">4:00</option>
								<option value="16:30">4:30</option><option value="17:00">5:00</option>
								<option value="17:30">5:30</option>
						</select> -->
						 <label class="switch"> <input type="checkbox"> <span class="slider round"></span>
						</label>
							<p>하루종일</p>
							<p style="display:none;">하루종일</p>
								 <script>
									var check = $("input[type='checkbox']");
									check.click(()=>{
									$("p").toggle();
									$("input[type='time']").toggle();
									$("input[type='date']").toggleClass('meeting-width3');
										
										}); </script> 
										<br> 
										<input type="date" name="meetEndDate" id="meetEndDate" class="meeting_input2 meeting-width2">
										<input type="time" name="meetEndTime" id="meetEndTime" class="meeting_input2 meeting-width2" >
					<!-- 					
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
						</select> -->
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
	<script>

	var now_utc = Date.now() 
	var timeOff = new Date().getTimezoneOffset()*60000; 
	var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
	document.getElementById("meetStartDate").setAttribute("min", today);
	document.getElementById("meetEndDay").setAttribute("min", today);
  

</script>
	
	
	<!-- 
	
	
	<script>
    	$(function(){	
    		const $idInput = $('.form-group #userId');
    		const $checkResult = $('#checkResult');
    		const $enrollFormSubmit = $('#enroll-form :submit');
    		$idInput.keyup(function(){
    			// console.log($idInput.val());
    			// 최소 5글자 이상으로 입력했을 때만 AJAX요청을 보내서 중복체크
    			if($idInput.val().length >=5){
    				$.ajax({
    					url : 'idCheck.me',
    					data : {checkId : $idInput.val()},
    					success : function(result){
    						//console.log(result.substr(4));	
    						
    						if(result.substr(4)==='N'){
    							$checkResult.show().css('color','crimson').text('중복된 아이디가 존재합니다');
    							$enrollFormSubmit.attr('disabled', true);
    						}else {
    							$checkResult.show().css('color','lightgreen').text('사용가능한 아이디입니다');
    							$enrollFormSubmit.removeAttr('disabled');
    						}
    					},
    					error : function(){
    						console.log('아디디중복체크용 ajax실패')
    					}
    				});
    			}
    			else{
    				$checkResult.hide();
    				$enrollFormSubmit.attr('disabled',true);
    			}
    		})
    		
    	})
    </script>
	<script>
	function test1(){
		$.ajax({
			url : 'ajax1.do', //필수 정의 속성(url매핑값)
			data : {// 요청시전달값
				startTime : $(meetStartTime).val(), // value속성값에 접근했을 경우 !! 무조건 String 타입
				endTime : $(meetEndTime).val()
				},
				success : function(result){ //해당 통신에 성공했을 때
					console.log(result);
				
					// 응답데이터가 배열의 형태! => 인덱스로 접근가능[인덱스]
					//  const value = '이름: ' + result[0] + '<br>나이: ' +result[1];
				
					// 응답데이터가 객체의 형태! => 속성에 접근가능. 속성명
					const value = '이름: ' + result.name + '<br>나이 : ' + result.age;
					// 몇번째 들어오는 건지 몰라도 name, age 이런거 알면 되기 떄문에 Object타입을 더 많이씀
					$('#result1').html(value);
				},
				error : function(){ //통신에 실패했을떄
					console.log('ajax통신 실패~');
				}
		});
	}
	</script>
	. -->
	



</body>
</html>