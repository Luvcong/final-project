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
</head>
<body>
    <div class="pp-outter">
        <!-- 메인화면 상단 헤더 영역 -->
        <div class="pp-header">      
        	<!-- 프롱포트 로고 영역 -->   
            <div class="logo"><img src="resources\images\logo.png"></div>
            <!-- 프로필이미지 & 직급명 & 로그아웃 영역 -->
            <div class="setting">       
                <div class="profile">
                	<img src="resources\images\profile.png">
                    <span>이승철 팀장</span>
                </div>
                <div class="icon"><i class="fa-solid fa-right-from-bracket"></i></div>
            </div>
        </div>  <!-- pp-header -->

        <!-- 메인화면 메인 사이드바 영역-->
        <!-- .data-group : 아이콘 영역 클릭시 이동하려는 jsp의 매핑값 작성 -->
        <div class="pp-main">
            <div class="pp-sidebar">
                <div class="item" data-group='main'>
                    <div class="icon"><i class="fa-solid fa-house"></i></div>
                    <div class="menu-name">Home</div>
                </div>
                <div class="item" data-group='mypage'>
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
                <div class="item" data-group='board'>
                    <div class="icon"><i class="fa-solid fa-pen-to-square"></i></div>
                    <div class="menu-name">게시판</div>
                </div>
                <div class="item" data-group='address'>
                    <div class="icon"><i class="fa-solid fa-address-book"></i></div>
                    <div class="menu-name">주소록</div>
                </div>
                 <div class="item" data-group='calendar'>
                    <div class="icon"><i class="fa-solid fa-calendar-days"></i></div>
                    <div class="menu-name">캘린더</div>
                </div>
            </div>  <!-- pp-sidebar -->


            <!-- 서브 사이드바 영역 -->
            <!-- .data-group : 아이콘 영역 클릭시 이동하려는 jsp의 매핑값 작성
            	 .data-url   : 해당 메뉴 클릭시 이동하려는 jsp의 매핑값 작성 -->
            <div class="pp-sub-sidebar">
				<div class="sub-menu d-none" data-group='main'>
			       <div class="sub-item" data-url='main'>메인메뉴1</div>
				   <div class="sub-item" data-url='main2'>메인메뉴2</div>
				   <div class="sub-item" data-url='main3'>메인메뉴3</div>
				</div>
				<div class="sub-menu d-none" data-group='mypage'>
			        <div class="sub-item" data-url='mypage1'>내정보 관리</div>
				    <div class="sub-item" data-url='mypage2'>근태 관리</div>
		       		<div class="sub-item" data-url='mypage3'>연차 관리</div>
				</div>
				 <div class="sub-menu d-none" data-group='approval'>
					<div class="sub-item sub-title" data-url='approval'>전자결재</div>
		         	<div class="sub-item" data-url='document1'>기안문 작성</div>
			        <div class="sub-item" data-url='document2'>결제 진행함</div>
			        <div class="sub-item" data-url='document3'>전체문서함</div>
				</div>
				<div class="sub-menu d-none" data-group='receivedMessage'>
					<div class="sub-item sub-title" data-url='receivedMessage'>메시지함</div>
			        <div class="sub-item" data-url='receivedMessage'>받은 메시지</div>
			        <div class="sub-item" data-url='sendMessage'>보낸 메시지</div>
			        <div class="sub-item" data-url='receiveMessageBox'>메시지 보관함</div>
			        <div class="sub-item sub-item-menu" data-url='receiveMessageBox'>받은 메시지 보관함</div>
			        <div class="sub-item sub-item-menu" data-url='sendMessageBox'>보낸 메시지 보관함</div>
			        <div class="sub-item" data-url='deleteMessage'>휴지통</div>
				</div>
				<div class="sub-menu d-none" data-group='board'>
			        <div class="sub-item" data-url='board1'>게시판1</div>
			        <div class="sub-item" data-url='board2'>게시판2</div>
			        <div class="sub-item" data-url='board3'>게시판3</div>
				</div>
				<div class="sub-menu d-none" data-group='address'>
					<div class="sub-item" data-url='address1'>주소록1</div>
					<div class="sub-item" data-url='address2'>주소록2</div>
					<div class="sub-item" data-url='address3'>주소록3</div>
				</div>
				<div class="sub-menu d-none" data-group='calendar'>

			    	<div class="sub-title" data-url='calendar'>캘린더</div>

			        <div class="sub-item" hidden data-url='calendar' >전체보기</div>
			        <div class="sub-item" data-url='myCalendar'>나의 일정 추가</div>
			        <div class="sub-item" data-url='departmentCalendar'>부서 일정 추가</div>
			        <div class="sub-item"data-url='reservation'>회의실 예약</div>
			        <c:if test="${loginUser.empAdmin eq 'A' and loginUser.deptId eq 'PD'}">
                <div class="sub-item" data-url='meetingRoom'>회의실 일정 관리</div>
                </c:if>
				</div>
            </div>  <!-- pp-sub-sidebar -->
            
            <!-- <div class="pp-content"></div> -->
            
        </div>  <!-- pp-main -->
    </div>  <!-- pp-outter -->
</body>


<!-- 사이드바 관련 스크립트 -->
<script>
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
    	console.log(group_list);
    	
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
</html>