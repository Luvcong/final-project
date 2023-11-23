<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가신청서</title>
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
	                <tr>
	                    <td colspan="2"><p class="ex_txt">2023-11-17</p></td>
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
										<table class="table table-bordered app_jojigdo">
						                    <thead>
						                        <tr>
						                        
						                        	<th>부서</th>
						                        </tr>
						                        <tr>
						                        <!-- 
						                        <th><button type="button" value="HR">인사부</button></th>
							                  	<th><button type="button" value="PD">구매관리부</button></th>
							                  	<th><button type="button" value="PM">영업부</button></th>
							                  	 -->
							                  	 <div id="">
    <span id=""></span>
</div>

<div id="">
    <div class="">
    
        <!-- left start -->
        <div class="">
            <h2 id="">조직도</h2>
            
            <div class="">
            
                <div class="">
                    <div id="">
                    
                    	<ul class="">
                    	
	                    	<li class="">
	                    	
	                    	<form action="" method="post" id="HRForm">
		                    	<ul style="">
		                    	
			                    	<li class="">
				                    	<span class="">
				                    		<span class=""></span>
				                   			<a class="HRdept" onclick="HRsubmit(0);">인사부</a>
				                   	 	</span>
			                   		 </li>
			                   		 
			                    	<li class="">
			                   	 		<span class="">
				                    		<span class=""></span>
				                    		<a href="#" class="">구매관리부</a>
			                    		</span>
			                    	</li>
			                    	
			                    	<li class="">
				                    	<span class="">
					                    	<span class=""></span>
					                    	<a href="#" class="">영업부</a>
				                    	</span>
			                    	</li>
		                    	</ul>
		                    	</form>
		                    </li>
	                    </ul>
                    </div>
                </div>
						                        </tr>
						                    </thead>
						                    <tbody id="job_table">
						                  	
						                    </tbody>
						                </table>
									</tr>
									<!-- 
									<tr>
										<th>직원 검색</th> 
										<td><input type="text"> <i class="fa-solid fa-magnifying-glass" style="color: #000000;"></i></td>
										
									</tr>
									 -->
									<tr>
										<th style="height:250px;">결재구분</th>
										<td><select id="div_apv_sq" class="form-control"
											name="div_apv_sq">
												<option value="1">결재</option>
												<option value="2">반려</option>
										</select></td>
									</tr>
									<tr>
										<th style="width:150px;">결재파일 업로드</th>
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
		function HRsubmit(num){
			$('#HRForm').attr('action', 'approval/vacationForm').submit();
		}
		$(()=>{
			$.ajax({
				url: 'organization',
				data: {deptCode: }
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
		})
		
		$(()=>{
			$.ajax({
				url: 'organizationChart',
				success: data=>{
					deptName : $('#deptName').val()
				},
					//console.log(data);
					console.log(data[0].deptName);
					console.log(data[0].empName);
					console.log(data[0].jobName);
					
					let value = ' ';

					for(i=0; i<data.length; i++){
						value += '<tr>'
						         + '<td>' + data[i].deptName + '</td>'
						         + '<td>' + data[i].empName + '</td>'
					             + '<td>' + data[i].jobName + '</td>'
						         + '</tr>'
						        
					}
					 console.log(value);
					
					$('#job_table').html(value);
					
                   
				},
				error:()=>{
					console.log('실패');
				}
					
			})
		})
		
		</script>   
   

</body>
</html>