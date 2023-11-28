<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가신청서</title>
	<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
	<script>
		function hrSubmit(e){
			//console.log(e.innerText);
			//$('#HRForm').attr('action', 'vacation').submit();
			$.ajax({
				url: 'organizationChart',
				data : {deptName : e.innerText},
				success: data=>{ 
					//console.log(data);
					/*
					console.log(data[0].deptName);
					console.log(data[0].empName);
					console.log(data[0].jobName);
					*/
					
					let value = '';

					for(i=0; i<data.length; i++){
						value += '<tr onclick="apSubmit(this);">'
						         + '<td>' + data[i].deptName + '</td>'
						         + '<td>' + data[i].empName + '</td>'
					             + '<td>' + data[i].jobName + '</td>'
						         + '</tr>'
					}
					 //console.log(value);
					
					$('#job_table').html(value);
				},
				error:()=>{
					console.log('실패');
				}
					
			})
		}

			
		function apSubmit(e){
			//console.log($(e).children()[0]);
			//console.log($(e).children()[1]);
			//console.log($(e).children()[2]);
			var index = 1;
			var department = $(e).children()[0];
			var empName = $(e).children()[1];
			var position = $(e).children()[2];
			
			console.log(index);
			$('#appCheck>tbody>tr').children('td:eq(0)').html(index);
			$('#appCheck>tbody>tr').children('td:eq(1)').html(department);
			$('#appCheck>tbody>tr').children('td:eq(2)').html(empName);
			$('#appCheck>tbody>tr').children('td:eq(3)').html(position);
		}	
	</script>
	
	
	
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
			<div class="vct_file">휴 가 신 청 서</div>
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
						<th class="vacation-th-size">일 시</th>
	                    <td id="vct_date"><input type="date" name="vctStart"> ~ <input type="date" name="vctEnd"></td>
	                    <th class="vacation-th-size">잔여 휴가</th>
	                    <td id="vct_day"><input type="text" readonly value="${loginUser.empAnnual - loginUser.empCount}">일</td>
	                </tr>
	                <tr>
	                    <th class="vacation-th-size">기간</th>
	                    <td><input type="text" value=""></td>
	                    <th class="vacation-th-size">휴가 구분</th>
	                    <td>
		                    <select class="vctKind">
		                    	<option value="1">연차</option>
		                    	<option value="0.5">반차</option>
		                    </select>
	                    </td>
	               </tr>
	             </table>  
	             <div class="blank"></div>    
	             <table class="table-bordered">
					<tr>
						<th class="vacation-th-size">비 상 연 락 망</th>
	                    <td id="vct_num"><input type="text" value="${ loginUser.empPhone }"></td>
	                </tr>
	                <tr>
	                    <th class="vacation-th-size">사유</th>
	                    <td><textarea rows="8" cols="100"></textarea></td>
	                </tr>
	                <tr>
	                    <td colspan="2"><p class="ex_txt">위와 같이 휴가를 신청하오니 허락하여 주시기 바랍니다.</p></td>
	                </tr>
	               </table>
	       		</div>
	       </form>
       </div>
       
       <div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content" style="width:1000px; height: 900px;">

					<div class="modal-header">
						<h2 class="modal-title">결재선 지정</h2>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<div class="modal-body">

						<form role="form" id="frm" method="post" enctype="multipart/form-data"
							action="/approval/register"></form>
							<table class="table table-striped table-bordered">

								<colgroup>
									<col/>
									<col/>
								</colgroup>

								<tbody>
									<tr>
										<table class="table table-bordered app_jojigdo">
						                    <thead>
						                        <tr>
						                        
						                        	<th>부서</th>
						                        	<th>성명</th>
						                        	<th>직급</th>
						                        </tr>
						             <tr>
						                        <!-- 
						                        <th><button type="button" value="HR">인사부</button></th>
							                  	<th><button type="button" value="PD">구매관리부</button></th>
							                  	<th><button type="button" value="PM">영업부</button></th>
							                  	 -->

        <!-- left start -->
            <h3 id="">조직도</h3>
	                    	<form action="" method="post" id="HRForm">
                <div class="">
                    <div id="">
                    	<ul style="">
                    	
	                    	<li class="">
		                    	<span class="">
		                    		<span class=""></span>
		                   			<button type="button" class="HRdept" onclick="hrSubmit(this);">인사부</button>
		                   	 	</span>
	                   		 </li>
	                   		 
	                    	<li class="">
	                   	 		<span class="">
		                    		<span class=""></span>
		                    		<button type="button" class="HRdept" onclick="hrSubmit(this);">구매관리부</button>
	                    		</span>
	                    	</li>
	                    	
	                    	<li class="">
		                    	<span class="">
			                    	<span class=""></span>
			                    	<button type="button" class="HRdept" onclick="hrSubmit(this);">영업부</button>
		                    	</span>
	                    	</li>
                    	</ul>
                    </div>
                </div>
                </form>
				 </tr>
				</thead>
				<tbody id="job_table">
					<div class="gm_box">
                
               		</div>
	               <table class="table table-bordered app_jojigdo" id="appCheck">
	                <h3 id="">결재자 ></h3>
	                <thead>
		                  <tr>
		                   <th>순서</th>
		                   <th>부서</th>
		                   <th>성명</th>
		                   <th>직급</th>
		                  </tr>
		            </thead>   
		            	<tbody>
		            		<tr>
		            			<td>1</td>
		            			<td></td>
		            			<td></td>
		            			<td></td>
		            		</tr>
		            	</tbody>   
	                   </table>
	               <table class="table table-bordered">
		                 <tr>
		                  	<h3>수신 부서 ></h3>
							<th>담당자</th>	                  
							<th>부서</th>
		                </tr>
	                   </table>
						<!-- 
							<tr>
								<th>직원 검색</th> 
								<td><input type="text"> <i class="fa-solid fa-magnifying-glass" style="color: #000000;"></i></td>
							</tr>
						-->
							<tr>
								<th style="height:250px;">결재구분</th>
									<td>
										<select id="div_apv_sq" class="form-control" name="div_apv_sq">
											<option value="1">결재</option>
											<option value="2">반려</option>
										</select>
									</td>
							</tr>
							<tr>
								<th style="width:150px;">결재파일 업로드</th>
									<td><input type="file" id="apv_pl_rt" name="file" class="form-control"></td>
							</tr>
							</div>
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
		$(()=>{
			/*
			$.ajax({
				url: 'organization',
				data: {deptCode: 'HR'},
				success: data=>{
					//console.log(data);
					console.log(data[0].deptName);
					
					let value = ' ';

					for(i=0; i<data.length; i++){
						value += '<tr>'
						         + '<td>' + data[i].deptName + '</td>'
						         + '</tr>'
						        
					}
					 console.log(value);
					
					$('#job_table').html(value);
					
                   
				},
				error:()=>{
					console.log('실패');
				}
					
			})
			*/
		})
		
		$(()=>{
			
		})
		
		</script>   
   

</body>
</html>