<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[포롱포트] 메시지함</title>
    <link rel="stylesheet" href="resources/css/message.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- 메시지 관련 js -->
	<!-- <script type="text/javascript" src="resources/js/message/message.js"></script>  -->
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
		<div class="header">
			<div class="h-title">
				받은 메시지 <i class="fa-regular fa-comment-dots"></i>
			</div>
		</div>	<!-- header  -->
		
		<div class='toolbar'>
			<div class="messageBtn">
				<button class="btn btn-sm btn-outline-primary" onclick="storageMessage()">보관</button>
				<button class="btn btn-sm btn-outline-primary"  onclick="deleteMessage()">삭제</button>
				<button id="readYN" class="btn btn-sm btn-outline-primary" onclick="readMessage()">읽음</button>
			</div>
			
	        <div class="searchTable">
				<form id="searchForm" action="searchReceivedMessage" method="get">
	        	<table>
	        		<tr>
	        			<td>
							<select class="select btn btn-sm btn-outline-primary dropdown-toggle" name="condition">
								<option value="userName">이름</option>
								<option value="jobName">직급</option>
								<option value="deptName">부서</option>
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
      	
		
		<div class="pp-content-message">
			<div class="selectCount">
			받은 메시지 수 <span class="message-count" id="messageListCount">${ pi.listCount }</span>개
			</div>
		
			<div class="tableBody">
				<table class="tb-message table table-sm table-hover shadow rounded-3">
				<thead>
					<tr class="tb-title-tr">
						<th><input type="checkbox" onclick="checkAll()"></th>
						<th></th>
						<th>번호</th>
						<th>발신자</th>
						<th>부서</th>
						<th>내용</th>
						<th>받은 시간</th>
						<th>읽음 여부</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
	           	<c:when test="${ empty list }">
	   	            <tr>
		            	<td colspan="8">받은 메시지가 없습니다.</td>
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
							<td>${ message.deptName }</td>
							<td class="td-content" onclick="detailMessage()">${ message.messageContent }</td>
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
			
	 		<!-- 메시지보내기  modal창 -->
			<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
			<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
		 	<div class="modal" id="messageForm">
				<form method="post" action="insertMessage" enctype="multipart/form-data">
			        <div class="modal-dialog modal-lg">
			            <div class="modal-content">
			                <!-- Modal Header -->
			                <div class="modal-header">
			                    <span class="modal-title">메시지 작성</span>
			                    <button type="button" class="close" data-dismiss="modal" style="padding-top:10px;">&times;</button>	<!-- x 닫기버튼 -->
			                </div> 
			                <!-- Modal body -->
			                <div class="modal-body">
			                <table class="table table-sm">
			                	<tr>
			                		<th>To</th>
			                		<td>
										<select class="select-user select2-container form-control form-control-sm" name="receiveUser" multiple="multiple" style="width: 100%;" >
											<c:forEach var="userList" items="${ userList }">
												<option value="${ userList.empNo }">${ userList.empName } [${ userList.jobName } / ${ userList.deptName }]</option>
											</c:forEach>
										</select>			                		
			                		</td>
			                		
			                		<!-- <td><input class="form-control form-control-sm" type="text" name="receiveUser" placeholder="받는 사람"/></td> -->
			                	</tr>
			                	<tr>
			                		<th>Message</th>
			                		<td><textarea id="messageTextarea" class="form-control form-control-sm" rows="3" name="messageContent" placeholder="메시지 내용을 입력하세요"></textarea></td>
			                	</tr>
			                	<tr>
			                		<th>From</th>
			                		<td>
			                		<input hidden type="text" name="sendUser" value="${ loginUser.empNo }" />
			                		<input class="form-control form-control-sm" type="text" placeholder="${ loginUser.empName } ${ loginUser.jobName } / ${ loginUser.deptName}" readonly/></td>
			                	</tr>
			                	<tr>
			                		<th>첨부파일</th>
			                		<td class="filebox">
				                		<input class="upload-name form-control form-control-sm" placeholder="첨부파일" readonly>
			                		    <label for="file">파일찾기</label> 
										<input type="file" id="file" name="upfile">
			                		</td>
			                	</tr>
			                	<tr>
							        <div class="writeCount">
							        	<span id="writeCnt">0</span>/<span id="writeMax">1000Byte</span>
							        </div>
			                	</tr>
			                </table>
			                </div>
			                <!-- Modal footer -->
			                <div class="modal-footer">
			             		<button type="submit" class="btn btn-sm btn-primary">전송</button>
			                    <button type="reset" class="btn btn-sm btn-secondary" data-dismiss="modal">취소</button>
			                </div>
			            </div>
			        </div>
			</form>
		  </div> 
		  
		  <script>
		  $("#file").on('change',function(){
			  var fileName = $("#file").val();
			  $(".upload-name").val(fileName);
		  });
		  </script>
			
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
	// 메시지 읽은 경우 tr 색상 변경
	// ------------------------------------------------------------------
	$(function(){
		let table = document.querySelector('.tb-message');
		let trs = table.querySelectorAll('tbody tr');
		console.log(trs);
		
		for(let tr of trs){
			if(tr.children[7].children[0].classList.contains('fa-envelope-open')){
				tr.style.color = 'darkgray';
				tr.style.fontWeight = 'normal';
			}
		}
		
		$('.select-user').select2({
			placeholder: "받는 사람",
			allowClear: true,
				language: {
		       noResults: function() {return "검색결과가 없습니다";}
		   },
		   dropdownCssClass: "text-sm"
		});
	})
	
	// ------------------------------------------------------------------
	// 메시지 읽음설정 버튼 클릭
	// ------------------------------------------------------------------
	function toggleReadBtn(inputs) {
		// 읽음 / 안읽음 상태 변경
		let read_yn_btn = document.getElementById('readYN');
		
		// 하나라도 안읽은게 있으면 true
		// 그렇지 않으면 false
		let token = true;
		for(let input of inputs){
			if(input.checked == false)
				continue;
			
			let tr   = input.parentElement.parentElement;
			let icon = tr.children[7].children[0];
			if(icon == null)
				continue;
			
			token = icon.classList.contains('fa-envelope');
			if(token)
				break;
		}
		
		read_yn_btn.innerHTML = token ? '읽음' : '안읽음';		// 클래스명에 fa-envelope가 포함되어 있는게 1개라도 있으면
	}
	
	function readMessage(){
		let table = document.querySelector('.tb-message');
		let inputs = table.querySelectorAll('tr input');
		
		let message_no_list = [];
		let icon_list = [];
		
		let read_yn_btn = document.getElementById('readYN');
		let token = read_yn_btn.textContent == '읽음';
		
		for(let input of inputs) {
			if(input.checked == false)
				continue;
			
			let tr   = input.parentElement.parentElement;
			let icon = tr.children[7].children[0];
			if(icon == null)
				continue;
			
			icon_list.push(icon);
			message_no_list.push(parseInt(input.value));
			
		}
		
		$.ajax({
				url  : 'readMessage',
				type : 'get',
				data : { 
							messageNoList : message_no_list,
					 		readYN : token		// token이 true로 넘어오면 읽음 / false인 경우 안읽음
						},
			success : function(result){
				if(!result) {
					console.log('작업 실패');
					return;
				}
				for (let icon of icon_list) {
					if(!token) {
						icon.classList.remove('fa-envelope-open');
						icon.classList.add('fa-envelope');
						
						let tr = icon.parentElement.parentElement;
						tr.style.color = '';
						tr.style.fontWeight = '';		
					} else {
						icon.classList.add('fa-envelope-open');
						icon.classList.remove('fa-envelope');
						
						let tr = icon.parentElement.parentElement;
						tr.style.color = 'darkgray';
						tr.style.fontWeight = 'normal';
					}
				}
				read_yn_btn.textContent = token ? '안읽음' : '읽음';
			},
			error : function(result){
				console.log('통신오류! 실패');
			},	// error
		});	// ajax
	}	// readMessage
	
	
		
	// ------------------------------------------------------------------
	// 메시지 작성 modal창 실행
	// ------------------------------------------------------------------
	function messageForm(){
		$('#messageForm').modal('show');
	}	// messageForm
	
	 
	// ------------------------------------------------------------------
	// 체크박스 선택 / 해제 기능
	// ------------------------------------------------------------------
	// 전체 체크박스
	function checkAll(){
		
		
		let table = document.querySelector('.tb-message');
		let inputs = table.querySelectorAll('tr input');
		
		for(let input of inputs){
			input.checked = event.target.checked;
		}
		
		toggleReadBtn(inputs);
	}	// checkAll
	
	// 체크박스
	function checkOnce(){
		
		let table = document.querySelector('.tb-message');
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
		
		toggleReadBtn(inputs);
	}	// checkOnce
	
	
	// ------------------------------------------------------------------
	// 메시지 상세보기
	// ------------------------------------------------------------------
		function detailMessage(){
		
		let content = event.currentTarget; //target.children[4];
		let input = content.parentElement.querySelector('td input');
		let message_no = input.value;
		console.log(input);
		console.log(input.value);
		
		location.href = 'detailMessage?mno=' + message_no;

		
	}	// detailMessage
		
	
	// ------------------------------------------------------------------
	// 메시지 삭제 ajax
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
				
					let table = document.querySelector('.tb-message');			
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
				
					let table = document.querySelector('.tb-message');			
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
				url : 'storageMessage',
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
		event.stopPropagation();
		
		let target = event.currentTarget;
		let message_no = target.getAttribute('data-no');
		let bookmark_yn = target.classList.contains('fa-solid');
		
		let abc = '';
		let abc2 = '';
					
		$.ajax({
				url  : 'bookmarkMsg',
				type : 'get',
				data : {
					message_no : message_no,
					bookmark_yn : bookmark_yn
		 		},
				success : function(result){
				
				target.classList.remove(result ? 'fa-regular' : 'fa-solid');
				target.classList.add(result ? 'fa-solid' : 'fa-regular');
				
			},	// success
			
			
			
			error : function(result){
				console.log('통신오류! 실패');
			},	// error
		});	// ajax
	}	// bookmark_msg
	
	
	// ------------------------------------------------------------------
	// 받은메시지로 이동 기능 ajax
	// ------------------------------------------------------------------
	function moveMessageBox(){
		
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
				Swal.fire('실패', '이동할 메시지를 선택해주세요!', 'warning');
				return;
			}
		
		Swal.fire({
			title: "메시지를 이동하시겠습니까?",
			text : "※ 선택한 메시지는 받은 메시지함으로 이동합니다.",
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: "삭제",
			cancelButtonText: "취소"
			}).then((result) => {
				if (!result.isConfirmed) {
				  return;
				}
				
					let table = document.querySelector('.tb-message');			
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
				url : 'moveMessageBox',
			type : 'get',
			data : { message_list : message_list },
			dataType: 'json',
			success : function(result){
				
				Swal.fire('성공', '메시지가 보관함으로 이동되었습니다!', 'success');
				
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
				Swal.fire('실패', '메시지함으로 이동되지 않았습니다<br>다시 시도해주세요', 'warning');
				console.log('통신오류! 실패');
			},	// error
		});	// ajax
		});		// confrim	 
	}	// moveMessageBox

