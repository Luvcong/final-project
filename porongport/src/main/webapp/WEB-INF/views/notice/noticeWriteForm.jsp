<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>[포롱포트] 공지사항 작성</title>

<style>
	.ck-editor__editable { height: 400px; }
	.ck-content { font-size: 14px; }
	.ck-editor__editable p {margin: 0}
	
	<!-- 버튼 -->
	#btnDiv { text-align: center; margin-top: 20px; }
	.btns { display: inline-block; padding: 0 10px; height: 28px; line-height: 26px; text-align: center; vertical-align: middle; border-radius: 3px; border: 1px solid transparent; font-weight: 500; }
	.btns.save { background: #139dc8; color: #fff; cursor: pointer; }
	.btns.back { background: #fff; border: 1px solid #199bc4; color: #199bc4; }
	#tb-notice-form th{ text-align: center;}
</style>

<!-- 메인화면 css-->
<link rel="stylesheet" href="resources/css/main.css">
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
	
    <h2 style="text-align: center;">공지사항 작성</h2>
    
    <form action="insertNotice" method="post" enctype="multipart/form-data">
	    <table id="tb-notice-form" class="table table-sm">
	   		<tr>
	   			<th>제목</th>
	   			<td><input class="form-control form-control-sm" name="noticeTitle" required></td>
	   			<td >
	   			<div class="form-check form-switch">
				  <label>
				  <input class="form-check-input" type="checkbox" name="noticeTypeTmp">
				  <input type="hidden" name="noticeType"/>
				  중요공지 설정
				  </label>
				</div>
	   			</td>
	   		</tr>
	   		<tr>
	   			<th>첨부파일</th>
	   			<td><input type="file" name="multiFile" multiple></td>
	   		</tr>
	   		<tr>
	   			<th>내용</th>
	   			<td>
	   			<div>
	   				<textarea id="editor" name="noticeContent" required></textarea>
	   			</div>
	   			</td>
	   		</tr>
	   	</table>
				    	
		<div id="btnDiv">
		    <button type="submit" class="btns save" onclick="insertNotice()">작성하기</button>
		    <button type="button" class="btns back" onclick="location.href='${path}/notice'">목록으로</button>
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
 		// 공지사항 게시글 작성
 		// ------------------------------------------------------------------ 
 	   function insertNotice() {
 		   let content = document.getElementById('editor'); 
 		   content.value = editor.getData();
 		   console.log(content.value);
 		   
 		  let table = document.getElementById('tb-notice-form');
 		  let is_checked = table.querySelector('input[name="noticeTypeTmp"]').checked;
 		  
 		  let type = table.querySelector('input[name="noticeType"]');
 		  type.value = is_checked ? 'Y' : 'N';
 		  
 		  $(this).submit();
 	   }
 	   
	</script>
	    
</body>
</html>
