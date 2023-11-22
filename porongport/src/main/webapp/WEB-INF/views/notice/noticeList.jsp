<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[포롱포트] 공지사항 게시판</title>
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
				공지사항 게시팡
			</div>
		</div>	<!-- header  -->
		
		<div class='toolbar'>
			<div class="messageBtn">
				<c:if test="${ loginUser.empAdmin eq 'A' }">
					<button class="btn btn-sm btn-primary" onclick="noticeWrite()">공지사항 작성</button>
				</c:if>
			</div>
			
	        <div class="searchTable">
				<form id="searchForm" action="searchNoticeList" method="get">
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
			공지사항 게시글 수 <span class="count" id="noticeListCount">${ pi.listCount }</span>개
			</div>
		
			<div class="tableBody">
				<table id='tb-notice' class="table table-sm table-hover shadow rounded-3">
				<thead>
					<tr class="tb-title-tr">
						<th><input type="checkbox" onclick="checkAll()"></th>
						<th></th>
						<th>No</th>
						<th>제목</th>
						<th>작성자</th>
						<th>부서</th>
						<th>작성일자</th>
						<th>첨부파일</th>
						<th>댓글</th>
						<th>조회</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
	           	<c:when test="${ empty list }">
	   	            <tr>
		            	<td colspan="10">받은 메시지가 없습니다.</td>
	                </tr>
	           	</c:when>
	           	<c:otherwise>
	           		<c:forEach var="notice" items="${ list }">
	           			<tr onclick="detailNotice()">
		                    <td><input type="checkbox" onclick="checkOnce()" value=${ notice.noticeNo }></td>
		                    <c:choose>
		                    	<c:when test="${ notice.noticeType eq 'Y' }">
			                    	<td><i class="fa-solid fa-triangle-exclamation" data-no=${ notice.noticeNo }></i></td>
		                    	</c:when>
		                    	<c:otherwise>
				                    <td>${ notice.noticeNo }</td>
		                    	</c:otherwise>
		                    </c:choose>
		                    <td>${ notice.noticeTitle }</td>
							<td>${ notice.empName } [${ notice.jobName }]</td>
							<td class="td-content">${ notice.deptName }</td>
							<td>${ notice.createDate }</td>
							<c:choose>
								<c:when test="${ not empty notice.originName }">
									<td><i class="fa-solid fa-paperclip"></i></td> <!-- 첨부파일 확인 필요 -->
								</c:when>
								<c:otherwise>
									<td>-</td>
								</c:otherwise>
							</c:choose>
							<td>${ notice.replyCount }</td>
							<td>${ notice.noticeCount }</td>
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
	                    	<li class="page-item"><a class="page-link" href="notice?page=${ pi.currentPage-1 }">&laquo;</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="searchNotice?page=${ pi.currentPage-1 }&condition=${ condition }&keyword=${ keyword }">&laquo;</a></li>
          				</c:otherwise>
                	</c:choose>
                	
                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
                    	<c:choose>
	                    	<c:when test="${ pi.currentPage eq p }">
		                    	<li class="page-item disabled"><a class="page-link" href="#">${ p }</a></li>
	                    	</c:when>
	                    	<c:when test="${ empty condition }">
	                    		<li class="page-item"><a class="page-link" href="notice?page=${ p }">${ p }</a></li>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<li class="page-item"><a class="page-link" href="searchNotice?page=${ p }&condition=${ condition }&keyword=${ keyword }">${ p }</a></li>
	                    	</c:otherwise>
                    	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.endPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
                    	</c:when>
                    	<c:when test="${ empty condition }">
                    		<li class="page-item"><a class="page-link" href="notice?page=${ pi.currentPage+1 }">&raquo;</a></li>
                    	</c:when>
                    	<c:otherwise>
		                    <li class="page-item" ><a class="page-link" href="searchNotice?page=${ pi.currentPage+1 }&condition=${ condition }&keyword=${ keyword }">&raquo;</a></li>
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
			
			let table = document.getElementById('tb-notice');
			let inputs = document.querySelectorAll('tr input');
			
			for(let input of inputs){
				input.checked = event.target.checked;
			}
		}	// checkAll
		
		// 체크박스
		function checkOnce(){
			let table = document.getElementById('tb-notice');
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
		
		
		
	
	</script>
	

</body>
</html>