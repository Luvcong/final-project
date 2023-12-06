<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
   <!-- 부트스트립트 -->
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
   <!-- font-awesome (icon) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- SweetAlert2 추가 -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/smartEditor/js/HuskyEZCreator.js"></script>
    
    <!-- css-->
   <link rel="stylesheet" href="resources/css/vacation.css">
   <style>
       .menu-link{
          background-color: white;
          border: none;
          width: 88%;
       }
       
       h2{
          text-align: center;
       }
       .infoTh th {
          font-weight: bolder;
          text-align: center;
          width: 20%;
       }
       .infoTh td {
          width: 50%;
       }
       .aprvTh th {
          font-weight: bolder;
          text-align: center;
       }
       .aprvTd {
          height: 40px;
          text-align: center;
       }
       input::placeholder {
           text-align: center;
       }
       .form-control[readonly]{
          background-color: white;
          height: 50px;
       }
   </style>
</head>
<body>
<jsp:include page="../common/sidebar.jsp" />
<div class="pp-content">
   <script>
       $(document).ready(function(){
           // 파일 개수 3개제한
           $('#addFile').click(function(){
               if ($('.approvalFiles').length >= 3) {
                   Swal.fire({
                       icon: 'warning',
                       title: '경고',
                       text: '최대 3개의 파일만 첨부할 수 있습니다.',
                   });
               } else if ($('.approvalFiles').last().val() == ''){
                   Swal.fire({
                       icon: 'warning',
                       title: '경고',
                       text: '빈 파일 업로드가 있습니다.',
                   });
               } else {
                   var newInput = $('<input class="form-control approvalFiles" type="file" name="multipartFile"><br>');
                   $('#files').append(newInput);
               }
           });
           
           $('#removeFile').click(function(){
               var visibleFiles = $('.approvalFiles:visible');
               if (visibleFiles.length === 1) {
                   if (visibleFiles.val() !== "") {
                       visibleFiles.val("");
                   } else {
                       Swal.fire({
                           icon: 'warning',
                           title: '경고',
                           text: '더 이상 삭제할 파일이 없습니다.',
                       });
                   }
               } else {
                   visibleFiles.last().prev().remove(); // 직전의 <input>을 제거
                   visibleFiles.last().remove(); // 현재 <input>을 제거
               }
           });
           
           // 파일 용량 3MB 제한 / 확장자 제한
           $(document).on("change", "input[name='multipartFile']", function() {
               var maxSize = 3 * 1024 * 1024;
               var allowedExtensions = ["xlsx", "docs", "hwp", "pdf", "pptx", "ppt", "jpg", "jpeg", "png"];
               
               var file = this.files[0];
               var fileSize = file.size;
               var fileExtension = file.name.split('.').pop().toLowerCase();
               
               if (fileSize > maxSize) {
                   Swal.fire({
                       icon: 'warning',
                       title: '용량을 확인하세요',
                       text: '3MB 이내로 등록 가능합니다.',
                   });
                   $(this).val('');
                   return false;
               }
   
               if (allowedExtensions.indexOf(fileExtension) === -1) {
                   Swal.fire({
                       icon: 'warning',
                       title: '확장자를 확인하세요',
                       text: '업로드 가능 확장자 : xlsx, docs, hwp, pdf, pptx, ppt, jpg, jpeg, png',
                   });
                   $(this).val('');
                   return false;
               }
           });
       });
   </script>

   <script>
   
   $(document).ready(function() {
       $('#docCatCd').on('change', function() {
           var selectedValue = $(this).val();
           changeForm(selectedValue);
       });
   
       function changeForm(selectedValue) {
           if (selectedValue === "03") {
               $('#03').show();
               $('#01').hide();
           } else if (selectedValue === "01") {
               $('#03').hide();
               $('#01').show();
           }
       }
       
       // 최초 로딩 시 select의 값을 확인하여 초기 폼 설정
       $('#docCatCd').trigger('change');
   });
   //폼 데이터 전송 함수
   let refSelected = '';
   </script>

   <script>
      function apSubmit(e){
         
         var empId = $(e).children()[0].textContent;
         var empName = $(e).children()[2].textContent;
      
           // 오른쪽 화살표 첫번째 버튼 동작 구현
           $('#rightArrowButtonFirst').click(function() {
               const memberIdInputFirst = $('.memberIdInputFirst');
               const memberNameInputFirst = $('.memberNameInputFirst');
   
               memberIdInputFirst.val(empId);
               memberNameInputFirst.val(empName);
               
               $('#firstApproverNo').attr("value", empId);
           	   $('#firstApproverName').html(empName);
           	   
           });
   
           // 오른쪽 화살표 두번째 버튼 동작 구현
           $('#rightArrowButtonSecond').click(function() {
                   const memberIdInputSecond = $('.memberIdInputSecond');
                   const memberNameInputSecond = $('.memberNameInputSecond');
   
                   memberIdInputSecond.val(empId);
                   memberNameInputSecond.val(empName);
                   
                   $('#secondApproverNo').attr("value", empId);
            	   $('#secondApproverName').html(empName);
           });
   
           // 오른쪽 화살표 세번째 버튼 동작 구현
           $('#rightArrowButtonThird').click(function() {
                   const memberIdInputThird = $('.memberIdInputThird');
                   const memberNameInputThird = $('.memberNameInputThird');
   
                   memberIdInputThird.val(empId);
                   memberNameInputThird.val(empName);
                   
                   $('#thirdApproverNo').attr("value", empId);
               	   $('#thirdApproverName').html(empName);
           });
      }   
           
   </script>

   <script>
      let approvalLine = [];
       $(document).ready(function() {
           let selectedUsers = []; // 선택된 사용자 정보를 저장하는 배열
   
           // 체크박스 클릭 이벤트
           $('.userCheckbox').click(function() {
               // 다른 체크박스 선택 해제
               $('.userCheckbox').not(this).prop('checked', false);
   
               if ($(this).prop('checked')) {
                   const memberId = $(this).val();
                   const memberName = $(this).data('username');
   
                   // 선택된 사용자 정보를 배열에 추가
                   selectedUsers.push({ memberId, memberName });
               } else {
                   // 선택 해제된 경우 배열에서 제거
                   const memberId = $(this).val();
                   const indexToRemove = selectedUsers.findIndex(user => user.memberId === memberId);
                   if (indexToRemove !== -1) {
                       selectedUsers.splice(indexToRemove, 1);
                   }
               }
           });


        // 모달 추가 버튼 클릭 시
        $('.modalAddUserToDeptBtn').click(function() {
            // 선택된 사용자 정보를 확인하기 위해 콘솔에 출력
            console.log(selectedUsers);

            // 선택된 사용자 정보를 HTML 요소에 표시
            displaySelectedApprovers(selectedUsers);

            // 선택된 사용자 정보 배열 초기화
            selectedUsers = [];

            // 모달을 닫습니다.
            $('#modal2').modal('hide');
        });

       // 모달 닫힘 이벤트를 감지하여 선택된 값 초기화
       $('#modal2').on('hidden.bs.modal', function () {
           // 선택된 체크박스 초기화
           $('.userCheckbox').prop('checked', false);
   
           // 선택된 결재자 정보를 HTML 요소에 초기화
           $('#firstApproverName').text("");
           $('#secondApproverName').text("");
           $('#thirdApproverName').text("");
   
           // 선택된 결재자 정보를 입력한 input 요소 초기화
           $('.memberIdInputFirst').val("");
           $('.memberNameInputFirst').val("");
           $('.memberIdInputSecond').val("");
           $('.memberNameInputSecond').val("");
           $('.memberIdInputThird').val("");
           $('.memberNameInputThird').val("");
   
           // 선택된 사용자 정보 배열 초기화
           selectedUsers = [];
       });
   </script>

   <script>
      //FormData 객체 생성
      var formData = new FormData(document.getElementById('selectedUsers')); // #myForm은 폼의 ID입니다.
      
      // 추가 데이터를 JavaScript 객체로 생성
      var additionalData = {
          key1: 'approvalLine'
      };
      
      // 추가 데이터를 formData에 추가
      $.each(additionalData, function(key, value) {
          formData.append(key, value);
      });
   </script>

   <script>
      document.addEventListener("DOMContentLoaded", function() {
        const toggleButtons = document.querySelectorAll(".toggle-users");
      
        toggleButtons.forEach(button => {
          button.addEventListener("click", () => {
            const userList = button.nextElementSibling;
            userList.style.display = userList.style.display === "none" ? "block" : "none";
          });
        });
      });
   </script>

   <script>
       // 문서 종류 선택 변경 이벤트 핸들러
       $("#documentType").on("change", function() {
           // 선택한 문서 종류 값 가져오기
           var selectedValue = this.value;
   
           // doc_cat_cd 설정
           var docCatCd = (selectedValue === "expense") ? "01" : "03";
   
           // 폼 요소에 숨겨진 필드로 doc_cat_cd 설정
           document.getElementById("doc_cat_cd").value = docCatCd;
       });
   </script>


   <script>
      $(document).ready(function(){
         let today = dayjs().format('YYYY-MM-DD');
         $('#today').text(today);
      })
   </script>
<!-- Layout wrapper -->
   <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
         <!-- 입력 레이아웃 -->
         <div class="layout-page">
            <!-- Content wrapper -->
            <div class="content-wrapper">
                  <!-- Content -->
                  <div class="container-xxl flex-grow-1 container-p-y">
                     <div class="card">
                     <!-- Basic Layout -->
                     <div class="row">
                        <div class="col-xl">
                           <div class="card-header">
                              <h2 class="mb-0"><strong>문&nbsp;서&nbsp;작&nbsp;성</strong></h2>
                           </div>
                           <!-- 구분선 -->
                           <hr class="m-0">
                               <div class="card-body">
                                   <form id="approvalForm" method="post" enctype="multipart/form-data" action="insertEdms">
                                      <!-- 문서 상단 -->
                                      <div class="row" style="margin-bottom: 5px;">
                                         <!-- 기안자 정보 -->
                                         <div class="col-md-4">
                                            <table class="table table-sm table-bordered infoTh">
                                               <tbody>
                                                  <tr>
                                                     <th>기안자</th>
                                                     <td>${loginUser.empName}</td>
                                                  </tr>
                                                  <tr>
                                                     <th>부서명</th>
                                                     <td>${loginUser.deptName}</td>
                                                  </tr>
                                                  <tr>
                                                     <th>기안일</th>
                                                     <td>
                                                        <a id="today"></a>
                                                     </td>
                                                  </tr>
                                                  <tr>
                                                     <th>문서종류</th>
                                                     <td>
                                                     <select id="docCatCd" name="edmsCategory" class="form-select">
                                                         <option value="03">일반 문서</option>
                                                         <option value="01">휴가신청서</option>
                                                     </select>
                                                     </td>
                                                  </tr>
                                               </tbody>
                                            </table>
                                         </div>
                                         
                                         <div class="col-md-3">&nbsp;</div>
                                         
                                         <!-- 결재선 -->
                                         <div class="col-md-5 table-bordered" style="height: 122px;">
                                            <!-- 결재 -->
                                            <div class="row mb-1">
                                               <button class="col-sm-1 modalAddUserToDeptBtn" 
                                                     data-bs-toggle="modal" data-bs-target="#modal2" data-toggle="modal" data-target="#modal2"
                                                     style="font-weight: bolder; 
                                                           display: flex;
                                                        justify-content: center;
                                                        align-items: center;
                                                        border: 1px solid #d9dee3;
                                                        ">결재
                                          </button>
                                               <div class="col-sm-11">
                                                  <!-- 선택된 결재자 정보를 표시할 HTML 요소 -->
                                             <div id="selectedApprovers">
                                                 <p>첫 번째 결재자: <span id="firstApproverName"></span> <input type="hidden" id="firstApproverNo" name="empNo1"></p>
                                                 <p>두 번째 결재자: <span id="secondApproverName"></span> <input type="hidden" id="secondApproverNo" name="empNo2"></p>
                                                 <p>세 번째 결재자: <span id="thirdApproverName"></span> <input type="hidden" id="thirdApproverNo" name="empNo3"></p>
                                             </div>
                                                </div>
                                            </div>
                                         </div>
                                      </div>
                                      
                                 <!-- 신청양식 -->
                                 <div id="03" style="margin-top: 20px;">
                                     <!-- 제목 입력 -->
                                        <div class="mb-3">
                                           <input type="hidden" name="empNo" value="${loginUser.empNo}">
                                           <input type="text" name="edmsTitle" maxlength="50" class="form-control" placeholder="제목을 입력하세요" required="required"/>
                                        </div>
                                        <!-- 내용 입력 -->
                                    <div class="mb-1">
                                       <!-- 네이버 에디터 -->
                                       <textarea name="genContent"
                                               class="form-control"
                                               id="editor"
                                               placeholder="내용을 입력하세요"
                                               maxlength="2500" 
                                               style="
                                                  height: 380px;
                                                  width: 100%"
                                                      ></textarea>
                                       <script type="text/javascript">
                                            var oEditors = [];
                                            nhn.husky.EZCreator.createInIFrame({
                                                oAppRef: oEditors,
                                                elPlaceHolder: "editor",
                                                sSkinURI: "${pageContext.request.contextPath}/smartEditor/SmartEditor2Skin.html",  // 스킨 경로
                                                fCreator: "createSEditor2",
                                                htParams: {
                                                   bUseToolbar : true,
                                                   bUseVerticalResizer: false,
                                                   bUseModeChanger: false
                                                }
                                            });
                                            
                                            function submitContents(){
                                               oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD",[]);
                                            }
                        
                                            function submitForm() {
                                                var selectedValue = $('#docCatCd').val();
                                                if(selectedValue == '03'){
                                                   submitContents();
                                                }
                                                var formData = new FormData($('#approvalForm')[0]); // 폼 데이터를 가져오는 방식 변경
                                               formData.append("reference",refSelected)
                                                // 폼 데이터 전송 (AJAX 예제)
                                                $.ajax({
                                                    url: '/yeyebooks/approval/addApproval',
                                                    type: 'POST',
                                                    data: formData,
                                                    processData: false, // 중요: 폼 데이터를 jQuery가 자동으로 처리하지 않도록 설정
                                                    contentType: false, // 중요: 데이터 유형을 설정하지 않도록 설정
                                                    success: function(response) {
                                                        Swal.fire({
                                                           icon: 'success',
                                                           title: '성공',
                                                           text: '결재가 기안되었습니다.'
                                                        }).then(function(){
                                                           location.href="/yeyebooks/approval/approvalList";
                                                        })
                                                    },
                                                    error: function(error) {
                                                        // 오류 시 처리
                                                    }
                                                });
                                            }
                                        </script>
                                      </div>
                                 </div>
                                 <br>
                                 
         <!-- 휴가신청서 -->
         <div id="01" style="display: none; margin: 20px 0;">
         <table class="table table-sm table-bordered">
            <tbody style="text-align: center;">
               <table class="table-bordered" id="vacationTable">
               <tr>
                  <th class="vacation-th-size" style="width:150px;">휴가 구분</th>
                       <td style="width:200px;" colspan="7">
                          <select class="vctKind" style="width:100px;">
                             <option value="1">연차</option>
                             <option value="0.5">반차</option>
                          </select>
                       </td>
               </tr>
                   <tr>
                  <th style="width:150px;">일 시</th>
                       <td id="vct_date" style="width:400px;"><input type="date" name="vctStart" style="border:none;"> ~ <input type="date" name="vctEnd"></td>
                       <th style="width:150px;">기간</th>
                       <td style="width:270px;"><input type="text" value=""></td>
                       <th style="width:150px;">잔여 휴가</th>
                       <td style="width:270px;"><input type="text" readonly value="${loginUser.empAnnual - loginUser.empCount}">일</td>
                   </tr>
               <tr>
                  <th class="vacation-th-size">비 상 연 락 망</th>
                       <td id="vct_num" colspan="7"><input type="text" value="${ loginUser.empPhone }" style="width:200px;"></td>
                   </tr>
                   <tr>
                       <th class="vacation-th-size">사유</th>
                       <td colspan="7"><textarea rows="8" cols="100"></textarea></td>
                   </tr>
                 </table>
              </div>
                  <label for="files">첨부 파일:</label>
                      <button type="button" id="addFile" class="btn btn-primary btn-sm">추가</button>
                      <button type="button" id="removeFile" class="btn btn-primary btn-sm">삭제</button>
                  <div id="files" class="my-2">
                      <input class="form-control approvalFiles" type="file" name="multipartFile" multiple><br>
                  </div>
                  
                  <button type="submit" class='btn btn-primary' onclick="submitForm();"  style="float: right;">문서등록</button>
               </form>
                              <!-- 문서 끝 -->
                              <br>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
                    <!-- card End -->
            </div>
            <!-- / Content -->
         </div>
         <!-- / Content Wrapper -->
      </div>
         <!-- / Layout page -->
   </div>
   <!-- / Layout wrapper -->



<!--------------------------------------------------------------------------------->
   
      <!-- Modal -->
      <div class="modal fade" id="modal2" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content" style="width:1000px;">
            <div class="modal-header">
              <h5 class="modal-title" id="modalTitle2">결제선 지정</h5>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <form action="" method="post">
              <div class="modal-body pb-0 card" style="box-shadow: none;">
                <div class="row card-body vertical-scroll">

                  <div class="col-lg-6" style="width: 1000px; height: 500px;">
           <!-- 왼쪽 컨텐츠 내용 -->
            <h3>부서 목록</h3>
               <table class="table table-striped table-bordered">
               <thead>
                  <tr>
                  <ul>
                     <li><button type="button" class="HRdept btn" onclick="hrSubmit(this);">인사부</button></li>
                     <li><button type="button" class="HRdept btn" onclick="hrSubmit(this);">구매관리부</button></li>
                     <li><button type="button" class="HRdept btn" onclick="hrSubmit(this);">영업부</button></li>
                  </ul>
                  </tr>
                        <tr>
                           <th>사번</th>
                           <th>부서</th>
                           <th>성명</th>
                           <th>직급</th>
                        </tr>
               </thead>
               <tbody id="job_table"></tbody>
                  <div class="gm_box">
            <table class="table table-bordered app_jojigdo" id="appCheck">
             </table>
                     </div>
                  <div class="col-lg-6">

                    <!-- 오른쪽 컨텐츠 내용 -->
                    <h3>선택된 결재자</h3>
                      <table >
                        <!-- 선택된 결재자 목록 -->
                        <tr>
                          <td rowspan="2"><button type="button" id="rightArrowButtonFirst" class="btn btn-sm btn-secondary">&rarr;</button></td>
                          <td>첫 번째 결재자</td>
                        </tr>
                        <tr>
                          <td>
                             <input type="hidden" value="" name="memberId" class="memberIdInputFirst">
                               <input type="text" value="" name="memberName" class="memberNameInputFirst" readonly>
                          </td>
                        </tr>
                        <tr>
                          <td rowspan="2"><button type="button" class="btn btn-sm btn-secondary" id="rightArrowButtonSecond">&rarr;</button></td>
                          <td>두 번째 결재자</td>
                        </tr>
                        <tr>
                          <td>
                            <input type="hidden" value="" name="memberId" class="memberIdInputSecond">
                            <input type="text" value="" name="memberName" class="memberNameInputSecond" readonly>
                          </td>
                        </tr>
                        <tr>
                          <td rowspan="2"><button type="button" id="rightArrowButtonThird" class="btn btn-sm btn-secondary">&rarr;</button></td>
                          <td>세 번째 결재자</td>
                        </tr>
                        <tr>
                          <td>
                            <input type="hidden" value="" name="memberId" class="memberIdInputThird">
                            <input type="text" value="" name="memberName" class="memberNameInputThird" readonly>
                          </td>
                        </tr>
                      </table>
                      <button type="reset" class="btn btn-secondary" onclick="refReset();" style="float:right;">초기화</button>
                </div>

        <div class="modal-footer">
          <button type="button" id="okbutton" class="btn btn-primary" data-dismiss="modal" onclick="addLine();">추가</button>
        <button type="reset" class="btn btn-danger" data-dismiss="modal">취소</button>
        </div>
         </form>
    </div>
  </div>
</div>
                  <script>
                     function hrSubmit(e){
                        $.ajax({
                           url: 'organizationChart',
                           data : {deptName : e.innerText},
                           success: data=>{ 
                              let value = '';
                              for(i=0; i<data.length; i++){
                                 value += '<tr onclick="apSubmit(this);">'
                                        + '<td>' + data[i].empNo 	+ '</td>'
                                        + '<td>' + data[i].deptName + '</td>'
                                        + '<td>' + data[i].empName 	+ '</td>'
                                        + '<td>' + data[i].jobName	+ '</td>'
                                        + '</tr>'
                              }
                              $('#job_table').html(value);
                           },
                           error:()=>{
                              console.log('실패');
                           }
                        })
                     }
                     
                  </script>
            </form>
         </div>
      </div>
   </div>
</div>

   <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../assets/vendor/libs/popper/popper.js"></script>
    <script src="../assets/vendor/js/bootstrap.js"></script>
    <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="../assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="../assets/js/main.js"></script>

    <!-- Page JS -->
    <script src="../assets/js/ui-modals.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    </div>
</body>
</html>