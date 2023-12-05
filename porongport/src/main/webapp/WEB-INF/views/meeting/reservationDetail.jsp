<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Document</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

 <style> 
        .content {
            background-color:rgb(247, 245, 245);
            width:80%;
            margin-top:0px;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        table * {margin:5px;}
        table {width:100%;}
        th{width:120px;}
        th,td{ 
        border-bottom: 1px solid lightgray;
        padding: 10px;
        }
    </style>
</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />
	    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>예약신청 상세보기</h2>
            <br>

            <a class="btn btn-secondary" style="float:right;" href="/porong/reservationStatus">목록으로</a>
            <br><br>
            	
            
            <table>
            
            	<tr>
            		<th>회의제목</th>
            		<td>${mr.meetTitle}</td>
            		<th>회의 장소</th>
            		<td>회의실</td>
            	</tr>
            	<hr>
            	<tr>
            		<th>회의 시간</th>
            		<td colspan="3">${mr.meetStart}  ~  ${mr.meetEnd}</td>
            	</tr>
            	<tr>
            		<th>인원</th>
            		<td colspan="3">${mr.meetPnum}</td>
            	</tr>
            	<tr>
            		<th colspan="4">회의 내용</th>
            	</tr>
            	    <tr>
                    <td colspan="4"><p style="height:300px;">${mr.meetContent}</p></td>
                </tr>
            </table>
            
            <div class="float-right">
            <a class="btn btn-primary" onclick="postFormSubmit(0);" >승인</a>
                <a class="btn btn-danger" onclick="postFormSubmit(1);" >반려</a>
            </div>
            
             <form action="" method="post" id="postForm">
            	<input type="hidden" name="mno" value="${mr.meetNo}">
            	
            </form>
            
             <script>
            	function postFormSubmit(num){
            		if( num ==0){
            			$('#postForm').attr('action','updateForm').submit();//승인 클릭시
            		}else{
            			$('#postForm').attr('action','notupdateForm').submit();// 반려 클릭시 
            		}
            	}
            </script>

		</div><!-- 모달 footer -->
		
            </div>
		
		
</body>
</html>