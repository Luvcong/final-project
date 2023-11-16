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
	<form button="submit" action="${path}/porong/line">
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
                          <button type="submit" id="approveddone">결재라인</button>
                            <input type="text" style="border: none; width: 40px;"disabled >
                       </c:when>
                       <c:otherwise>
                       </c:otherwise>
                    </c:choose>
                 </c:otherwise>
              </c:choose>
         
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
   
   

</body>
</html>