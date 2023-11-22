<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예시용</title>
</head>
<body>

<div id="">
    <span id="">결재선 지정</span>
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
	                    	
		                    	<ul style="">
		                    	
			                    	<li class="">
				                    	<span class="">
				                    		<span class=""></span>
				                   			<a href="#" class="">경영지원부</a>
				                   	 	</span>
			                   		 </li>
			                   		 
			                    	<li class="">
			                   	 		<span class="">
				                    		<span class=""></span>
				                    		<a href="#" class="">외식사업부</a>
			                    		</span>
			                    	</li>
			                    	
			                    	<li class="">
				                    	<span class="">
					                    	<span class=""></span>
					                    	<a href="#" class="">영업1사업부</a>
				                    	</span>
			                    	</li>
		                    	</ul>
		                    </li>
	                    </ul>
                    </div>
                </div>

                <div class="">
                    <h3 id="">구성원</h3>
                    <table class="">
                        <thead>
                            <tr>
                                <th class="" id="">이름</th>
                                <th class="" id="">직책</th>
                                <th class="" id="">부서</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                            
                            </tr>
                        </tbody>
                        
                    </table>
                </div>
                
            </div>
        </div>
        <!-- left end -->
    </div>

    <!-- right start -->
    <div class="">
        <div class="gm_box">
            <table>
                <tbody>
	                <tr>
	                    <td>
	                        <!--버튼 -->
	                        <button id="" class="" onclick="">결재자</button>
	                        <button id="" class="" onclick="">부서</button>
	                    </td>
	                    <td>
	                        <span id="thApprover" class="tdHeader">결재자</span>
	                        
	                        <!-- 목록 -->
	                        <div>
	                            <table>
		                            <thead>
		                                    <tr>
		                                        <th class="" id="">순서</th>
		                                        <th class="" id="" >이름</th>
		                                        <th class="" id="">직책</th>
		                                        <th class="" id="">부서</th>
		                                        <th class="" id="">결재선</th>
		                                    </tr>
		                            </thead>
	                                <tbody>
	                                    <tr>
	                                    
	                                    </tr>
	                                </tbody>
	                            </table>
	                        </div>
	                    </td>
	                </tr>
	            </tbody>
            </table>
        </div>
        
        <div class="">
            <table>
                <tr>
                    <td>
                        <button id="" class="" onclick="">수신부서</button>
                    </td>
                    
                    <td>
                        <span id="thReceiverDept" class="tdHeader">수신부서</span>
                        
                        <!-- 목록 -->
                        <div class="divrecvlst">
                        
                            <table>
                                <thead>
                                    <tr>
                                        <th class="" id="">부서</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                    <tr>
                                        
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        
    </div>
    <!-- right end -->


</div>

<div id="gm_footer">
    <ul class="gm_footerbtn">
        <li id="MoveUp" onclick="javascript:return MoveApprovalLine('UP');">올리기</li>
        <li id="MoveDown" onclick="javascript:return MoveApprovalLine('DOWN');">내리기</li>
        <li id="DeleteApprovalLine">삭제</li>
        <li style="display: none;" id="ClearApprovalLine">결재선 초기화</li>
        <li id="SetApprovalLine">결재선 반영</li>
    </ul>
</div>


</body>
</html>