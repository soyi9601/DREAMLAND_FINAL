<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../layout/header.jsp" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.16/jstree.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.16/themes/default/style.min.css" />

	<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="text-nowrap mb-2">부서관리</h4>   
	  <blockquote class="blockquote mt-3">
       <p class="mb-0">찾는 부서나 구성원이 있으시면 검색해주세요.</p>
    </blockquote>
    <div class="col-12 col-lg-6 mb-4">
      <div class="row g-0">
        <div class="col-md-6">
          <input type="text" class="form-control" id="departSearch" placeholder="사원 및 부서를 입력해주세요.">
        </div>
      </div>
    </div>
    <div>
      <div id="jsTree"></div>
    </div>
	</div>

	<script>
	$(document).ready(function() {
		const departAdmin = () => {
			fetch('/depart/depart_admin.do')
				.then(response => response.json())
				.then(data => {
				  console.log(data);
				  var nodes = [];
				  data.forEach(item =>{
					  var deptNode = {
						  id: item.deptNo,
						  parent: item.parentId === '#' ? '#':item.parentId,
						  text: item.treeText,
						  icon: 'bx bxs-spreadsheet',
						  type: 'default'
					  };
					  nodes.push(deptNode);				 
					  if(item.employee !== null) {
						  var empNode = {
					 	    id: item.employee.empNo,
					 	    parent: item.deptNo,
						    text: item.employee.empName,
						    icon: 'bx bxs-user-rectangle',
						    type: 'file'
						  };
						  nodes.push(empNode);
					  }
				  });			
				  console.log(nodes);
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
		            			"updateInfo": {
		            				label: '정보수정',
		            				action: function(obj) {
		            					var empNo = $node.id;
		            					window.location.href = 'editEmployee?empNo=' + empNo;
		            				}
		            			},
		            			"delete": {
		                    label: "삭제",
		                    action: function (obj) {
		                      tree.delete_node($node);
		                    }
		                  }
		            		};
		            	} else {
			                return {
				                "rename": {
				                  label: "이름변경",
				                  action: function (obj) {
					                	tree.edit($node);
				                  }
				                },
				                "delete": {
		                      label: "삭제",
		                      action: function (obj) {
		                        tree.delete_node($node);
		                      }
		                    }
			                };	            		
		            	}
		            }
		          }
			    });
			    $('#jsTree').on('rename_node.jstree', function(e, data) {			    	
			    	fetch('/depart/updateNode', {
			    		method: 'POST',
			    		headers: {
			    			'Content-Type': 'application/json'
			    		},
			    	  body: JSON.stringify({
			    		  deptNo: data.node.id,       // 부서 번호
		    		    deptName: data.node.text,   // 부서 이름
		    		    parentId: data.node.parent, // 상위 부서 번호
		    		    treeText: data.node.text,   // 트리 텍스트
			    	  })
			    	}).then(response => response.json())
			    	  .then(response => console.log('Node renamed:', response))
			    	  .catch(error => console.error('Error rename node:', error));
			      }).on('delete_node.jstree', function(e, data) {
			    	var isDepart = data.node.type === 'default';
			    	var deleteNo = isDepart ? {deptNo: data.node.id} : {empNo: data.node.id};
		        var url = isDepart ? '/depart/deleteDepart' : '/depart/deleteEmployee';
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
		    })
				.catch(error => console.log('Error node:', error));	
		};
		
	departAdmin();
	
	$('#departSearch').keyup(function() {
	  var searchString = $(this).val();
	  $('#jsTree').jstree('search', searchString);
  });
	
	});
	
	</script>

<%@ include file="../layout/footer.jsp" %>    