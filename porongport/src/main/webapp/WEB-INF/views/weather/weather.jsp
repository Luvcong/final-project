<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 날씨</title>
	<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>오늘의 날씨</h1>
	
	<script>
		$.ajax({
			url: 'weather',
			success:data=>{
				console.log(data);
			},
			error:()=>{
				console.log('실패');
			}
		})
	</script>
	
</body>
</html>