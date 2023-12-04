<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[포롱포트] 공지사항 게시판</title>

	<link rel="stylesheet" href="resources/css/notice.css">
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
				공지사항 게시판 <i class="fa-regular fa-newspaper"></i>
			</div>
		</div>	<!-- header  -->
		
		<div class='toolbar'>
			<div class="noticeBtn">
				<c:if test="${ loginUser.empAdmin eq 'A' }">
					<button class="btn btn-sm btn-primary" onclick="noticeWriteForm()">공지사항 작성</button>
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
		
		<div class="pp-content-notice">
			<div class="selectCount">
			공지사항 게시글 수 <span class="notice-count" id="noticeListCount">${ pi.listCount }</span>개
			</div>
		
			<div class="tableBody">
				<table id='tb-notice' class="table table-sm table-hover shadow rounded-3">
				<thead>
					<tr class="tb-title-tr">
						<th><input class="checkbox" type="checkbox" onclick="checkAll()"></th>
						<th>No</th>
						<th>작성자</th>
						<th>부서</th>
						<th>제목</th>
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
		            	<td colspan="10">공지 게시글이 없습니다.</td>
	                </tr>
	           	</c:when>
	           	<c:otherwise>
	           		<c:forEach var="notice" items="${ list }">
	           			<tr onclick="detailNotice()">
		                    <td><input class="checkbox" type="checkbox" onclick="checkOnce()" value=${ notice.noticeNo }></td>
		                    <c:choose>
		                    	<c:when test="${ notice.noticeType eq 'Y' }">
			                    	<td><i class="fa-solid fa-triangle-exclamation" style="color: #E35F21;" data-no=${ notice.noticeNo }></i></td>
		                    	</c:when>
		                    	<c:otherwise>
				                    <td>${ notice.noticeNo }</td>
		                    	</c:otherwise>
		                    </c:choose>
							<td>${ notice.empList[0].empName } [${ notice.empList[0].jobName }]</td>
							<td>${ notice.empList[0].deptName }</td>
		                    <td>${ notice.noticeTitle }</td>
							<td>${ notice.createDate }</td>
							<c:choose>
								<c:when test="${ notice.attCount > 0 }">
									<td><i class="fa-solid fa-paperclip"></i></td>
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
	                    	<li class="page-item"><a class="page-link" href="noticeList?page=${ pi.currentPage-1 }">&laquo;</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="searchNoticeList?page=${ pi.currentPage-1 }&condition=${ condition }&keyword=${ keyword }">&laquo;</a></li>
          				</c:otherwise>
                	</c:choose>
                	
                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
                    	<c:choose>
	                    	<c:when test="${ pi.currentPage eq p }">
		                    	<li class="page-item disabled"><a class="page-link" href="#">${ p }</a></li>
	                    	</c:when>
	                    	<c:when test="${ empty condition }">
	                    		<li class="page-item"><a class="page-link" href="noticeList?page=${ p }">${ p }</a></li>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<li class="page-item"><a class="page-link" href="searchNoticeList?page=${ p }&condition=${ condition }&keyword=${ keyword }">${ p }</a></li>
	                    	</c:otherwise>
                    	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.endPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
                    	</c:when>
                    	<c:when test="${ empty condition }">
                    		<li class="page-item"><a class="page-link" href="noticeList?page=${ pi.currentPage+1 }">&raquo;</a></li>
                    	</c:when>
                    	<c:otherwise>
		                    <li class="page-item" ><a class="page-link" href="searchNoticeList?page=${ pi.currentPage+1 }&condition=${ condition }&keyword=${ keyword }">&raquo;</a></li>
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
			event.stopPropagation();
			
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
		
		// ------------------------------------------------------------------
		// 공지사항 글 작성하기
		// ------------------------------------------------------------------
		
		function noticeWriteForm(){
			
			// target.addEventListener('click', function(){
				location.href = 'noticeWriteForm';
			// })
		}
		
 		function detailNotice(){
			
			let target = event.currentTarget;
			let input = target.querySelector('td input');
			let notice_no = input.value;
			console.log(input);
			console.log(input.value);
			
			location.href = 'detailNotice?nno=' + notice_no;
 		}
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