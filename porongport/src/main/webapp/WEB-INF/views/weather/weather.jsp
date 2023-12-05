<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 날씨</title>
	<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- 메인화면 css-->
    <link rel="stylesheet" href="resources/css/weather.css">
    
</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />
	
	
	<div class="pp-content">
		
		<div>
			<div class="weather-top weather-text-center">
				<h3 class="weather-center">오늘의 날씨</h1>
				<!-- API: https://openweathermap.org/current -->
			</div>
				
			<br><br>
		
			<div class="table-color table-width weather-center">
				
				<table id="weatherTable" class="weather-center">
					
					<thead>
						<tr>
							<td><h4 class="weather-text-left">서울</h4></td>
						<tr>
						
						<tr>
							<th colspan="2" class="weather-text-center"><img src="" id="weatherIcon"></img></th>
							<th id="temp" class="weather-text-center">-3.0도~</th>
							<td class="weather-text-center">&nbsp;/&nbsp;</td>
							<th id="weather" class="weather-text-center">날씨</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="minTemp" class="weather-text-center">최저온도</td>
							<td class="weather-text-center">&nbsp;•&nbsp;</td>
							<td id="maxTemp" class="weather-text-center">최고온도</td>
							<td class="weather-text-center">&nbsp;&nbsp;•&nbsp;&nbsp;</td>
							<td id="fellTemp" class="weather-text-center">체감온도</td>
							<td class="weather-text-center">&nbsp;&nbsp;•&nbsp;&nbsp;</td>
							<td id="humidity" class="weather-text-center">습도</td>
						</tr>
					</tbody>
					
				</table>
				
			</div>
	</div>	
	<script>
		$(()=>{
			$.ajax({
				url: 'weather',
				success:data=>{
					//console.log(data.weather[0].icon);
					//https://openweathermap.org/img/wn/10d@2x.png
					
					var icon = 'https://openweathermap.org/img/wn/'+data.weather[0].icon+'@2x.png';
					var weather = data.weather[0].description;
					var temp = data.main.temp+'°C';
					var minTemp = '최저 '+data.main.temp_min +' °C ';
					var maxTemp = '최고 '+data.main.temp_max +' °C ';
					var fellTemp = '체감 '+data.main.feels_like +' °C ';
					var humidity = '습도 '+ data.main.humidity +' % '; 
					var clouds =  '구름양 '+data.clouds.all +' % ';
					var wind = '풍속 '+ data.wind.speed + ' m/s ';
					
					//console.log(icon);
					
					$('#weatherIcon').attr("src", icon);
					$('#weather').html(weather);
					$('#temp').html(temp);
					$('#minTemp').html(minTemp);
					$('#maxTemp').html(maxTemp);
					$('#fellTemp').html(fellTemp);
					$('#humidity').html(humidity);
					$('#clouds').html(clouds);
					$('#wind').html(wind);
				},
				error:()=>{
					console.log('실패');
				}
			})
		})
	</script>
	
	</div>
</body>
</html>