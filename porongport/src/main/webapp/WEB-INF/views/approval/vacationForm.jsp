<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가신청서</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
	<form button="submit" action="../prong/line">
	        <div id="button" align="center">
           <input type="hidden" name="appNo" value = "${approval.appNo}"/>
              
           <%-- <c:if test="${loginMember.user_name eq approval.firstApprover || approval.interimApprover || approval.finalApprover}">
                 --%><c:choose>
                   <c:when test="${!empty approval.appReason}">
                      <button type="button" class="openRejectionWhy">반려사유</button>
                    <input type="text" style="border: none; width: 40px;" disabled>
                 </c:when>
                 <c:otherwise>
                    <c:choose>
                       <c:when test="${(loginMember.user_name eq approval.firstApprover && approval.appPresent eq 'A') || 
                                (loginMember.user_name eq approval.interimApprover && approval.appPresent eq 'B') ||
                                (loginMember.user_name eq approval.finalApprover && approval.appPresent eq 'C')}">
                          <button type="submit" id="approveddone">결재</button>
                            <input type="text" style="border: none; width: 40px;"disabled >
                            <button type="button" style="color:red" id="openRejection">반려</button>
                          <input type="text" style="border: none; width: 40px;" disabled>
                       </c:when>
                       <c:otherwise>
                          <button type="button" id="approveddone" disabled>결재</button>
                            <input type="text" style="border: none; width: 40px;"disabled >
                            <button type="button" id="openRejection" disabled>반려</button>
                          <input type="text" style="border: none; width: 40px;" disabled>
                       </c:otherwise>
                    </c:choose>
                 </c:otherwise>
              </c:choose>
         <%-- </c:if> --%>
         
         <button><a href="${path}/porong/document1" style="color:black">취소</a></button>
        </div>
	</form>
	<c:if test="${!empty approval.appReason}">
      <div style="position:absolute; margin-left:400px; margin-top:30px">
      </div>
   </c:if>
    <form action="${path}/approval/leaveApplication" method="post">
       <div class="cash-form-section" style="height: 100%; width:68%; margin: 0 300px 0 300px;">
           <div class="cash-disbursement" style="text-align: center; margin: 80px 0px 80px 200px; border: 2px solid black;">
               <table border="2px" style="width: 100%; font-size: 20px; border-collapse: collapse;">
                   <tr>
                       <td rowspan="3" colspan="6" style="width: 300px; height: 140px; font-size: 40px; font-weight: 600;">휴 가 신 청 서</td>
                   </tr>
                   
                   <tr></tr>
                   <tr></tr>
                   <tr>
                       <td style="height: 70px; width: 80px;">성 명</td>
                       <td><input type="text"  value="${approval.userName}"></td>
                       <td style="width: 80px;">부 서</td>
                       <td><input type="text"  value="${approval.deptName}"></td>
                       <td style="width: 80px;">직 급</td>
                       <td colspan="3"><input type="text"  value="${approval.rank}"></td>
                   </tr>
                   <tr>
                       <td colspan="3" style="height: 70px; width: 80px;">비 상 연 락 망</td>
                       <td colspan="5"><input type="text" value="${ approval.appEmergncyCall }" style="font-size: 25px;"></td>
                   </tr>
                   <tr>
                       <td colspan="3" style="height: 70px; width: 80px;">기 간</td>
                       <td colspan="3"><input type="date">
                           <%-- <label class="leaveDate">${approval.leaveStart}</label>
                             ~  
                           <label class="leaveDate">${approval.leaveFinish}</label> --%>
                           <fmt:formatDate value="${approval.leaveStart}" pattern="yyyy 년 MM 월 dd 일"/><label>&nbsp;&nbsp; ~ &nbsp;&nbsp;</label>
                           <input type="date">
                           <fmt:formatDate value="${approval.leaveFinish}" pattern="yyyy 년 MM 월 dd 일"/>&nbsp;까지
                       </td>
                   </tr>
                   <tr>
                      <td style="width: 80px; height: 70px; font-family: 'InfinitySans-RegularA1'; font-size: 16px;">휴가 구분</td>
                      <td colspan="8"><input type="checkbox">연차<input type="checkbox" onclick="clickCheck(this)">반차
                       <div class="form-checkbox-wrap">
                          <sapn class="form-inline">
                              <label>${ approval.leaveClassify }</label>
                          </sapn>
                      </div>
                      </td>
                   </tr>
                   <tr>
                      <td style="width: 80px; height: 70px; font-family: 'InfinitySans-RegularA1'; font-size: 16px;">잔여 휴가</td>
                      <td colspan="8"><input type="text">일
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
                           <input style="height: 200px; width: 1000px" type="text" value="${ approval.leaveDetail }" readonly>
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
                   <tr>
                       <td colspan="8" style="text-align: right; height: 100px; padding-right: 50px;">
                           신청자 : <input type="text" style=" width:200px; border: none; text-align: center;" maxlength="4" value="${approval.userName}" readonly>
                           (인)
                       </td>
                   </tr>
               </table>
           </div>
       </form>
       

           
       </div>
   
   
