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
    <!-- css-->
   <link rel="stylesheet" href="resources/css/approval.css">
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
		<table border="1">
			<div class="icon">
				<th><i class="fa-sharp fa-solid fa-house fa-3x" style="color: #e35f21;"></i></th>
				<th><a href="../porong/main" style="font-size:25px" class="app_home">HOME</a> > <a href="../porong/approval" style="font-size:40px" class="app_sp">전자결재</a></th>
			</div>
		</table>
		<br><br><br><br><br><br><br><br><br>
		<table border="1">
			<div style="border:1px solid; padding:100px 10px 100px 550px; magin: 100px;">
				<div class="icon">
					<i class="fa-sharp fa-regular fa-clipboard fa-8x app_col app_mar" ><a href="../porong/vacation"><h5 class="app_vct">휴가신청서</h5></a></i>
					<i class="fa-sharp fa-regular fa-clipboard fa-8x app_col app_mar"><a href="../porong/expense"><h5 class="app_vct">지출결의서</h5></a></i>
					<i class="fa-sharp fa-regular fa-clipboard fa-8x app_col app_mar"><a href="../porong/department"><h5 class="app_vct">인사발령서</h5></a></i>
					<i class="fa-sharp fa-regular fa-clipboard fa-8x app_col app_mar"><a href="../porong/test"><h5 class="app_vct">test</h5></a></i>
				</div>
			</div>
		</table>
	</div>

</body>
</html>