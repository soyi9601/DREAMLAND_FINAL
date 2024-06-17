/**
 * 작성자 : 이소이
 * 기능   : 부서 등록 및 세부 소속부서 불러오기
 * 이력   :
 *    1) 240613
 *        - 부서 등록 및 세부 소속부서 불러오기
 */
  
/* *********** 부서정보 불러오기 *********** */
$(document).ready(function() {
  
  // 세부부서 가져오기
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
  
  /* *********** 부서 등록 *********** */
  $('#frm-add-department').submit(function(evt) {
    let deptName = $('#dept-name').val();
    let deptNo = $('#dept-no').val();
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
  });
  
  /* *********** 부서 번호 체크 *********** */
  $('#dept-no').blur(function() {
    fnCheckDeptNo();
  });
  
});
 

/* *********** 부서 번호 체크 *********** */ 
const fnCheckDeptNo = () => {
  
  let deptNo = $('#dept-no').val();
  let msgDeptNo = $('#deptNo-result');
  
  if(deptNo) {
    $.ajax({
      url:'/depart/checkDeptNo',
      type: 'GET',
      data: {deptNo: deptNo},
      success: function(data) {
        if (data.check) {
          msgDeptNo.html('중복된 부서번호입니다. 다시 확인해주세요');
          msgDeptNo.css('color', 'red');
        } else {
          msgDeptNo.html('사용 가능한 부서번호입니다.');
          msgDeptNo.css('color', '#ccc');
        }
      },
      error: function(error) {
        console.error('Error:', error);
        msgDeptNo.html('오류가 발생했습니다. 다시 시도해 주세요.');
        msgDeptNo.css('color', 'red');
      }
    });
  } else {
    msgDeptNo.html('');
  }  
}
  





/* ********************** 함수 호출 ********************** */

/* ********************** ********* ********************** */
   