<!-- 모달 테이블(반려 확인) -->
    
   <div class="modal modal1 hidden">
        <div class="bg"></div>
        <div class="modalBox" style="width:600px; height:400px; border-radius:20px">
            <div style="font-size:26px; margin:30px">
               정말 반려처리 하시겠습니까?
            </div>
            <div style="margin: 43% 0px 0% 53%;">
                <span style="padding-right: 20px; margin-left:46px; float: left;" >
                    <button type="submit" class="closeBtn-in rejModalOk1" id="rejectOrNo">확인</button>
                </span>
                <button class="closeBtn-out rejModalNo1">취소</button>
            </div>
        </div>
    </div>
    
    <!-- 모달 테이블(반려 사유 작성) -->
    
   <div class="modal modal2 hidden">
        <div class="bg"></div>
        <div class="modalBox" style="width:600px; height:400px; border-radius:20px">
            <div style="font-size:26px; margin:30px">
               반려 사유를 입력해주세요.
            </div>
            <textarea name="rejectReasonText" rows="5" cols="45" style="font-size:23px; margin-left:23px; resize: none;"></textarea>
            <div style="margin: 8.8% 0px 0% 53%;">
                <span style="padding-right: 20px; margin-left:46px;float: left;" >
                    <button type="submit" class="closeBtn-in rejModalOk2" id="rejectReason">확인</button>
                </span>
                <button class="closeBtn-out rejModalNo2">취소</button>
            </div>
        </div>
    </div>
    
    <!-- 반려사유 보여주는 모달 -->
    
    <div class="modal modal3 hidden">
        <div class="bg"></div>
        <div class="modalBox" style="width:600px; height:400px; border-radius:20px">
            <div style="font-size:26px; margin:30px">
               반려사유 :
            </div>
            <textarea name="rejectReasonText" rows="6" cols="45" style="font-size:23px; margin-left:23px; resize: none;" readonly>${approval.appReason}</textarea>
            <div style="margin: 5% 0px 0% 69%;">
                <span style="padding-right: 20px; margin-left:46px; float: left;" >
                    <button type="button" class="closeBtn-in3">확인</button>
                </span>
            </div>
        </div>
    </div>
    
    <script>
    /* 반려사유 확인 모달 */
   const open3 = () => {
       document.querySelector(".modal3").classList.remove("hidden");
    }

    const close3 = () => {
        document.querySelector(".modal3").classList.add("hidden");
    }
   
    document.querySelector(".openRejectionWhy").addEventListener("click", open3);
    document.querySelector(".closeBtn-in3").addEventListener("click", close3);
   
    </script>
    
    <!-- 모달 스크립트 -->
    <script>
       const open = () => {
          document.querySelector(".modal1").classList.remove("hidden");
       }
   
       const close = () => {
           document.querySelector(".modal1").classList.add("hidden");
       }
   
       document.querySelector("#openRejection").addEventListener("click", open);
       document.querySelector(".rejModalNo1").addEventListener("click", close);
          
       /* 모달 반려사유 */
       
       const open2 = () => {
          document.querySelector(".modal2").classList.remove("hidden");
       }
   
       const close2 = () => {
           document.querySelector(".modal2").classList.add("hidden");
       }
      
       document.querySelector(".rejModalOk1").addEventListener("click", close);
       document.querySelector(".rejModalOk1").addEventListener("click", open2);
       document.querySelector(".rejModalNo2").addEventListener("click", close2);

       
       document.querySelector(".rejModalOk2").addEventListener("click",close2);
       
       $(document).ready(function() {
          $('#rejectReason').click(function() {
             var rejectReasonText = $("textarea[name='rejectReasonText']").val();
             var appNo = $("input[name=appNo]").val();
             
             console.log(rejectReasonText);
             $.ajax({
                      type: "post",
                      url: "${path}/approval/letterOfApprovalUpdate?appNo="+appNo,
                      data: {
                         rejectReasonText:rejectReasonText
                     },
                      success: function(data){
                         var url = "${path}/approval/approvalMain";
                             
                         if(data != 0) {
                        	 Swal.fire({
	                			   icon: 'success',
	                			   title: '결재반려 처리가 \n정상적으로 완료되었습니다.'
	                		})
                                $(location).attr('href',url);
                         } else {
                        	 Swal.fire({
	                  			   icon: 'error',
	                  			   title: '결재반려 처리에 \n실패하였습니다.'
	                  		})
                                $(location).attr('href',url);
                         }
                     },
                      error: function(){ alert("잠시 후 다시 시도해주세요."); }
                });
          });
       });
    </script>
    
    <!-- 결재승인버튼 스크립트 -->
    <script>
       $("#Approver1").one("click",function(){
          
          $.ajax({
                type: "post",
                url: "${path}/approval/loaApproved1?appNo="+${approval.appNo},
                success: function(){
                	Swal.fire({
 	     			   icon: 'success',
 	     			   title: '결재서명이 \n완료되었습니다.'
 	     			})
                  $("#firstA").append('<img src="${path}/images/approved.png" id="checkIfApproved" style="position:absolute; width:130px; height:130px; margin-left:-92px; margin-top:-50px" />');
               },
                error: function(){ alert("잠시 후 다시 시도해주세요."); }
          });
       });
       
      $("#Approver2").one("click",function(){
          
          $.ajax({
                type: "post",
                url: "${path}/approval/loaApproved2?appNo="+${approval.appNo},
                success: function(){
                	Swal.fire({
 	     			   icon: 'success',
 	     			   title: '결재서명이 \n완료되었습니다.'
 	     			})
                  $("#interimA").append('<img src="${path}/images/approved.png" id="checkIfApproved" style="position:absolute; width:130px; height:130px; margin-left:-92px; margin-top:-50px" />');
               },
                error: function(){ alert("잠시 후 다시 시도해주세요."); }
          });
       });
      
      $("#Approver3").one("click",function(){
          
          $.ajax({
                type: "post",
                url: "${path}/approval/loaApproved3?appNo="+${approval.appNo},
                success: function(){
                	Swal.fire({
 	     			   icon: 'success',
 	     			   title: '결재서명이 \n완료되었습니다.'
 	     			})
                  $("#finalA").append('<img src="${path}/images/approved.png" id="checkIfApproved" style="position:absolute; width:130px; height:130px; margin-left:-92px; margin-top:-50px" />');
               },
                error: function(){ alert("잠시 후 다시 시도해주세요."); }
          });
       });
      </script>
      
      <!-- 하단 결재버튼 -->
   	<script>
   		$("#approveddone").click(function() {
   			if($('#checkIfApproved').length > 0) {
   				var url = "${path}/approval/document1";
	   			alert("결재가 완료되었습니다.");
	   	        $(location).attr('href', url);  			
   			} else {
   				var url = "${path}/approval/letterOfApprovalView?appNo="+${approval.appNo};
   				alert("결재서명 후 결재를 진행해주세요.");
   			}
   		});
   		
   		/* function checkIfApproved() {
		    if(document.getElementById('checkIfApproved')){
		        alert("결재가 완료되었습니다.");
		        
				return true;
			} else {
		        alert("결재서명 후 결재를 진행해주세요.");
		        
		        return false;
			}
		} */
   	</script>

      
      <script type="text/javascript">
/*       <input type="hidden" id="hiddenStartDate"><fmt:formatDate value="${approval.leaveStart}" pattern="yyyy - MM - dd"/></input>
   <input type="hidden" id="hiddenFinishDate"><fmt:formatDate value="${approval.leaveFinish}" pattern="yyyy - MM - dd"/></input> */
      function leaveStartAndFinish() {
         var StartDate = document.getElementById('hiddenStartDate');
         var leaveFinish = document.getElementById('leaveFinish');
         var leaveDate = document.getElementById('leaveDate');
         
         StartDate = ${approval.leaveStart};
         leaveFinish = ${approval.leaveFinish};
         
         leaveDate.innerHTML += StartDate + "  ~  " + leaveFinish;
      
      }
   </script>
	</div>

</body>
</html>