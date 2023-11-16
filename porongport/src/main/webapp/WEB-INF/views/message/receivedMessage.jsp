<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[포롱포트] 메시지함</title>
    <!-- 메인화면 css-->
    <link rel="stylesheet" href="resources/css/message.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
		<div class="header">
			<div class="h-title">
				메시지
			</div>
		</div>	<!-- header  -->
		
<<<<<<< Updated upstream
		<form id="searchForm" action="receivedMessage" method="post">
=======
		<form id="searchForm" action="searchReceivedMessage" method="post">
		
>>>>>>> Stashed changes
        <div class="searchTable">
	      	<table id="check-table">
	      		<tr>
		            <td>
	     			    <select class="select btn btn-sm btn-outline-primary dropdown-toggle" name="condition">
							<option value="userName">이름</option>
							<option value="userCode">직급</option>
							<option value="messageContent">내용</option>
						</select>
	     			</td>
	      			<td>
	      				<input class="form-control form-control-sm" name="keyword" type="text" placeholder="검색어를 입력하세요" size="30" value="${ keyword }">
	   				</td>
					<td>
<<<<<<< Updated upstream
	      				<button type="submit" class="btn btn-sm btn-warning">검색</button>
=======
	      				<button type="submit" class="btn btn-sm btn-outline-primary" >검색</button>
>>>>>>> Stashed changes
	   				</td>
	      		</tr>
	      	</table>
      	</div>	<!-- searchTable  -->
		<div class="receivedBtn">
<<<<<<< Updated upstream
			<button onclick="storeMessage()">보관</button>
			<button>삭제</button>
		</div>
		</form>	<!-- searchForm  -->
		
		<div class="pp-content-message">
		<span>총 ${ pi.listCount }개</span>
=======
			<button class="btn btn-sm btn-outline-primary" onclick="storeMessage()">보관</button>
			<button class="btn btn-sm btn-outline-primary"  onclick="deleteMessage()">삭제</button>
		</div>
		
		
		
		
<%--  		<form action="" method="post" id="postForm">
			<input type="hidden" name="messageNo" value="${ message.messagedNo }">
		</form>
		
		<script>
				function postFormSubmit(num){
					if(num == 0){
						// 보관하기 클릭시
						$('#postForm').attr('action', 'storeMessageBox').submit();
					} else {
						// 삭제하기 클릭시
						$('#postForm').attr('action', 'deleteMessageBox').submit();
					}
				}
			</script> --%>
		
		<div class="pp-content-message">
		<div class="selectCount">
			받은 메시지 수 <span class="count" id="messageListCount">${ pi.listCount }</span>개
		</div>
>>>>>>> Stashed changes
		
			<div class="tableBody">
				<table id='tb-received' class="table table-sm table-hover shadow rounded-3">
				<thead>
<<<<<<< Updated upstream
					<tr>
						<th><input type="checkbox" onclick="checkAll()"/></th>
						<th style="display: ">번호</th>
						<th>읽음 여부</th>
=======
					<tr class="tb-title-tr">
						<th><input type="checkbox" onclick="checkAll()"></th>
						<th>번호</th>
>>>>>>> Stashed changes
						<th>발신자</th>
						<th>내용</th>
						<th>받은 시간</th>
						<th>읽음 여부</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
	           	<c:when test="${ empty list }">
	   	            <tr>
		            	<td colspan="5">받은 메시지가 없습니다.</td>
	                </tr>
	           	</c:when>
	           	<c:otherwise>
	           		<c:forEach var="message" items="${ list }">
	           			<tr>
<<<<<<< Updated upstream
		                    <td><input type="checkbox" onclick="checkOnce()"></td>
		                    <td style="display: ">${ message.messageNo }</td>
		                    <td><i class="fa-solid fa-envelope"></i></td>
							<td>${ message.empName } ${ message.jobName }</td>
=======
		                    <td><input type="checkbox" onclick="checkOnce()" value="${ message.messageNo }"></td>
		                    <td>${ message.messageRank }</td>
							<td>${ message.empName } [${ message.jobName }]</td>
>>>>>>> Stashed changes
							<td>${ message.messageContent }</td>
							<td>${ message.createDate }</td>
		                    <td><i class="fa-solid fa-envelope"></i></td>
						</tr>
	           		</c:forEach>
	           	</c:otherwise>
				</c:choose>
				</tbody>
				</table>
			</div>	<!-- tableBody  -->
<<<<<<< Updated upstream
		</div>	<!-- pp-content-message  -->
	</div>	<!-- pp-content  -->
	
=======
			
			<div id="pagingArea">
                <ul class="pagination justify-content-center">
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
	                    	<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
                		</c:when>
                		<c:when test="${ empty condition }">
	                    	<li class="page-item"><a class="page-link" href="receivedMessage?page=${ pi.currentPage-1 }">&laquo;</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="receivedMessage?page=${ pi.currentPage-1 }&condition=${ condition }&keyword=${ keyword }">&laquo;</a></li>
          				</c:otherwise>
                	</c:choose>
                	
                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
                    	<c:choose>
	                    	<c:when test="${ pi.currentPage eq p }">
		                    	<li class="page-item disabled"><a class="page-link" href="#">${ p }</a></li>
	                    	</c:when>
	                    	<c:when test="${ empty condition }">
	                    		<li class="page-item"><a class="page-link" href="receivedMessage?page=${ p }">${ p }</a></li>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<li class="page-item"><a class="page-link" href="receivedMessage?page=${ p }&condition=${ condition }&keyword=${ keyword }">${ p }</a></li>
	                    	</c:otherwise>
                    	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.endPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
                    	</c:when>
                    	<c:when test="${ empty condition }">
                    		<li class="page-item"><a class="page-link" href="receivedMessage?page=${ pi.currentPage+1 }">&raquo;</a></li>
                    	</c:when>
                    	<c:otherwise>
		                    <li class="page-item" ><a class="page-link" href="receivedMessage?page=${ pi.currentPage+1 }&condition=${ condition }&keyword=${ keyword }">&raquo;</a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
            </div>

		</div>	<!-- pp-content-message  -->
	</div>	<!-- pp-content  -->
	
	
>>>>>>> Stashed changes
	<c:if test="${ not empty condition }">
		<script>
		$(() => {
			$('.select option[value=${condition}]').attr('selected', true);
		});
		</script>
	</c:if>
	
	<script>
	
		function checkAll(){
			let table = document.getElementById('tb-received');
			let inputs = document.querySelectorAll('tr input');
			
			for(let input of inputs){
				input.checked = event.target.checked;
			}
		}	// checkAll
	
		function checkOnce(){
			
			let table = document.getElementById('tb-received');
			let hd_input = table.querySelector('th').querySelector('input');
			let inputs = table.querySelector('tbody').querySelectorAll('tr input');
			
			let is_all_checked = true;
			for(let input of inputs){
				if(input.checked == false){
					is_all_checked = false;
					break;
				}
				}
			hd_input.checked = is_all_checked;
		}	// checkOnce
			
	
		function storeMessage(){
			
			let trs = document.querySelectorAll('.table tr');
			let checked_tr = null;
			
			for(let tr of trs){
				let input = tr.querySelector('input');
				if(input.checked){
					checked_tr = tr;
					break;
				}
			}
			
			if(checked_tr == null){
				Swal.fire('실패', '보관할 메시지를 선택해주세요!', 'warning');
				return;
			}
			
			
			
			
			
			
			
		}	// storeMessage
	
	</script>
	

</body>
</html>