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
				보낸 메시지
			</div>
		</div>	<!-- header  -->
		
		<div class='toolbar'>
			<div class="messageBtn">
				<button class="btn btn-sm btn-outline-primary" onclick="storageMessage()">보관</button>
				<button class="btn btn-sm btn-outline-primary"  onclick="deleteMessage()">삭제</button>
				<button class="btn btn-sm btn-outline-primary">읽음설정</button>
			</div>
			
	        <div class="searchTable">
				<form id="searchForm" action="searchReceivedMessage" method="get">
	        	<table>
	        		<tr>
	        			<td>
							<select class="select btn btn-sm btn-outline-primary dropdown-toggle" name="condition">
								<option value="userName">이름</option>
								<option value="jobName">직급</option>
								<option value="messageContent">내용</option>
							</select>
	        			</td>
	        			<td>
							<input class="form-control form-control-sm" name="keyword" type="text" placeholder="검색어를 입력하세요" size="30" value="${ keyword }">
	        			</td>
	        			<td>
							<button type="submit" class="btn btn-sm btn-outline-primary" >검색</button>
	        			</td>
	        		</tr>
	        	</table>
				</form>	<!-- searchForm  -->
			</div>	<!-- searchTable  -->
      	</div>	<!-- toolbar  -->
      	
