<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제진행함</title>
 <meta charset="UTF-8">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .content {
            background-color:rgb(247, 245, 245);
            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        #noticeList {text-align:center;}
        #noticeList>tbody>tr:hover {cursor:pointer;}

        #pagingArea {width:fit-content; margin:auto;}
        
        #searchForm {
            width:80%;
            margin:auto;
        }
        #searchForm>* {
            float:left;
            margin:5px;
        }
        .select {width:20%;}
        .text {width:53%;}
        .searchBtn {width:20%;}
    </style>
</head>
<body>

    
    <jsp:include page="../common/sidebar.jsp" />

    <div class="pp-content">
        <br><br>
        <div class="innerOuter" style="padding:5% 10%;">
            <h2>결제진행함</h2>
            <br>
            <br>
            <br>
            <table id="noticeList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>문서번호</th>
                        <th>제목</th>
                        <th>결재상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="n">
                    	<tr>
                    		<td class="nno">${n.noticeNo}</td>
                    		<td>${n.noticeTitle}</td>
                    		<td>${n.noticeWriter}</td>
                    		<td>${n.createDate}</td>
                    	</tr>
                    </c:forEach>
                </tbody>
            </table>
            <br><br>
			
			<script>
            	$(function(){
                	$('#noticeList>tbody>tr').click(function(){
                    	location.href="detail.no?nno="+$(this).children('.nno').text();
                	});
               })
            </script>
			
            <div id="pagingArea">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${pi.currentPage eq 1 }">
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="list.no?cPage=${pi.currentPage-1}">Previous</a></li>
                    	</c:otherwise>
                    </c:choose>
                    <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var ="p">
                    	<li class="page-item"><a class="page-link" href="list.no?cPage=${p}">${p}</a></li>
                    </c:forEach>
                    <c:choose>
                    	<c:when test="${pi.endPage eq pi.maxPage}">
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="list.no?cPage=${pi.currentPage+11}">Next</a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
            </div>

            
        </div>
        <br><br>

    </div>


</body>
</html>