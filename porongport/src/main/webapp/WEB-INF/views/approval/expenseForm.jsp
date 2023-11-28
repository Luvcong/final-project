<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지출결의서</title>
	<!-- 부트스트립트 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- font-awesome (icon) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- css-->
   <link rel="stylesheet" href="resources/css/vacation.css">
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
	<div id="button" class="btn-right">
            <button type="button" class="btn btn-sm btn-secondary">결재</button>
            &nbsp;&nbsp;&nbsp;
            <button class="btn-modal btn btn-sm btn-secondary" data-toggle="modal" data-target="#myModal">결재라인</button>
        	&nbsp;&nbsp;&nbsp;
        	<a href="${path}/porong/document1" class="btn btn-sm btn-secondary">취소</a>
        	&nbsp;&nbsp;&nbsp;
		</div>
		<br>
		
    <div class="vacationTable">
	    <form action="${path}/approval/leaveApplication" method="post" id="vacationForm">
		<div>
			<div class="vct_file">지 출 결 의 서</div>
				<div class="blank"></div>
				<table class="table-bordered">
					<tr>
						<th class="vacation-th-size">부 서</th>
						<td><input type="text"  value="${loginUser.deptName}"></td>
	                    <th class="vacation-th-size">직 급</th>
	                    <td><input type="text"  value="${loginUser.jobName}"></td>
	                    <th class="vacation-th-size">성 명</th>
	                    <td><input type="text"  value="${loginUser.empName}"></td>
	                </tr>
				</table>
				<div class="blank"></div>
				<table class="table-bordered">
	                <tr>
	                	<th style="height: 70px; width: 120px;">제 목</th>
                    	<td colspan="7"><input type="text" name="erTitle" id="erTitle" style="width:495px" ></td>
						<th class="vacation-th-size">마감일</th>
	                    <td style="width:190px;"><input type="date" name="vctStart"></td>
	                </tr>
	             </table>  
	             <table class="table-bordered">
			
                <tr>
                    <th rowspan="10" style="width: 120px; height:100%">내 역</th>
                    <td colspan="2" style="width: 245px;">적 요</td>
                    <td colspan="2" style="width: 253px;">금 액</td>
                    <td colspan="2" style="width: 234px;">비 고</td>
                    <td colspan="1" style="font-size:17px">
						<button type="button" name="addRow" id="addRow" style="width:30px;height:25px; font-size:15px; border: 1px solid green;">
                    		<i class="fas fa-plus" style="color: green;"></i>
                    	</button> &nbsp;
                    	<button type="button" name="deleteRow" id="deleteRow" style="width:30px;height:25px; font-size:15px; border: 1px solid red;">
                    		<i class="fas fa-minus" style="color: red;"></i>
                    	</button>
					</td>
                </tr>
                <tr id="putContents">
                    <td colspan="2"><input type="text" name="erDetail" id="erDetail"></td>
                    <td colspan="2"><input type="text" name="erAmount" id="erAmount"></td>
                    <td colspan="3"><input type="text" name="erReference" id="erReference" value="-"></td> 
                </tr>    
                </table> 
                <table class="table-bordered">    
                <tr>
	                <td colspan="2"><p style="width:925px">위 금액을 청구하오니 결재바랍니다.</p></td>
	            </tr>
	            <tr>
	                <td colspan="2"><p style="width:925px">2023-11-17</p></td>
	            </tr>        
                
	            </table> 
	       		</div>
	       </form>
       </div>
       
       <div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">

					<div class="modal-header">
						<h4 class="modal-title">결재선 지정</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<div class="modal-body">

						<form role="form" id="frm" method="post" enctype="multipart/form-data"
							action="/approval/register">
							<table class="table table-striped table-bordered">

								<colgroup>
									<col/>
									<col/>
								</colgroup>

								<tbody>
									<tr>
										<th>조직도</th>
										<td><input type="text" id="apv_nm" name="apv_nm"
											class="form-control" placeholder="제목">
										</td>
									</tr>
									<tr>
										<th>직원 검색 <input type="text"> 
										<i class="fa-solid fa-magnifying-glass" style="color: #000000;"></i>
										</th>
									</tr>
									<tr>
										<th style="height:250px;">결재구분</th>
										<td><select id="div_apv_sq" class="form-control"
											name="div_apv_sq">
												<option value="1">결재</option>
												<option value="2">반려</option>
										</select></td>
									</tr>
									<tr>
										<th>결재파일 업로드</th>
										<td><input type="file" id="apv_pl_rt" name="file"
											class="form-control"></td>
									</tr>
								</tbody>

							</table>
							
						</form>
					</div>

					<div class="modal-footer">
						<button type="button" id="okbutton" class="btn btn-primary"
							data-dismiss="modal">입력</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
       

           
       </div>
   

	<script>
	$(document).ready(function(){
	    //키를 누르거나 떼었을때 이벤트 발생
	    $("#allAmount").bind('keyup keydown',function(){
	        inputNumberFormat(this);
	    });
	
	    //입력한 문자열 전달
	    function inputNumberFormat(obj) {
	        obj.value = comma(uncomma(obj.value));
	    }
	      
	    //콤마찍기
	    function comma(str) {
	        str = String(str);
	        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	    }
	
	    //콤마풀기
	    function uncomma(str) {
	        str = String(str);
	        return str.replace(/[^\d]+/g, '');
	    }
	
	    //숫자만 리턴(저장할때)
	    //alert(cf_getNumberOnly('1,2./3g')); -> 123 return
	    function cf_getNumberOnly (str) {
	        var len      = str.length;
	        var sReturn  = "";
	
	        for (var i=0; i<len; i++){
	            if ( (str.charAt(i) >= "0") && (str.charAt(i) <= "9") ){
	                sReturn += str.charAt(i);
	            }
	        }
	        return sReturn;
	    }
	});
	</script>
    
    <!-- 필수 입력 스크립트 -->
	<script>
		function check_onclick() {
		    var erWriteForm = document.erWriteForm;
		    
		    /* if(erWriteForm.erDetail.value=="" || erWriteForm.erAmount.value==""){
		        alert("적요 또는 금액란이 비어있습니다. 확인 후 등록하세요.");
		        
		        return false;
		    } else  */if(erWriteForm.allAmount.value=="" || erWriteForm.erTitle.value=="") {
		    	/* alert("지출금액 또는 제목란이 비어있습니다. 확인 후 등록하세요."); */
		    	Swal.fire({
				  icon: 'error',
				  title: '지출금액 또는 제목란이 비어있습니다.',
				  text: '확인 후 등록하세요!'
				})
			        
			    return false;
		    } else if(erWriteForm.proposerText.value=="") {
		       /* alert("서명 후 등록을 완료해주세요."); */
		       Swal.fire({
					  icon: 'error',
					  title: '서명 후 등록을 완료해주세요.',
					  text: '확인 후 등록하세요!'
				})
		       
		       return false;
		    } else if(erWriteForm.erDeadline.value=="") {
		    	/* alert("마감일자란이 비어있습니다. 확인 후 등록하세요."); */
		    	Swal.fire({
					  icon: 'error',
					  title: '마감일자란이 비어있습니다.',
					  text: '확인 후 등록하세요!'
				})
			        
			    return false;
		    } else {
				return true;
			}
		}
	</script>
    <!-- 서명 클릭 스크립트  -->
    
    <script>
    	$("#proposer").one("click",function(){
     		var proposerValue = $("input[name='writerName']").val();
     	
     		$("#proposerText").append(proposerValue);
    	});
    </script>
    
    <!-- 적요 금액 비고 칸 추가 및 삭제 -->
    
    <script>
    	$("#addRow").on("click", function() {
    		
    		$('#putContents').after(
    			 '<tr id="putContents">'
                +'<td colspan="2"><input type="text" name="erDetail" id="erDetail"></td>'
                +'<td colspan="2"><input type="text" name="erAmount" id="erAmount"></td>'
                +'<td colspan="3"><input type="text" name="erReference" id="erReference" value="-"></td>'
            	+'</tr> '
            	/* +'<script>$(document).ready(function(){$("#price").bind("keyup keydown",function(){inputNumberFormat(this);});function inputNumberFormat(obj) {obj.value = comma(uncomma(obj.value));}function comma(str) {str = String(str);return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");}function uncomma(str) {str = String(str);return str.replace(/[^\d]+/g, "");}function cf_getNumberOnly (str) {var len= str.length;var sReturn  = "";for (var i=0; i<len; i++){if ( (str.charAt(i) >= "0") && (str.charAt(i) <= "9") ){sReturn += str.charAt(i);}}return sReturn;}});<\/script>' 
             */);
    	});
    	
    	$("#deleteRow").on("click", function() {
    		$('#putContents').detach();
    	});
    </script>
	</div>

</body>
</html>