<%--  		<form action="" method="post" id="postForm">
			<input type="hidden" name="messageNo" value="${ message.messagedNo }">
		</form>
		
		<script>
				function postFormSubmit(num){
					if(num == 0){
						// 보관하기 클릭시
						$('#postForm').attr('action', 'storageMessage').submit();
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
		
			<div class="tableBody">
				<table id='tb-received' class="table table-sm table-hover shadow rounded-3">
				<thead>
					<tr class="tb-title-tr">
						<th><input type="checkbox" onclick="checkAll()"></th>
						<th></th>
						<th>번호</th>
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
		            	<td colspan="7">받은 메시지가 없습니다.</td>
	                </tr>
	           	</c:when>
	           	<c:otherwise>
	           		<c:forEach var="message" items="${ list }">
	           			<tr>
		                    <td><input type="checkbox" onclick="checkOnce()" value=${ message.messageNo }></td>
		                    <c:choose>
		                    	<c:when test="${ message.bookmarkYN eq 'N' }">
			                    	<td><i onclick="bookmark_msg()" class="fa-regular fa-star td-fa-star" data-no=${ message.messageNo }></i></td>
		                    	</c:when>
		                    	<c:otherwise>
				                    <td><i  onclick="bookmark_msg()" class="fa-solid fa-star td-fa-star" data-no=${ message.messageNo }></i></td>
		                    	</c:otherwise>
		                    </c:choose>
		                    <td>${ message.messageRank }</td>
							<td>${ message.empName } [${ message.jobName }]</td>
							<td>${ message.messageContent }</td>
							<td>${ message.createDate }</td>
							<c:choose>
								<c:when test="${ message.readYN eq 'N' }">
									<td><i class="fa-solid fa-envelope td-fa-envelope"></i></td>
								</c:when>
								<c:otherwise>
				                    <td><i class="fa-solid fa-envelope-open td-fa-envelope"></i></td>
								</c:otherwise>
							</c:choose>
						</tr>
	           		</c:forEach>
	           	</c:otherwise>
				</c:choose>
				</tbody>
				</table>
			</div>	<!-- tableBody  -->
			
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
                			<li class="page-item"><a class="page-link" href="searchReceivedMessage?page=${ pi.currentPage-1 }&condition=${ condition }&keyword=${ keyword }">&laquo;</a></li>
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
	                    		<li class="page-item"><a class="page-link" href="searchReceivedMessage?page=${ p }&condition=${ condition }&keyword=${ keyword }">${ p }</a></li>
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
		                    <li class="page-item" ><a class="page-link" href="searchReceivedMessage?page=${ pi.currentPage+1 }&condition=${ condition }&keyword=${ keyword }">&raquo;</a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
            </div>

		</div>	<!-- pp-content-message  -->
	</div>	<!-- pp-content  -->
	
	
	<c:if test="${ not empty condition }">
		<script>
		$(() => {
			$('.select option[value=${condition}]').attr('selected', true);
		});
		</script>
	</c:if>
	
	<script>
		// ------------------------------------------------------------------
		// 체크박스 선택 / 해제 기능
		// ------------------------------------------------------------------
		// 전체 체크박스
		function checkAll(){
			
			let table = document.getElementById('tb-received');
			let inputs = document.querySelectorAll('tr input');
			
			for(let input of inputs){
				input.checked = event.target.checked;
			}
		}	// checkAll
		
		// 체크박스
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
			
		
		// ------------------------------------------------------------------
		// 쪽지 삭제 ajax
		// ------------------------------------------------------------------
		function deleteMessage(){

			
			// 모든 테이블의 tr행 가져오기
			let trs = document.querySelectorAll('.table tr');
			// 체크확인용 변수 선언
			let checked_tr = null;
			
			// 체크된 input요소 확인 후 체크가 되어있다면 체크확인용 변수에 담고 break
 			for(let tr of trs){
				let input = tr.querySelector('input');
				if(input.checked){
					checked_tr = tr;
					break;
				}
			}
			
			// 체크되어 있는 메시지가 없을 경우 alert창 발생
  			if(checked_tr == null){
  				Swal.fire('실패', '삭제할 메시지를 선택해주세요!', 'warning');
  				return;
  			}
			
  			// 체크가 되어있는 경우 confirm창 발생
			Swal.fire({
				title: "메시지를 삭제하시겠습니까?",
				text : "※ 삭제된 메시지는 휴지통으로 이동합니다. ",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: "#DD6B55",
				confirmButtonText: "삭제",
				cancelButtonText: "취소"
				}).then((result) => {
					if (!result.isConfirmed) {
					  return;
					}
					
  					let table = document.getElementById('tb-received');			
					let trs = table.querySelectorAll('tbody tr');		// 데이터 행 부분
					let message_del_list = [];
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						if(input.checked == true){
							let messageNo = input.value;
							console.log(messageNo);
							message_del_list.push(messageNo);
						}
					}
					console.log(message_del_list);
					
 			$.ajax({
 				url : 'deleteMessage',
				type : 'get',
				data : { messageNoList : message_del_list },
				dataType: 'json',
				success : function(result){
					
					Swal.fire('성공', '메시지가 휴지통으로 이동되었습니다!', 'success');
					
 					let listCount = document.getElementById('messageListCount');
 					let total = parseInt(listCount.textContent);
 					// console.log(listCount);
					// console.log(total);
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						let messageNo = parseInt(input.value);
						// console.log(messageNo);
						
						if(result.includes(messageNo)){
							tr.remove();
							total--;
							// console.log(total);				// 전체 조회수에서 -- count되는지 확인ok
							
							listCount.textContent = total;	// remove total 값 넣어주기
						}
					}
				},	// success
				error : function(result){
					Swal.fire('실패', '휴지통으로 이동되지 않았습니다<br>다시 시도해주세요', 'warning');
					console.log('통신오류! 실패');
				},	// error
			});	// ajax
			});		// confrim	 
		}	// deleteMessage
		
		
		// ------------------------------------------------------------------
		// 메시지 보관 ajax
		// ------------------------------------------------------------------
		function storageMessage(){
			
			// 모든 테이블의 tr행 가져오기
			let trs = document.querySelectorAll('.table tr');
			// 체크확인용 변수 선언
			let checked_tr = null;
			
			// 체크된 input요소 확인 후 체크가 되어있다면 체크확인용 변수에 담고 break
 			for(let tr of trs){
				let input = tr.querySelector('input');
				if(input.checked){
					checked_tr = tr;
					break;
				}
			}
			
			// 체크되어 있는 메시지가 없을 경우 alert창 발생
  			if(checked_tr == null){
  				Swal.fire('실패', '보관 메시지를 선택해주세요!', 'warning');
  				return;
  			}
			
  			// 체크가 되어있는 경우 confirm창 발생
			Swal.fire({
				title: "메시지를 보관하시겠습니까?",
				text : "※ 받은 메시지 보관함으로 이동합니다.",
				icon: 'question',
				showCancelButton: true,
				confirmButtonColor: "#DD6B55",
				confirmButtonText: "보관",
				cancelButtonText: "취소"
				}).then((result) => {
					if (!result.isConfirmed) {
					  return;
					}
					
  					let table = document.getElementById('tb-received');			
					let trs = table.querySelectorAll('tbody tr');		// 데이터 행 부분
					let message_list = [];
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						if(input.checked == true){
							let messageNo = input.value;
							console.log(messageNo);
							message_list.push(messageNo);
						}
					}
					console.log(message_list);
					
 			$.ajax({
 				url : 'receivedStorageMessage',
				type : 'get',
				data : { messageList : message_list },
				dataType: 'json',
				success : function(result){
					
					Swal.fire('성공', '메시지가 보관함으로 이동되었습니다!', 'success');
					
 					let listCount = document.getElementById('messageListCount');
 					let total = parseInt(listCount.textContent);
 					console.log(listCount);
					console.log(total);
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						let messageNo = parseInt(input.value);
						console.log(messageNo);
						
						if(result.includes(messageNo)){
							tr.remove();
							total--;
							console.log(total);				// 전체 조회수에서 -- count되는지 확인ok
							
							listCount.textContent = total;	// remove total 값 넣어주기
						}
					}
				},	// success
				error : function(result){
					Swal.fire('실패', '보관함으로 이동되지 않았습니다<br>다시 시도해주세요', 'warning');
					console.log('통신오류! 실패');
				},	// error
			});	// ajax
			});		// confrim
		}	// storageMessage
		
		
		// ------------------------------------------------------------------
		// 메시지 북마크 ajax
		// ------------------------------------------------------------------
		function bookmark_msg(){
			
			let target = event.currentTarget;
			let message_no = target.getAttribute('data-no');
			let bookmark_YN = target.classList.contains('fa-solid');	// true or false
			console.log(bookmark_YN);
						
			$.ajax({
 				url : 'bookmarkMsg',
				type : 'get',
				data : { messageNo : message_no,
						bookmarkYN : bookmark_YN
						 },
				success : function(result){
					
					if(result){
						target.classList.remove('fa-regular');	// 빈 별
						target.classList.add('fa-solid');		// 색칠 별
					} else {
						target.classList.remove('fa-solid');
						target.classList.add('fa-regular');
					}
					
					// console.log(target);	
				},	// success
				error : function(result){
					console.log('통신오류! 실패');
				},	// error
			});	// ajax
		}	// bookmark_msg
		
		
	
	</script>
	

</body>
</html>