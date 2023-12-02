<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${ pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포롱포트</title>

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- font-awesome (icon) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- 메인화면 css-->
    <link rel="stylesheet" href="resources/css/main.css">
    
	<!-- JavaScript -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
	<!-- CSS -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
	<!-- Default theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
	<!-- Semantic UI theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/semantic.min.css"/>
    <!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<c:if test="${ not empty alertMsg }">
		<script>
			alertify.alert('Completion','${alertMsg}', function(){alertify.success('success')});
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>
    <div class="pp-outter">
        <!-- 메인화면 상단 헤더 영역 -->
        <div class="pp-header">      
        	<!-- 프롱포트 로고 영역 -->   
            <div class="logo"><img src="resources\images\logo.png" onclick="location.reload();"></div>
            <!-- 프로필이미지 & 직급명 & 로그아웃 영역 -->
            <div class="setting">       
                <div class="profile" onclick="myPage();">
                	<c:choose>
                		<c:when test="${ empty profile.fileNo }">
                			<img src="resources/images/profile.png" alt="포롱포트 로고 이미지" />	
                		</c:when>
                		<c:otherwise>
		                	<img src="resources/upProfiles/${ profile.changeFileName }" alt="입사자 사진" />
                		</c:otherwise>
                	</c:choose>
                    <span>${ sessionScope.loginUser.empName }</span>
                </div>
                <div class="icon" onclick="logout();"><i class="fa-solid fa-right-from-bracket"></i></div>
            </div>
        </div>  <!-- pp-header -->

		<script>
			function logout(){
				location.href = 'logout.em';
			};
			function myPage(){
				location.href = 'myPageAtt';
			};
			
		</script>
		
        <!-- 메인화면 메인 사이드바 영역-->
        <!-- .data-group : 아이콘 영역 클릭시 이동하려는 jsp의 매핑값 작성 -->
        <div class="pp-main">
            <div class="pp-sidebar">
                <div class="item" data-group='main'>
                    <div class="icon"><i class="fa-solid fa-house"></i></div>
                    <div class="menu-name">Home</div>
                </div>
                <div class="item" data-group='myPageAtt'>
                    <div class="icon"><i class="fa-solid fa-clipboard-user"></i></div>
                    <div class="menu-name">내정보</div>
                </div>
                <div class="item" data-group='approval'>
                    <div class="icon"><i class="fa-solid fa-paste"></i></div>
                    <div class="menu-name">전자결재</div>
                </div>
                <div class="item" data-group='receivedMessage'>
                    <div class="icon"><i class="fa-solid fa-envelope"></i></div>
                    <div class="menu-name">쪽지함</div>
                </div>
                <div class="item" data-group='noticeList'>
                    <div class="icon"><i class="fa-solid fa-pen-to-square"></i></div>
                    <div class="menu-name">게시판</div>
                </div>
                <div class="item" data-group='jojigdo.em'>
                    <div class="icon"><i class="fa-solid fa-address-book"></i></div>
                    <div class="menu-name">주소록</div>
                </div>
                 <div class="item" data-group='calendar'>
                    <div class="icon"><i class="fa-solid fa-calendar-days"></i></div>
                    <div class="menu-name">캘린더</div>
                </div>
				<c:if test="${loginUser.empAdmin eq 'A' and loginUser.deptCode eq 'WEB'}">
	                <div class="item" data-group='statistics'>
	                   	<div class="icon"><i class="fa-solid fa-chart-line"></i></div>
	                    <div class="menu-name">통계</div>
                    </div>
				</c:if>
            </div>  <!-- pp-sidebar -->


            <!-- 서브 사이드바 영역 -->
            <!-- .data-group : 아이콘 영역 클릭시 이동하려는 jsp의 매핑값 작성
            	 .data-url   : 해당 메뉴 클릭시 이동하려는 jsp의 매핑값 작성
            	 
            	 ********* 매핑값 작성시 주의사항 *********
            	  아이콘 영역의 data-group 매핑값과
            	  서브타이틀의 data-url의 매핑값이 동일해야합니다!
            	  data-url 매핑값 중 data-group 매핑값과 동일한게 하나라도 있어야
            	  사이드바에 서브메뉴가 출력됩니다.. 🥹
            	 ******************************************
            -->
            <div class="pp-sub-sidebar">
				<div class="sub-menu d-none" data-group='main'>						<!-- 여기 아이콘 영역의 data-group 매핑값과  -->
				   <div class="sub-item sub-title" data-url='main'>HOME</div> <!-- 여기 서브타이틀의 data-url의 매핑값이 동일해야함 -->
			       <div class="sub-item" data-url='https://kh-academy.co.kr/main/main.kh?null'>KH정보교육원</div>			
				   <div class="sub-item" data-url='weatherForm'>오늘의 날씨</div>
				   <div class="sub-item" data-url='main3'>메인메뉴3</div>
				</div>
						<c:choose>
					<c:when test="${ loginUser.empAdmin eq 'A' }">
						<div class="sub-menu d-none" data-group='myPageAtt'>
							<div class="sub-item sub-title" data-url='myPageAtt'>마이페이지</div>
					        <div class="sub-item" data-url='myPageUp'>내정보 관리</div>
						    <div class="sub-item" data-url='myPageAtt'>근태 관리</div>
						    <div class="sub-item" data-url='myPageIn'>입사자 등록</div>
				       		<div class="sub-item" data-url='mypage3'>연차 관리</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="sub-menu d-none" data-group='myPageAtt'>
							<div class="sub-item sub-title" data-url='myPageAtt'>마이페이지</div>
					        <div class="sub-item" data-url='myPageUp'>내정보 관리</div>
						    <div class="sub-item" data-url='myPageAtt'>근태 관리</div>
				       		<div class="sub-item" data-url='mypage3'>연차 관리</div>
						</div>
					</c:otherwise>
				</c:choose>
				 <div class="sub-menu d-none" data-group='approval'>
					<div class="sub-item sub-title" data-url='approval'>전자결재</div>
		         	<div class="sub-item" data-url='document1'>기안문 작성</div>
			        <div class="sub-item" data-url='document2'>결제 진행함</div>
			        <div class="sub-item" data-url='document3'>전체문서함</div>
				</div>
				<div class="sub-menu d-none" data-group='receivedMessage'>
					<div class="sub-item sub-title" data-url='receivedMessage'><i class="fa-solid fa-envelope"></i> 메시지함</div>
					<div class="sub-item not-hover" onclick='messageForm()'>
						<button class='btn btn-sm btn-primary msg-write'>메시지 작성</button>
					</div>
			        <div class="sub-item" data-url='receivedMessage'>받은 메시지</div>
			        <div class="sub-item" data-url='sendMessage'>보낸 메시지</div>
			        <div class="sub-item sub-item-menu" data-url='receivedStorageMessage'>받은 메시지 보관함</div>
			        <div class="sub-item sub-item-menu" data-url='sendStorageMessage'>보낸 메시지 보관함</div>
			        <div class="sub-item" data-url='deleteMessageBox'>휴지통</div>
				</div>
				<div class="sub-menu d-none" data-group='noticeList'>
					<div class="sub-item sub-title" data-url='notice'><i class="fa-solid fa-pen-to-square"></i> 게시판</div>
			        <div class="sub-item" data-url='noticeList'>공지사항 게시판</div>
			        <div class="sub-item" data-url='board'>자유 게시판</div>
				</div>
				<form action="jojigdo.em">
					<div class="sub-menu d-none" data-group='jojigdo.em'>
						<div class="sub-item sub-title" data-url='jojigdo.em'>조직도</div>
						<button type="button" class="btn btn-info" data-toggle="modal" data-target="#insertDept" style="width: 100%; height: 100%; font-size: 15px;">부서추가</button>
				        <button type="submit" class="sub-item" data-url='jojigdo.em'>인사부</button>
				        <input type="hidden" name="deptCode" value="HR" />
				        <!-- 
				        <div class="sub-item" data-url='jojigdo.em' onclick="jojigdo(HR);">인사부</div>
			       		<div class="sub-item" data-url='jojigdo.em' onclick="jojigdo(PD);">구매관리부</div>		        
				        <div class="sub-item" data-url='jojigdo.em' onclick="jojigdo(PM);">영업부</div>
				        
				<script>
					function jojigdo(deptCode){
						console.log(deptCode);
						location.href = '${path}jojigdo.em?deptCode=' + this;
					}
				</script>
				
				         -->
					</div>
				</form>
				<div class="sub-menu d-none" data-group='calendar'>

			    	<div class="sub-item sub-title" data-url='calendar'>캘린더</div>
					<c:if test="${loginUser.empAdmin eq 'A' and loginUser.deptCode eq 'PD'}"></c:if>
                	<div class="sub-item" data-url='adminMeetingRoom'>회의실 일정 관리</div>
				</div>
				<div class="sub-menu d-none" data-group='statistics'>
					<div class="sub-item sub-title" data-url='statistics'>통계 관리</div>
			        <div class="sub-item" data-url='AttendanceStatistics'>근태 통계</div>
			        <div class="sub-item" data-url='vacayStatistics'>연차 통계</div>
				<div>
				
            </div>  <!-- pp-sub-sidebar -->
            
            <!-- <div class="pp-content"></div> -->
            
        </div>  <!-- pp-main -->
    </div>  <!-- pp-outter -->
</body>


<!-- 사이드바 관련 스크립트 -->
<script>

	// 로그인 시, 웹소켓 연결
	const uri = 'ws://localhost:8002/porong/side';
	var socket = new WebSocket(uri);
	
	socket.onopen = e => {
		console.log('소켓 열림');
	};
	
	socket.onmessage = e => {
		if(e.data === 'Y'){
			Swal.fire({
			  title: '비밀번호를 변경해주세요.',
			  text: '변경일 30일이 지났습니다.',
			  icon: 'warning'
			});
			
			socket.close();
			//location.href = '${path}/myPageUp'
		}
			
	};
	
	socket.onclose = () => {
		console.log('소켓 닫힘');
	};

	// pp-content(자식요소)를 pp-main안으로 이동
	$(function(){
	    let main = document.querySelector('.pp-main');
	    let content = document.querySelector('.pp-content');
	    main.appendChild(content);
	});

    // 사이드바 메뉴 아이콘 클릭시 init_navbar() 메소드가 실행되도록 즉시실행 함수 작성
    $(function () {
    	init_navbar();
    });
    
    function init_navbar() {
    	// { "group_key" : [item1, item2, item3 ]}
    	
    	let group_list = {};
    	
    	// .sub-menu에 해당하는 요소들을 가져와 groups 변수에 저장
    	let groups = document.querySelectorAll('.sub-menu');
    	
    	for(let group of groups){
    		let group_key = group.getAttribute('data-group');
    		group_list[group_key] = [];
    		
    		for(let item of group.children) {
    			group_list[group_key].push(item.getAttribute('data-url'));
    		}
    	}
    	// console.log(group_list);
    	
    	// 1) 현재 url을 구하기
        let path_arr = window.location.pathname.split('/');
		let len = path_arr.length;
		let url = path_arr[len -1];
		console.log(url);
		
    	// 2) 현재 선택한 item을 sub_menus 변수에 저장
    	//    .sub-menu 클래스 중 data-url이 현재 url과 일치하는 요소를 찾은 후 d-none 클래스 제거
    	let sub_menus = document.querySelectorAll('.sub-item');
    	
    	for(let menu of sub_menus) {
    		let data_url = menu.getAttribute('data-url');
    		if(data_url == null)
    			continue;
    		
    		menu.addEventListener('click', function() {
    			location.href = data_url;
    		});
    		
    		if(data_url != null && data_url == url) {
    			menu.parentElement.classList.remove('d-none');
    		}
    	}
		
		// 3) item 클래스에 onclick 이벤트 등록
		//    현재 url과 일치하는 item에 active 클래스를 추가
    	let items = document.querySelectorAll('.item');
		
    	for(let item of items) {
    		let data_group = item.getAttribute('data-group');
    		item.addEventListener('click', function() {
    			location.href = data_group;
    		});
    		
    		let values = group_list[data_group];
    		if(values != null && values.includes(url)){
    			item.classList.add('active');
        	}
    	}
    }
</script>

<!-- 알림 띄우기 -->
<c:if test="${ not empty successText }">
	<script>
		// 성공 알림
		Swal.fire({
			text : '${ successText }',
			icon : 'success'
		});
	</script>
	<c:remove var="successText" />
</c:if>
<c:if test="${ not empty errorText }">
	<script>
		// 실패 및 에러 알림
		Swal.fire({
			text : '${ errorText }',
			icon : 'error'
		})
	</script>
	<c:remove var="errorText" />
</c:if>
<c:if test="${ not empty alertText }">
	<script>
		// 알림
		Swal.fire({
			text : '${ alertText }',
			icon : 'info'
		})
	</script>
	<c:remove var="alertText" />
</c:if>

</html>