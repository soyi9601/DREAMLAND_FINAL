/**
 * 작성자 : 이소이
 * 기능   : jstree 조직도 구현, 노드 클릭 시 폼 입력
 * 이력   :
 *    1) 240520
 *        - jstree 조직도 구현
 *    2) 240528
 *        - 노드 클릭 시 폼 입력
 */
  
$(document).ready(function() {
  const departAdmin = () => {
    fetch('/depart/departAdmin.do')
      .then(response => response.json())
      .then(data => {
        console.log(data);
        var nodes = [];
        data.forEach(item => {
          var deptNode = {
            id: item.deptNo,
            parent: item.parentId === '#' ? '#':item.parentId,
            text: item.treeText,
            icon: 'bx bxs-spreadsheet',
            type: 'default'
          };
          nodes.push(deptNode);     
          if (item.employee !== null && item.employee.length > 0) {
            item.employee.forEach(emp => {
              if (emp.empNo !== 0 && emp.resignDate === null) {
                var empNode = {
                  id: emp.empNo,
                  parent: item.deptNo,
                  text: emp.empName,
                  icon: 'bx bxs-user-rectangle',
                  type: 'file'
                };
                nodes.push(empNode);
              }
            });             
          }
        });     
        console.log(nodes.empNode);
        // 트리 생성
        $('#jsTree').jstree({
          plugins: ['search', 'types', 'themes', 'contextmenu'],
          core: {
            data: nodes,    //데이터 연결   
            check_callback : true, 
          },
          types: {
            'default': {
              'icon': 'jstree-folder'
            },
            'file': {
              'icon': 'jstree-file',
            }
          },
          search : {
            'show_only_matches' : true,
            'show_only_matches_children' : true,
          },         
          contextmenu: { 
            items: function($node) {
              var tree = $('#jsTree').jstree(true);
              if($node.type === 'file') {
                return {
                  "delete": {
                    label: "삭제",
                    action: function (obj) {
                      deleteEmployeeNode($node.id);
                    }
                  }
                };
              } else {
                return {
                  "delete": {
                    label: "삭제",
                    action: function (obj) {
                      deleteDepartNode($node.id);
                    }
                  }
                };                  
              }
            }
          }
        });
        /*
        $('#jsTree').on('delete_node.jstree', function(e, data) {
          var isDepart = data.node.type === 'default';
          var deleteNo = isDepart ? {deptNo: data.node.id} : {empNo: data.node.id};
          var url = isDepart ? '/depart/removeDepart' : '/depart/removeEmployee';
          fetch(url, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify(deleteNo)
          }).then(response => {
              if (response.ok) {
                return response.json(); // JSON 응답을 파싱하여 반환
              } else {
                throw new Error('Network 응답 실패');
              }
          }).then(data => {alert(data.message);})
            .catch(error => console.error('Error deleting node:', error));
        });
        */
      })
      .catch(error => console.log('Error node:', error)); 
      
    const deleteEmployeeNode = (empNo) => {
      fetch('/depart/removeEmployee', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({empNo})
      }).then(response => response.json())
        .then(data => {
          alert(data.message);
          if (data.message === "직원이 삭제되었습니다.") {
            // 삭제가 실패한 경우 해당 노드를 jstree에서 수동으로 제거
            $('#jsTree').jstree(true).delete_node(empNo);
          }
        }).catch(error => console.error('Error deleting node:', error));

    };
    
    const deleteDepartNode = (deptNo) => {
      fetch('/depart/removeDepart', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({deptNo})
      }).then(response => response.json())
        .then(data => {
          alert(data.message);
          if (data.message === "부서가 삭제되었습니다.") {
            // 삭제가 실패한 경우 해당 노드를 jstree에서 수동으로 제거
            $('#jsTree').jstree(true).delete_node(deptNo);
          }
        }).catch(error => console.error('Error deleting node:', error));

    }
  };    

  departAdmin();

  // 부서 및 직원 검색 키 이벤트 바인딩
  $('#departSearch').keyup(function() {
    var searchString = $(this).val();
    $('#jsTree').jstree('search', searchString);
  });

  // 노드 클릭 이벤트
  $('#jsTree').on('select_node.jstree', function(e, data) {
    var node = data.node;
    console.log(node);
    if(node.type === 'file') {
      fetch('/depart/getEmployeeInfo?empNo=' + node.id, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json'
        }
      })
      .then(response => response.json())
      .then(empData => {
        $('#empForm').show();
        $('#deptForm').hide();
        $('#emp-no').val(empData.empNo);
        $('#emp-name').val(empData.empName);
        $('#birth').val(empData.birth);
        $('#empPw').val(empData.empPw);
        $('#emp-mobile').val(empData.mobile);
        $('#emp-email').val(empData.email);
        $('#emp-dept-no').val(empData.deptNo);
        $('#pos-no').val(empData.posNo);
        $('#enterDate').val(empData.enterDate);
        $('#role').val(empData.role);
      })
      .catch(error => console.error('Error fetching employee info:', error));
    } else {
      fetch('/depart/getDepartInfo?deptNo=' + node.id, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json'
        },
      })
      .then(response => response.json())
      .then(deptData => {
         $('#empForm').hide();
         $('#deptForm').show();
         $('#dept-no').val(deptData.deptNo);
         $('#dept-name').val(deptData.deptName);
         $('#parent-id').val(deptData.parentId);
      })
      .catch(error => console.error('Error fetching department info:', error));
    }   
  })
  
  // 직원 정보 수정 이벤트
  document.getElementById('frm-modify-emp').addEventListener('click', (evt) => {
    evt.preventDefault(); // 폼 기본 제출 동작 막기
    // 폼 데이터를 가져와서 서버로 전송
    var empFormData = {
      empNo: $('#emp-no').val(),
      empName: $('#emp-name').val(),
      birth: $('#birth').val(),
      empPw: $('#empPw').val(),
      mobile: $('#emp-mobile').val(),
      email: $('#emp-email').val(),
      deptNo: $('#emp-dept-no').val(),
      posNo: $('#pos-no').val(),
      enterDate: $('#enterDate').val(),
      role: $('#role').val()
    };
    $.ajax({
      url: '/depart/editEmployee.do',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(empFormData),
      dataType: 'json',
      success: function(response) {
        alert('수정이 완료되었습니다.');
      },
      error: function(xhr, status, error) {
        console.error('Error editing employee:', error);
      }
    });
  });
  
  // 부서 정보 수정 이벤트
  document.getElementById('frm-modify-dept').addEventListener('click', (evt) => {
    evt.preventDefault(); // 폼 기본 제출 동작 막기
    // 폼 데이터를 가져와서 서버로 전송
    var deptFormData = {
      deptName: $('#dept-name').val(),
      deptNo: $('#dept-no').val(),
      parentId: $('#parent-id').val(),
    };
    $.ajax({
      url: '/depart/editDepart.do',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(deptFormData),
      dataType: 'json',
      success: function(response) {
        alert('부서 수정이 완료되었습니다.');
      },
      error: function(xhr, status, error) {
        console.error('Error editing department:', error);
      }
    });
  });

});
