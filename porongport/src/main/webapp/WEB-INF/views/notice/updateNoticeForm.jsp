<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>[포롱포트] 공지사항 수정</title>

<link rel="stylesheet" href="resources/css/notice.css">
<!-- ckeditor5 -->
<script src="https://cdn.ckeditor.com/ckeditor5/31.1.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>

   
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	  rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<!-- sweetalert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
</head>
<body>
   	<jsp:include page="../common/sidebar.jsp" />
	
	
	<div class="pp-content">
		<div class="header">
			<div class="h-title">
				공지사항 수정
			</div>
	</div>	<!-- header  -->
    
    <form action="updateNotice" method="post" enctype="multipart/form-data">
	    <input type="hidden" name="changeFileName" value="${ at.filePath }/${ at.changeFileName }">
	    <input type="hidden" name="noticeNo" value="${ list.noticeNo }">
	    <table id="tb-notice-form" class="table table-sm">
	   		<tr>
	   			<th>제목</th>
	   			<td><input class="form-control form-control-sm" name="noticeTitle" required value="${ list.noticeTitle }"></td>
	   			<td >
	   			<div class="form-check form-switch notice-check">
				  <label>
				  <input class="form-check-input" type="checkbox" name="noticeTypeTmp" checked="${ list.noticeType }">
				  <input type="hidden" name="noticeType"/>
				  중요공지 설정
				  </label>
				</div>
	   			</td>
	   		</tr>
	   		<tr>
	   			<th>첨부파일</th>
	   			<td><input type="file" name="reUpMultiFile" multiple></td>
	   		</tr>
	   		<tr>
	   			<th>기존파일</th>
	   			<td>
					<c:forEach var="at" items="${ attachList }">
	   				<c:choose>
	   					<c:when test="${ empty at.originFileName }">
	   						<input class="form-control form-control-sm detail-input" readonly placeholder="기존 첨부파일이 존재하지 않습니다.">
	      				</c:when>
	      				<c:otherwise>
	      				<div>
	      					<i class="fa-solid fa-circle-minus" onclick="deleteFile(${ at.noticeFileNo })"></i>
			      		    <a class="detail-input upload-name" 
			      			   href="${ at.filePath }/${ at.changeFileName }" download="${ at.originFileName }">
			      				<i class="fa-regular fa-floppy-disk"></i> ${ at.originFileName }
		      			    </a>
	      				</div>
		      			   
	      				</c:otherwise>
	      			</c:choose>
   				</c:forEach>
	   			</td>
	   		</tr>
	   		<tr>
	   			<th>내용</th>
	   			<td>
		   			<div>
		   				<textarea id="editor" name="noticeContent" required>${ list.noticeContent }</textarea>
		   			</div>
	   			</td>
	   		</tr>
	   	</table>
				    	
		<div id="btnDiv">
		    <button type="submit" class="btn btn-sm btn-primary" onclick="updateNotice()">수정하기</button>
		    <button type="button" class="btn btn-sm btn-outline-primary" onclick="location.href='${path}/noticeList'">목록으로</button>
		</div>
    </form>

	</div>
	    


	<script>
	
		let editor;
 	    ClassicEditor.create(document.getElementById('editor'),
   		{	
	    	// 한국어 설정
    		language: "ko",
    		// 파일 업로드 어댑터 설정
    		ckfinder: {
                uploadUrl: 'fileUpload'
            }
	    })
        .then( newEditor => {
        	editor = newEditor;
   	 	})
	    .catch((error) => {
	        console.error( error );
	    });
 	    
 	    
 		// ------------------------------------------------------------------
 		// 공지사항 게시글 수정
 		// ------------------------------------------------------------------
 		function updateNotice(){
			let content = document.getElementById('editor'); 
			content.value = editor.getData();
 		   
			let table = document.getElementById('tb-notice-form');
			let is_checked = table.querySelector('input[name="noticeTypeTmp"]').checked;
			console.log(is_checked);
			
			let type = table.querySelector('input[name="noticeType"]');
			console.log(type);
			type.value = is_checked ? 'Y' : 'N';
 		   
 		   $(this).submit();
 			
 		}	// updateNotice
 		
		
 		// ------------------------------------------------------------------
 		// 공지사항 게시글 파일 삭제 ajax
 		// ------------------------------------------------------------------
 		function deleteFile(noticeFileNo){
 			console.log(noticeFileNo);
			
 			let file = event.currentTarget.parentElement;
 			console.log(file);
 			
  			Swal.fire({
			title: "파일을 삭제하시겠습니까?",
			text : "※ 삭제된 파일은 복원이 불가합니다.",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: "삭제",
			cancelButtonText: "취소"
			}).then((result) => {
			if (!result.isConfirmed) {
				  return;
				}
 		
 			$.ajax({
				url : 'deleteFile',
				type : 'post',
				data : { 
						noticeFileNo : noticeFileNo,
						noticeNo : ${ list.noticeNo }
						},
				success : result => {
					
					if(result === 'success'){
						file.remove();
					}
					
				},	// success
				error : () => {
					console.log('AJAX 파일 삭제 실패!');
				}	// error
			});	// 	// ajax
			 
			});		// confrim
 		}	// deleteFile
 			

 		
 	   
	</script>
	    
</body>
</html>
