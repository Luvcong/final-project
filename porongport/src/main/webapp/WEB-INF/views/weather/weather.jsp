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
			<h3>오늘의 날씨</h1>
		</div>
		
		<script>
			$(()=>{
				$.ajax({
					url: 'weather',
					success:data=>{
						console.log(data);
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