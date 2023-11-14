<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프롱포트</title>

    <!-- 프롱포트 프로젝트 공통 화면 HTML (헤더 & 사이드바) 입니다.
         현재 구성했던 화면 디자인이랑 동일하게 틀만 작업해놓은 상태이고,
         디테일한 부분은 프로젝트 시작시 수정이 필요합니다!😊 -->

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
            <div class="logo">          <!-- 프롱포트 로고 영역 -->
                <img src="resources\images\logo.png">
            </div>
            <div class="setting">       <!-- 프로필이미지 & 직급명 & 로그아웃 영역 -->
                <div class="profile">
                    <img src="resources\images\profile.png">
                    <span>이승철 팀장</span>
                </div>
                <div class="icon">
                    <i class="fa-solid fa-right-from-bracket"></i>
                </div>
            </div>
        </div>  <!-- pp-header -->

        <!-- 메인화면 왼쪽 사이드바 영역-->
        <!--
            .menu-name : 대분류 메뉴 작성 영역
            .sub-item  : 소분류 메뉴 작성 영역 (아이콘 클릭시 펼쳐지는 사이드바 메뉴 부분)
            
            ** 펼쳐지는 사이드바 영역은 화면 디테일 구성이 안되어있어서 단순틀만 작업되어 있는 상태(css적용x)
        -->
        <div class="pp-main">
            <div class="pp-sidebar">
                <div class="item">
                    <div class="icon">
                        <i class="fa-solid fa-house"></i>
                    </div>
                    <div class="menu-name">
                        Home
                    </div>
                </div>
                <div class="item">
                    <div class="icon">
                        <i class="fa-solid fa-clipboard-user"></i>
                    </div>
                    <div class="menu-name">
                        내정보
                    </div>
                    <div class="sub-menu d-none">
                        <div class="sub-item">
                            내정보 관리
                        </div>
                        <div class="sub-item">
                            근태 관리
                        </div>
                        <div class="sub-item">
                            연차 관리
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="icon">
                        <i class="fa-solid fa-paste"></i>
                    </div>
                    <div class="menu-name">
                        전자결재
                    </div>
                    <div class="sub-menu d-none">
                        <div class="sub-item">
                            기안문 작성
                        </div>
                        <div class="sub-item">
                            결제 진행함
                        </div>
                        <div class="sub-item">
                            전체문서함
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="icon">
                        <i class="fa-solid fa-envelope"></i>
                    </div>
                    <div class="menu-name">
                        쪽지함
                    </div>
                    <div class="sub-menu d-none">
                        <div class="sub-item">
                            쪽지함1
                        </div>
                        <div class="sub-item">
                            쪽지함2
                        </div>
                        <div class="sub-item">
                            쪽지함3
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="icon">
                        <i class="fa-solid fa-pen-to-square"></i>
                    </div>
                    <div class="menu-name">
                        게시판
                    </div>
                    <div class="sub-menu d-none">
                        <div class="sub-item">
                            게시판1
                        </div>
                        <div class="sub-item">
                            게시판2
                        </div>
                        <div class="sub-item">
                            게시판3
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="icon">
                        <i class="fa-solid fa-address-book"></i>
                    </div>
                    <div class="menu-name">
                        주소록
                    </div>
                    <div class="sub-menu d-none">
                        <div class="sub-item">
                            주소록1
                        </div>
                        <div class="sub-item">
                            주소록2
                        </div>
                        <div class="sub-item">
                            주소록3
                        </div>
                    </div>
                </div>
                
                <div class="item" data-group=" ">
                    <div class="icon">
                        <i class="fa-solid fa-calendar-days"></i>
                    </div>
                    <div class="menu-name">
                        캘린더
                    </div>
                    <div class="sub-menu d-none" data-group="calendar">
                    	<div class="sub-item" data-url="calendar1">
                            <a href="calendar">전체 일정 확인</a>
                        </div>
                        <div class="sub-item" data-url="calendar2">
                            나의 일정 추가
                        </div>
                        <div class="sub-item" data-url="calendar3">
                            부서 일정 추가
                        </div>
                        <div class="sub-item"data-url="calendar4">
                           회의실 예약
                        </div>
                    </div>
                </div>
            </div>  <!-- sidebar -->
            
            <script>
            	function calendar-main(){
            		$('#postForm').attr('action', 'updateForm.bo').submit();
            	};
            </script>
            
            
            
            

            <!-- 대분류 메뉴 클릭시 펼쳐지는 사이드바 영역 -->
            <div class="pp-sub-sidebar">
                <!--
                    script에 작성되어 있는 onclick_item() 메소드로 해당 영역에 sub-menu가 이동됨
                -->
            </div>  <!-- pp-sub-sidebar -->

            <!-- <div class="pp-content">
            
            </div> -->  <!-- content -->

        </div>  <!-- pp-main -->
    </div>  <!-- pp-outter -->

</body>

<script>
	
	$(function() {
		let path_arr = window.location.pathname.split('/');
		let len = path_arr.length;
		let url = path_arr[len -1];
		console.log(url);
	});

	//<!-- pp-content(자식요소)를 pp-main안으로 이동시킨다 -->
	$(function(){
	    let main = document.querySelector('.pp-main');
	    let content = document.querySelector('.pp-content');
	    main.appendChild(content);
	});

    // 사이드바 메뉴 아이콘 클릭시 onclick_item() 메소드 실행되도록 즉시실행 함수 작성
    $(function () {

        let items = document.querySelectorAll('.pp-sidebar .item');

        for(let item of items){
            item.addEventListener('click', onclick_item);
        }
    });

    function onclick_item(){

        // 1) 현재 선택한 item을 target 변수에 저장 > 선택한 item class명에 .active 이 포함되어 있는지 확인
        let target = event.currentTarget; 
        let is_checked = target.classList.contains('active');

        // 2) 모든 item의 active 상태를 해제 (여러 개의 메뉴가 선택되어 있으면 안되니까)
        let items = document.querySelectorAll('.pp-sidebar .item');
        for(let item of items){
            item.classList.remove('active');
        }

        // 3) 선택한 item만 active class 추가 - active된 menu는 background-color 적용
        target.classList.add('active');

        // 4-1) 선택한 item의 숨겨진 sub_menu를 이동시키기 위해 변수 저장 후 옮김
        let sub_menu = target.querySelector('.sub-menu');
        let sub_sidebar = document.querySelector('.pp-sub-sidebar');
        sub_sidebar.innerHTML = sub_menu.innerHTML;
        
        // 4-2) sub_menu가 없는 경우 sub_sidebar를 비운뒤 숨김
        if(sub_menu == null) {
            sub_sidebar.innerHTML = '';
            sub_sidebar.classList.add('d-none'); 
            return;
        }

        // 5) sub_sidebar의 숨김 처리를 해제
        // 단, 같은 item을 선택한 경우는 숨김 **
        if(is_checked)
            sub_sidebar.classList.remove('d-none');
    	}

</script>
</html>