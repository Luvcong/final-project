<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>입사자 등록 완료</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style>
        .outer{
            width: 400px;
            margin: auto;
        }

        #emp_mail{
            border: 1px solid #999;
        }

        .mail_header{
            background-color: #000;
        }

        .mail_header>img{
            display: block;
            width: 180px;
            height: 70px;
            margin: auto;
        }

        .mail_content{
            text-align: center;
            padding: 30px;
            line-height: 35px;
        }

    </style>
<body>
    <div class="outer">
	    <div id="emp_mail">
	        <div class="mail_header">
	            <img src="logo.png">
	        </div>
	        <div class="mail_content">
	            <h4>
	                &lt; 신규 입사자 등록 &gt;
	            </h4>
	            <p>
                    ${insertEmp.deptName}-${insertEmp.jobName}급 <br>
               		<b>${insertEmp.empName}</b>
			               님의 <br>
			               등록이 완료되었습니다.
	            </p>
	        </div>
	
	    </div>
    </div>
</body>
</html>