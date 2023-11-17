<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가신청서</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- font-awesome (icon) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- css-->
   <link rel="stylesheet" href="resources/css/approval.css">
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
	
	        <div id="button" align="center">
           <input type="hidden" />
              
				<c:choose>
                   <c:when test="${!empty approval.appReason}">
                      <button type="button" class="openRejectionWhy">결재</button>
                    <input type="text" style="border: none; width: 40px;" disabled>
                 	</c:when>
                 <c:otherwise>
                    <c:choose>
                       <c:when test="${(loginMember.user_name eq approval.firstApprover && approval.appPresent eq 'A') || 
                                (loginMember.user_name eq approval.interimApprover && approval.appPresent eq 'B') ||
                                (loginMember.user_name eq approval.finalApprover && approval.appPresent eq 'C')}">
                          <button class="btn-modal" data-toggle="modal" data-target="#myModal">결재라인</button>
                            <input type="text" style="border: none; width: 40px;"disabled >
                       </c:when>
                       <c:otherwise>
                       </c:otherwise>
                    </c:choose>
                 </c:otherwise>
              </c:choose>
         
         <button><a href="${path}/porong/document1" style="color:black">취소</a></button>
        </div>
	
	
	<c:if test="${!empty approval.appReason}">
      <div style="position:absolute; margin-left:400px; margin-top:30px">
      </div>
   </c:if>
    <form action="${path}/approval/leaveApplication" method="post">
       <div class="cash-form-section" style="height: 100%; width:68%; margin: 0 300px 0 300px;">
           <div class="cash-disbursement" style="text-align: center; margin: 80px 0px 80px 200px; border: 2px solid black;">
               <table border="2px" style="width: 100%; font-size: 20px; border-collapse: collapse;">
                   <tr>
                       <td  colspan="6" id="vct_file">휴 가 신 청 서</td>
                   </tr>
                   
                   <tr></tr>
                   <tr></tr>
                   <tr>
                       <td style="height: 70px; width: 80px;">성 명</td>
                       <td><input type="text"  value="${loginUser.empName}"></td>
                       <td style="width: 80px;">부 서</td>
                       <td><input type="text"  value="${loginUser.deptName}"></td>
                       <td style="width: 80px;">직 급</td>
                       <td colspan="3"><input type="text"  value="${loginUser.jobName}"></td>
                   </tr>
                   <tr>
                       <td colspan="3" style="height: 70px; width: 80px;">비 상 연 락 망</td>
                       <td colspan="3"><input type="text" value="${ loginUser.empPhone }" style="font-size: 25px;"></td>
                   </tr>
                   <tr>
                       <td colspan="3" style="height: 70px; width: 80px;">기 간</td>
                       <td colspan="3"><input type="date" name="vctStart"> ~ <input type="date" name="vctEnd">

                           
                       </td>
                   </tr>
                   <tr>
                      <td style="width: 80px; height: 70px; font-family: 'InfinitySans-RegularA1'; font-size: 16px;">휴가 구분</td>
                      <td colspan="2"><input type="checkbox">연차<input type="checkbox" onclick="clickCheck(this)">반차
                       <div class="form-checkbox-wrap">
                          <sapn class="form-inline">
                              <label>${ approval.leaveClassify }</label>
                          </sapn>
                      </div>
                      </td>
                      <td style="width: 80px; height: 70px; font-family: 'InfinitySans-RegularA1'; font-size: 16px;">잔여 휴가</td>
                      <td colspan="5"><input type="text">일
                       <div class="form-checkbox-wrap">
                          <sapn class="form-inline">
                              <label>${ approval.leaveClassify }</label>
                          </sapn>
                      </div>
                      </td>
                   </tr>

                   <tr>
                       <td style="width: 80px;">사유</td>
                       <td colspan="8">
                           <input style="height: 200px; width: 1000px" type="text" value="${ approval.leaveDetail }">
                       </td>
                   </tr>
                   <tr>
                       <td colspan="8" style="text-align: center; height: 100px; border-bottom: none;">위와 같이 휴가를 신청하오니 허락하여 주시기 바랍니다.</td>
                   </tr>
                   <tr style="border: white;">
                       <td colspan="8" style="text-align: center; height: 100px;">
                           <input type="text" style="text-align:center; font-size: 30px;" readonly><fmt:formatDate value="${approval.appWriteDate}" pattern="yyyy 년 MM 월 dd 일"/></input>
                       </td>
                   </tr>

               </table>
           </div>
       </form>
       
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
									<col width="50%" />
									<col width="50%" />
								</colgroup>

								<tbody>
									<tr>
										<th style="height:250px;">조직도</th>
										<td><input type="text" id="apv_nm" name="apv_nm"
											class="form-control" placeholder="제목">
										</td>
									</tr>
									<tr>
										<th>직원 검색 <input type="text" style="width: 100px;"> 
										<i class="fa-solid fa-magnifying-glass" style="color: #000000;"></i>
										</th>
									</tr>
									<tr>
										<th style="height:250px;">결재구분</th>
										<td><select id="div_apv_sq" class="form-control"
											name="div_apv_sq">
												<option value="1">결재</option>
												<option value="2">대기</option>
												<option value="3">반려</option>
										</select></td>
									</tr>
									<tr>
										<th>중간승인자</th>
										<td><input type="text" id="stf_mid_sq" name="stf_mid_sq"
											class="form-control" placeholder="중간승인자 사원번호입력"></td>
									</tr>
								<!-- 	<tr>
										<th>결재파일 이름</th>
										<td><input type="text" id="apv_pl_nm" name="apv_pl_nm"
											class="form-control"></td>
									</tr>  -->
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
   
   

</body>
</html>