<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사발령_부서</title>
	<!-- 부트스트립트 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- font-awesome (icon) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- css-->
   <link rel="stylesheet" href="resources/css/vacation.css">
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
	<div id="button" class="btn-right">
            <button type="button" class="btn btn-sm btn-secondary">결재</button>
            &nbsp;&nbsp;&nbsp;
            <button class="btn-modal btn btn-sm btn-secondary" data-toggle="modal" data-target="#myModal">결재라인</button>
        	&nbsp;&nbsp;&nbsp;
        	<a href="${path}/porong/document1" class="btn btn-sm btn-secondary">취소</a>
        	&nbsp;&nbsp;&nbsp;
		</div>
		<br>
		
    <div class="vacationTable">
	    <form action="${path}/approval/leaveApplication" method="post" id="pesonalDepartmentForm">
		<div>
			<div class="vct_file">인 사 발 령 서</div>
				<div class="blank"></div>
				<table class="table-bordered">
					<tr>
	                    <th class="vacation-th-size">성 명</th>
	                    <th class="vacation-th-size">입 사 일</th>
						<th class="department-size">부 서</th>
	                    <th class="vacation-th-size">직 급</th>
						<tr></tr>
	                    <td><input type="text"  value="${loginUser.empName}"></td>
						<td><input type="text"  value="${loginUser.deptName}"></td>
	                    <td><input type="text"  value="${loginUser.jobName}"></td>
	                    <td><input type="text"  ></td>
	                </tr>
				</table>
	</div>
</body>
</html>