<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자결재</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- font-awesome (icon) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
		<table border="1">
			<div class="icon">
				<th><i class="fa-sharp fa-solid fa-house fa-3x" style="color: #e35f21;"></i></th>
				<th><a href="../porong" style="font-size:25px">HOME</a> > <a href="../porong/approval" style="font-size:40px">전자결재</a></th>
			</div>
		</table>
		<table border="1">
			<div style="border:1px solid; padding:100px 100px 100px 100px;">
				<div class="icon">
					<i class="fa-sharp fa-regular fa-clipboard fa-8x" style="color: #000000;"></i>
					<i class="fa-sharp fa-regular fa-clipboard fa-8x" style="color: #000000;"></i>
					<i class="fa-sharp fa-regular fa-clipboard fa-8x" style="color: #000000;"></i>
					<i class="fa-sharp fa-regular fa-clipboard fa-8x" style="color: #000000;"></i>
				</div>
			</div>
		</table>
	</div>

</body>
</html>