		// ------------------------------------------------------------------
		// 메시지 읽은 경우 tr 색상 변경
		// ------------------------------------------------------------------
		$(function(){
			let table = document.querySelector('.tb-message');
			let trs = table.querySelectorAll('tbody tr');
			console.log(trs);
			
			for(let tr of trs){
				if(tr.children[7].children[0].classList.contains('fa-envelope-open')){
					tr.style.color = 'darkgray';
					tr.style.fontWeight = 'normal';
				}
			}
			
			$('.select-user').select2({
				placeholder: "받는 사람",
				allowClear: true,
 				language: {
			       noResults: function() {return "검색결과가 없습니다";}
			   },
			   dropdownCssClass: "text-sm"
			});
		})
		
		// ------------------------------------------------------------------
		// 메시지 읽음설정 버튼 클릭
		// ------------------------------------------------------------------
		function toggleReadBtn(inputs) {
			// 읽음 / 안읽음 상태 변경
			let read_yn_btn = document.getElementById('readYN');
			
			// 하나라도 안읽은게 있으면 true
			// 그렇지 않으면 false
			let token = true;
			for(let input of inputs){
				if(input.checked == false)
					continue;
				
				let tr   = input.parentElement.parentElement;
				let icon = tr.children[7].children[0];
				if(icon == null)
					continue;
				
				token = icon.classList.contains('fa-envelope');
				if(token)
					break;
			}
			
			read_yn_btn.innerHTML = token ? '읽음' : '안읽음';		// 클래스명에 fa-envelope가 포함되어 있는게 1개라도 있으면
		}
		
		function readMessage(){
			let table = document.querySelector('.tb-message');
			let inputs = table.querySelectorAll('tr input');
			
			let message_no_list = [];
			let icon_list = [];
			
			let read_yn_btn = document.getElementById('readYN');
			let token = read_yn_btn.textContent == '읽음';
			
			for(let input of inputs) {
				if(input.checked == false)
					continue;
				
				let tr   = input.parentElement.parentElement;
				let icon = tr.children[7].children[0];
				if(icon == null)
					continue;
				
				icon_list.push(icon);
				message_no_list.push(parseInt(input.value));
				
			}
			
			$.ajax({
 				url : 'readMessage',
				type : 'get',
				data : { 
							messageNoList : message_no_list,
					 		readYN : token					// token이 true로 넘어오면 읽음 / false인 경우 안읽음
						},
				success : function(result){
					if(!result) {
						console.log('작업 실패');
						return;
					}
					
					for (let icon of icon_list) {
						if(!token) {
							icon.classList.remove('fa-envelope-open');
							icon.classList.add('fa-envelope');
							
							let tr = icon.parentElement.parentElement;
							tr.style.color = '';
							tr.style.fontWeight = '';		
						} else {
							icon.classList.add('fa-envelope-open');
							icon.classList.remove('fa-envelope');
							
							let tr = icon.parentElement.parentElement;
							tr.style.color = 'darkgray';
							tr.style.fontWeight = 'normal';
						}
					}

					read_yn_btn.textContent = token ? '안읽음' : '읽음';
				},	// success
				error : function(result){
					console.log('통신오류! 실패');
				},	// error
			});	// ajax
		}	// readMessage
		
		
 		
		// ------------------------------------------------------------------
		// 메시지 작성 modal창 실행
		// ------------------------------------------------------------------
		function messageForm(){
			$('#messageForm').modal('show');
		}	// messageForm
		
		 
		// ------------------------------------------------------------------
		// 체크박스 선택 / 해제 기능
		// ------------------------------------------------------------------
		// 전체 체크박스
		function checkAll(){
			
			
			let table = document.querySelector('.tb-message');
			let inputs = table.querySelectorAll('tr input');
			
			for(let input of inputs){
				input.checked = event.target.checked;
			}
			
			toggleReadBtn(inputs);
		}	// checkAll
		
		// 체크박스
		function checkOnce(){
			
			let table = document.querySelector('.tb-message');
			let hd_input = table.querySelector('th').querySelector('input');
			let inputs = table.querySelector('tbody').querySelectorAll('tr input');
			
			let is_all_checked = true;
			for(let input of inputs){
				if(input.checked == false){
					is_all_checked = false;
					break;
				}
			}
			hd_input.checked = is_all_checked;
			
			toggleReadBtn(inputs);
		}	// checkOnce
		
		
		// ------------------------------------------------------------------
		// 메시지 상세보기
		// ------------------------------------------------------------------
 		function detailMessage(){
			
			let content = event.currentTarget; //target.children[4];
			let input = content.parentElement.querySelector('td input');
			let message_no = input.value;
			console.log(input);
			console.log(input.value);
			
			location.href = 'detailMessage?mno=' + message_no;

			
		}	// detailMessage
			
		
		// ------------------------------------------------------------------
		// 메시지 삭제 ajax
		// ------------------------------------------------------------------
		function deleteMessage(){

			
			// 모든 테이블의 tr행 가져오기
			let trs = document.querySelectorAll('.table tr');
			// 체크확인용 변수 선언
			let checked_tr = null;
			
			// 체크된 input요소 확인 후 체크가 되어있다면 체크확인용 변수에 담고 break
 			for(let tr of trs){
				let input = tr.querySelector('input');
				if(input.checked){
					checked_tr = tr;
					break;
				}
			}
			
			// 체크되어 있는 메시지가 없을 경우 alert창 발생
  			if(checked_tr == null){
  				Swal.fire('실패', '삭제할 메시지를 선택해주세요!', 'warning');
  				return;
  			} 
			
  			// 체크가 되어있는 경우 confirm창 발생
			Swal.fire({
				title: "메시지를 삭제하시겠습니까?",
				text : "※ 삭제된 메시지는 휴지통으로 이동합니다. ",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: "#DD6B55",
				confirmButtonText: "삭제",
				cancelButtonText: "취소"
				}).then((result) => {
					if (!result.isConfirmed) {
					  return;
					}
					
  					let table = document.querySelector('.tb-message');			
					let trs = table.querySelectorAll('tbody tr');		// 데이터 행 부분
					let message_del_list = [];
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						if(input.checked == true){
							let messageNo = input.value;
							console.log(messageNo);
							message_del_list.push(messageNo);
						}
					}
					console.log(message_del_list);
					
 			$.ajax({
 				url : 'deleteMessage',
				type : 'get',
				data : { messageNoList : message_del_list },
				dataType: 'json',
				success : function(result){
					
					Swal.fire('성공', '메시지가 휴지통으로 이동되었습니다!', 'success');
					
 					let listCount = document.getElementById('messageListCount');
 					let total = parseInt(listCount.textContent);
 					// console.log(listCount);
					// console.log(total);
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						let messageNo = parseInt(input.value);
						// console.log(messageNo);
						
						if(result.includes(messageNo)){
							tr.remove();
							total--;
							// console.log(total);				// 전체 조회수에서 -- count되는지 확인ok
							
							listCount.textContent = total;	// remove total 값 넣어주기
						}
					}
				},	// success
				error : function(result){
					Swal.fire('실패', '휴지통으로 이동되지 않았습니다<br>다시 시도해주세요', 'warning');
					console.log('통신오류! 실패');
				},	// error
			});	// ajax
			});		// confrim	 
		}	// deleteMessage
		
		
		// ------------------------------------------------------------------
		// 메시지 보관 ajax
		// ------------------------------------------------------------------
		function storageMessage(){
			
			// 모든 테이블의 tr행 가져오기
			let trs = document.querySelectorAll('.table tr');
			// 체크확인용 변수 선언
			let checked_tr = null;
			
			// 체크된 input요소 확인 후 체크가 되어있다면 체크확인용 변수에 담고 break
 			for(let tr of trs){
				let input = tr.querySelector('input');
				if(input.checked){
					checked_tr = tr;
					break;
				}
			}
			
			// 체크되어 있는 메시지가 없을 경우 alert창 발생
  			if(checked_tr == null){
  				Swal.fire('실패', '보관 메시지를 선택해주세요!', 'warning');
  				return;
  			}
			
  			// 체크가 되어있는 경우 confirm창 발생
			Swal.fire({
				title: "메시지를 보관하시겠습니까?",
				text : "※ 받은 메시지 보관함으로 이동합니다.",
				icon: 'question',
				showCancelButton: true,
				confirmButtonColor: "#DD6B55",
				confirmButtonText: "보관",
				cancelButtonText: "취소"
				}).then((result) => {
					if (!result.isConfirmed) {
					  return;
					}
					
  					let table = document.querySelector('.tb-message');			
					let trs = table.querySelectorAll('tbody tr');		// 데이터 행 부분
					let message_list = [];
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						if(input.checked == true){
							let messageNo = input.value;
							console.log(messageNo);
							message_list.push(messageNo);
						}
					}
					console.log(message_list);
					
 			$.ajax({
 				url : 'storageMessage',
				type : 'get',
				data : { messageList : message_list },
				dataType: 'json',
				success : function(result){
					
					Swal.fire('성공', '메시지가 보관함으로 이동되었습니다!', 'success');
					
 					let listCount = document.getElementById('messageListCount');
 					let total = parseInt(listCount.textContent);
 					console.log(listCount);
					console.log(total);
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						let messageNo = parseInt(input.value);
						console.log(messageNo);
						
						if(result.includes(messageNo)){
							tr.remove();
							total--;
							console.log(total);				// 전체 조회수에서 -- count되는지 확인ok
							
							listCount.textContent = total;	// remove total 값 넣어주기
						}
					}
				},	// success
				error : function(result){
					Swal.fire('실패', '보관함으로 이동되지 않았습니다<br>다시 시도해주세요', 'warning');
					console.log('통신오류! 실패');
				},	// error
			});	// ajax
			});		// confrim
		}	// storageMessage
		
		
		// ------------------------------------------------------------------
		// 메시지 북마크 ajax
		// ------------------------------------------------------------------
		function bookmark_msg(){
			event.stopPropagation();
			
			let target = event.currentTarget;
			let message_no = target.getAttribute('data-no');
			let bookmark_YN = target.classList.contains('fa-solid');	// true or false
			console.log(bookmark_YN);
						
			$.ajax({
 				url : 'bookmarkMsg',
				type : 'get',
				data : { messageNo : message_no,
						bookmarkYN : bookmark_YN
						 },
				success : function(result){
					
					if(result){
						target.classList.remove('fa-regular');	// 빈 별
						target.classList.add('fa-solid');		// 색칠 별
					} else {
						target.classList.remove('fa-solid');
						target.classList.add('fa-regular');
					}
					
					// console.log(target);	
				},	// success
				error : function(result){
					console.log('통신오류! 실패');
				},	// error
			});	// ajax
		}	// bookmark_msg
		
		
		// ------------------------------------------------------------------
		// 받은메시지로 이동 기능 ajax
		// ------------------------------------------------------------------
		function moveMessageBox(){
			
			let trs = document.querySelectorAll('.table tr');
			let checked_tr = null;
			
 			for(let tr of trs){
				let input = tr.querySelector('input');
				if(input.checked){
					checked_tr = tr;
					break;
				}
			}
  			if(checked_tr == null){
  				Swal.fire('실패', '이동할 메시지를 선택해주세요!', 'warning');
  				return;
  			}
			
			Swal.fire({
				title: "메시지를 이동하시겠습니까?",
				text : "※ 선택한 메시지는 받은 메시지함으로 이동합니다.",
				icon: 'question',
				showCancelButton: true,
				confirmButtonColor: "#DD6B55",
				confirmButtonText: "삭제",
				cancelButtonText: "취소"
				}).then((result) => {
					if (!result.isConfirmed) {
					  return;
					}
					
  					let table = document.querySelector('.tb-message');			
					let trs = table.querySelectorAll('tbody tr');		// 데이터 행 부분
					let message_list = [];
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						if(input.checked == true){
							let messageNo = input.value;
							console.log(messageNo);
							message_list.push(messageNo);
						}
					}
					console.log(message_list);
					
 			$.ajax({
 				url : 'moveMessageBox',
				type : 'get',
				data : { message_list : message_list },
				dataType: 'json',
				success : function(result){
					
					Swal.fire('성공', '메시지가 보관함으로 이동되었습니다!', 'success');
					
 					let listCount = document.getElementById('messageListCount');
 					let total = parseInt(listCount.textContent);
 					// console.log(listCount);
					// console.log(total);
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						let messageNo = parseInt(input.value);
						// console.log(messageNo);
						
						if(result.includes(messageNo)){
							tr.remove();
							total--;
							// console.log(total);				// 전체 조회수에서 -- count되는지 확인ok
							
							listCount.textContent = total;	// remove total 값 넣어주기
						}
					}
				},	// success
				error : function(result){
					Swal.fire('실패', '메시지함으로 이동되지 않았습니다<br>다시 시도해주세요', 'warning');
					console.log('통신오류! 실패');
				},	// error
			});	// ajax
			});		// confrim	 
		}	// moveMessageBox
	
	// ------------------------------------------------------------------
	// 받은메시지로 복구 기능 ajax
	// ------------------------------------------------------------------
		function moveMessageBox(){
			let trs = document.querySelectorAll('.table tr');
			let checked_tr = null;
			
 			for(let tr of trs){
				let input = tr.querySelector('input');
				if(input.checked){
					checked_tr = tr;
					break;
				}
			}
  			if(checked_tr == null){
  				Swal.fire('실패', '이동할 메시지를 선택해주세요!', 'warning');
  				return;
  			}
  			
  			Swal.fire({
				title: "메시지를 복구하시겠습니까?",
				text : "※ 선택한 메시지는 받은 메시지함으로 이동합니다.",
				icon: 'question',
				showCancelButton: true,
				confirmButtonColor: "#DD6B55",
				confirmButtonText: "삭제",
				cancelButtonText: "취소"
				}).then((result) => {
					if (!result.isConfirmed) {
					  return;
					}
					
  					let table = document.querySelector('.tb-message');			
					let trs = table.querySelectorAll('tbody tr');		// 데이터 행 부분
					let message_list = [];
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						if(input.checked == true){
							let messageNo = input.value;
							console.log(messageNo);
							message_list.push(messageNo);
						}
					}
					console.log(message_list);
					
 			$.ajax({
 				url : 'moveMessageBox',
				type : 'get',
				data : { message_list : message_list },
				dataType: 'json',
				success : function(result){
					
					Swal.fire('성공', '메시지가 보관함으로 이동되었습니다!', 'success');
					
 					let listCount = document.getElementById('messageListCount');
 					let total = parseInt(listCount.textContent);
 					// console.log(listCount);
					// console.log(total);
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						let messageNo = parseInt(input.value);
						// console.log(messageNo);
						
						if(result.includes(messageNo)){
							tr.remove();
							total--;
							// console.log(total);				// 전체 조회수에서 -- count되는지 확인ok
							
							listCount.textContent = total;	// remove total 값 넣어주기
						}
					}
				},	// success
				error : function(result){
					Swal.fire('실패', '메시지함으로 이동되지 않았습니다<br>다시 시도해주세요', 'warning');
					console.log('통신오류! 실패');
				},	// error
			});	// ajax
			});		// confrim	 
		}	// moveMessageBox

		
		// ------------------------------------------------------------------
		// 메시지 영구삭제 기능 ajax
		// ------------------------------------------------------------------
		function deletePermanentlyMessage(){
			
			let trs = document.querySelectorAll('.table tr');
			let checked_tr = null;
			
 			for(let tr of trs){
				let input = tr.querySelector('input');
				if(input.checked){
					checked_tr = tr;
					break;
				}
			}
  			if(checked_tr == null){
  				Swal.fire('실패', '삭제할 메시지를 선택해주세요!', 'warning');
  				return;
  			}
  			
  			Swal.fire({
				title: "메시지를 삭제하시겠습니까?",
				text : "※ 영구 삭제한 메시지는 복구가 불가능합니다!",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: "#DD6B55",
				confirmButtonText: "삭제",
				cancelButtonText: "취소"
				}).then((result) => {
					if (!result.isConfirmed) {
					  return;
					}
					
  					let table = document.querySelector('.tb-message');			
					let trs = table.querySelectorAll('tbody tr');		// 데이터 행 부분
					let message_list = [];
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						if(input.checked == true){
							let messageNo = input.value;
							console.log(messageNo);
							message_list.push(messageNo);
						}
					}
					console.log(message_list);
					
 			$.ajax({
 				url : 'deletePermanentlyMessage',
				type : 'get',
				data : { message_list : message_list },
				dataType: 'json',
				success : function(result){
					
					Swal.fire('성공', '메시지가 영구 삭제되었습니다!', 'success');
					
 					let listCount = document.getElementById('messageListCount');
 					let total = parseInt(listCount.textContent);
 					// console.log(listCount);
					// console.log(total);
					
					for(let tr of trs){
						let input = tr.querySelector('input');
						let messageNo = parseInt(input.value);
						// console.log(messageNo);
						
						if(result.includes(messageNo)){
							tr.remove();
							total--;
							// console.log(total);				// 전체 조회수에서 -- count되는지 확인ok
							
							listCount.textContent = total;	// remove total 값 넣어주기
						}
					}
				},	// success
				error : function(result){
					Swal.fire('실패', '메시지가 삭제되지 않았습니다<br>다시 시도해주세요', 'warning');
					console.log('통신오류! 실패');
				},	// error
			});	// ajax
			});		// confrim	 
		}	// permanentDelete