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
        <div class="col-md-1"></div>
        <div class="col-md-2">
          <button type="button" class="btn btn-primary">검색</button>
        </div>
      </div>
    </div>
    <div>
      <div id="jsTree"></div>
    </div>
	</div>

	<script>
	const departAdmin = () => {
		$.ajax({
			type: 'GET',
			url: '/depart/depart_admin.do',
			dataType: 'json',
			success: (data) => {
			 console.log(data);
			 var company = [];
	      // 데이터 받아옴
		    $.each(data, function(idx, item){
		      company[idx] = {id:item.deptName, parent:item.parentId, text:item.treeText};
		    });	
		    console.log(company);
		    // 트리 생성
		    $('#jsTree').jstree({
	        core: {
	                data: company,    //데이터 연결	                
	            },
	            types: {
	                   'default': {
	                        'icon': 'jstree-folder'
	                    }
	            },
	            plugins: ['dnd', 'search', 'types', 'themes']
		    });
		    
	      $('#departSearch').keyup(function () {
	        if(to) { clearTimeout(to); }
	        to = setTimeout(function () {
	          var v = $('#departSearch').val();
	          $('#jsTree').jstree(true).search(v);
	        }, 250);
	      });
			},
			error: (data) => {
	      alert('데이터 오류');
	    }
		})		
	}
	
	departAdmin();
	</script>

<%@ include file="../layout/footer.jsp" %>    