// ------------------------------------------------------------------
// 받은메시지로 복구 기능 ajax
// ------------------------------------------------------------------
	function moveMessageBox(){
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
				Swal.fire('실패', '이동할 메시지를 선택해주세요!', 'warning');
				return;
			}
			
			Swal.fire({
			title: "메시지를 복구하시겠습니까?",
			text : "※ 선택한 메시지는 받은 메시지함으로 이동합니다.",
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: "삭제",
			cancelButtonText: "취소"
			}).then((result) => {
				if (!result.isConfirmed) {
				  return;
				}
				
					let table = document.querySelector('.tb-message');			
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
				url : 'moveMessageBox',
			type : 'get',
			data : { message_list : message_list },
			dataType: 'json',
			success : function(result){
				
				Swal.fire('성공', '메시지가 보관함으로 이동되었습니다!', 'success');
				
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
				Swal.fire('실패', '메시지함으로 이동되지 않았습니다<br>다시 시도해주세요', 'warning');
				console.log('통신오류! 실패');
			},	// error
		});	// ajax
		});		// confrim	 
	}	// moveMessageBox

	
	// ------------------------------------------------------------------
	// 메시지 영구삭제 기능 ajax
	// ------------------------------------------------------------------
	function deletePermanentlyMessage(){
		
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
				Swal.fire('실패', '삭제할 메시지를 선택해주세요!', 'warning');
				return;
			}
			
			Swal.fire({
			title: "메시지를 삭제하시겠습니까?",
			text : "※ 영구 삭제한 메시지는 복구가 불가능합니다!",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: "삭제",
			cancelButtonText: "취소"
			}).then((result) => {
				if (!result.isConfirmed) {
				  return;
				}
				
					let table = document.querySelector('.tb-message');			
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
				url : 'deletePermanentlyMessage',
			type : 'get',
			data : { message_list : message_list },
			dataType: 'json',
			success : function(result){
				
				Swal.fire('성공', '메시지가 영구 삭제되었습니다!', 'success');
				
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
				Swal.fire('실패', '메시지가 삭제되지 않았습니다<br>다시 시도해주세요', 'warning');
				console.log('통신오류! 실패');
			},	// error
		});	// ajax
		});		// confrim	 
	}	// permanentDelete
	</script>
		
 	<c:choose>
 		<c:when test="${ not empty successMsg }">
 			<script>
	 			Swal.fire('성공', '${ successMsg }', 'success');
 			</script>
 		</c:when>
 		<c:when test="${ not empty failMsg }">
 			<script>
 			Swal.fire('실패', '${ failMsg }', 'error');
 			</script>
 		</c:when>
 	</c:choose>
 	
 	<c:remove var="successMsg" />
 	<c:remove var="failMsg" />

</body>
</html>