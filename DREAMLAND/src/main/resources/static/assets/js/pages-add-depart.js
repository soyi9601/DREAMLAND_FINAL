/**
 * 작성자 : 이소이
 * 기능   : 부서 등록 및 세부 소속부서 불러오기
 * 이력   :
 *    1) 240613
 *        - 부서 등록 및 세부 소속부서 불러오기
 */
  
/* *********** 부서정보 불러오기 *********** */
// 세부부서 가져오기
$(document).ready(function() {
  $('#parent-id').change(function() {
    var selectedValue = $(this).val();
    if (selectedValue == '5000') {
      $('#parent-id').attr('name', 'parentIdDetail');
      $('#parent-id-detail').attr('name', 'parentId');
      
      $.ajax({
        url: '/depart/detailDepart.do', 
        type: 'GET',
        success: (response) => { 
          deptDetailOptions = response.deptDetailList; // 세부 부서 결과 저장
          var $deptDetailSelect = $('#parent-id-detail');
          $deptDetailSelect.empty(); // 기존 옵션들을 모두 제거
          if(deptDetailOptions.length > 0) {
            $deptDetailSelect.append(
              $('<option></option>').val('').text('세부 소속 없음')
            );
            $.each(deptDetailOptions, function(index, deptDetailList) {
              $deptDetailSelect.append(
                $('<option></option>').val(deptDetailList.deptNo).text(deptDetailList.deptName + '[' + deptDetailList.deptNo + ']')
              );
            });          
          } else {
              $deptDetailSelect.append(
                $('<option></option>').val('').text('세부 소속 없음')
            );
          }
        }
      });
    } else {
      $('#parent-id').attr('name', 'parentId');
      $('#parent-id-detail').attr('name', 'parentIdDetail');
      $('#parent-id-detail').empty();
      $('#parent-id-detail').append(
        $('<option></option>').val('').text('세부 소속 없음')
      );
    }
  });
});
  
  
/* *********** 부서 등록 *********** */
document.getElementById('frm-add-department').addEventListener('submit', (evt) => {  
  let deptName = document.getElementById('dept-name');
  let deptNo = document.getElementById('dept-no');
  var selectedValue = $('#parent-id').val();
  var selectedDetailValue = $('#parent-id-detail').val();
  
  if(deptName === '') {
    alert('부서명을 입력하세요');
    evt.preventDefault();
    return;
  } else if(deptNo === '') {
    alert('부서번호를 입력하세요');
    evt.preventDefault();
    return;
  } 
  
  if (selectedValue == '5000') {
    if (selectedDetailValue === '') {
      // 세부 소속 없음일 경우
      $('#parent-id').attr('name', 'parentId');
      $('#parent-id-detail').attr('name', ''); // 세부 소속 부서 번호는 빈 값으로 설정
    } else {
      // 세부 소속이 선택된 경우
      $('#parent-id').attr('name', ''); // 부모 부서 번호는 빈 값으로 설정
      $('#parent-id-detail').attr('name', 'parentId');
    }
  } else {
    // 다른 부서가 선택된 경우
    $('#parent-id').attr('name', 'parentId');
    $('#parent-id-detail').attr('name', ''); // 세부 소속 부서 번호는 빈 값으로 설정
  }
  
  this.submit();
})
   
   