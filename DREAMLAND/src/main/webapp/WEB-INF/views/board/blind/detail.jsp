<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee"
    value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />



<!-- Content wrapper -->
<div class="content-wrapper sd-board" id="blind-board-detail">
    <!-- Content -->

    <div class="container-xxl flex-grow-1 container-p-y">
        <div class="title sd-point">익명게시판</div>

        <!-- Basic Layout & Basic with Icons -->
        <div class="row">
            <!-- Basic Layout -->
            <div class="col-xxl board-detail">
                <div class="card mb-4 sd-notice-detail">

                    <div class="card-body">
                        <!-- 익명게시판 내용 시작-->
                        <!-- 게시글 번호 :  ${blind.blindNo}-->
                        <div class="board-title-area">
                          <div class="board-title">
                            ${blind.boardTitle}
                          </div>
                          <div class="board-title-etc-area">
                            <div class="board-title-etc">
                              <p>
                                <i class='bx bx-show'></i>
                                <span>${blind.hit}</span> 
                              </p>
                              <p>
                                <i class='bx bx-time-five'></i>
                                <span>${blind.boardCreateDt}</span>
                              </p>
                              <p>
                                <i class='bx bx-comment'></i>
                                <span class="comment-count"></span>
                              </p>
                            </div>
                            <div class="board-title-btns">
                            
                              
                              <form id="frm-btn" method="POST">  
                                <input type="hidden" name="blindNo" value="${blind.blindNo}">
                                <button type="button" id="btn-edit" class="btn btn-warning btn-sm">편집</button>
                                <button type="button" id="btn-remove" class="btn btn-danger btn-sm">삭제</button>
                              </form>
                            </div>
                          </div>
                          
                        </div>
                        
                        <div class="board-contents">
                          ${blind.boardContents}
                        </div>
                        
                        <!-- 댓글등록 창-->
                        <div>
                          <form id="frm-comment">
                            <input type="hidden" name="blindNo" value="${blind.blindNo}">
                            <textarea id="comment-contents" class="form-control" name="contents" placeholder="댓글을 작성해주세요!"></textarea>
                            <input type="password" id="comment-password" class="form-control" name="commentPassword" placeholder="password">
                            <button type="button" id="btn-comment-registrer" class="sd-btn sd-point-bg sd-btn-none">등록</button> 
                            <p class="notice">
                             ※ 비밀번호를 입력해주세요! 
                             <br class="a">잊어버릴경우, 댓글 삭제가 불가능합니다.
                            </p>
                          </form>
                        </div>
                        <!-- 댓글등록 창 끝-->
                        
                        <!-- 댓글목록 시작-->
                        <div>
                          <div class="frm-comment-top" > 
                            <i class='bx bx-comment'></i>
                            <span class="comment-count"></span>
                          </div>
                          <div id="comment-list"></div>
                          <div id="paging"></div>
                        </div>
                        <!-- 댓글목록 끝-->
                        
                        
                    </div>
                </div>
                
                <div class="sd-btn sd-point-bg list-btn">
                  <a href="${contextPath}/board/blind/list.page" class="notice-list-btn" style="color:white">목록</a>
                </div>
                
            </div>
        </div>
    </div>
</div>




<!-- 게시글 편집삭제 모달창 -->
<div id="boardPwModal" style="display:none;">
  <form id="boardPasswordForm" 
        method="POST" >
    <input type="hidden" name="blindNo" value="${blind.blindNo}">
    <label for="password">비밀번호 입력</label>
    <input type="password" id="board-password" name="password">
    <button type="submit" id="submit-btn" >Submit</button>
  </form>
</div>   


<!-- 댓글편집삭제 모달창 시작-->
<div id="commentModal" style="display:none;">
  <form id="commentPasswordForm" 
        method="POST" >
    <input type="hidden" name="commentNo" value="${comment.commentNo}">
    <label for="comment-modal-pw">Enter Password:</label>
    <input type="password" id="comment-modal-pw" name="commentPassword">
    <button type="submit" id="submit-btn2" >Submit</button>
  </form>
</div>
<!-- 댓글편집삭제 모달창 끝-->

<script>
    
//----------------------------게시글 편집, 삭제 js
let type;
 
// 비밀번호받는 창 보임 & 편집(eidt) or 삭제(remove)
function boardPwType(x) {
  type = x;
  document.getElementById('boardPwModal').style.display = 'block';
}

// 1. btn-edit 편집버튼 누르면 passwordModal창 뜨도록 
document.getElementById('btn-edit').addEventListener('click', () => {
    boardPwType('edit');
});
 
var frmBtn = document.getElementById('frm-btn');
 
 // 삭제버튼 누름
document.getElementById('btn-remove').addEventListener('click', () => {
  //관리자일 경우 , 바로 삭제
  if(${loginEmployee.role eq 'ROLE_ADMIN' }){
    if(confirm('해당 게시물을 삭제하시겠습니까?')){
      frmBtn.action = '${contextPath}/board/blind/removeBlind.do';
      frmBtn.submit();
    }
  }
  if(${loginEmployee.role ne 'ROLE_ADMIN' }){
    boardPwType('remove');
  }
});
 

//모달창에 비밀번호 입력 후 전송버튼 클릭시
document.getElementById('boardPasswordForm').addEventListener('submit', (e) => {
  e.preventDefault();
  submitPassword();
});

function submitPassword() {
  
  const password = document.getElementById('board-password').value;
  const blindNo = document.querySelector('[name="blindNo"]').value;
    
  if (password) {
      
    if(type === 'edit'){
      validateEdit(blindNo, password);
    }else if(type === 'remove'){
      validateRemove(blindNo, password);
    }
      
  } else {
      alert("비밀번호를 입력해주세요.");
  }

  document.getElementById('boardPwModal').style.display = 'none';
}


// 비밀번호 맞을시, 편집 
function validateEdit(blindNo, password) {
  fetch('${contextPath}/board/blind/validateEdit.do', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: new URLSearchParams({ blindNo: blindNo, password: password })
  })
  .then(response => response.json())
  .then(data => {
    // alert(data);
    if (data.success) {
        window.location.href = '${contextPath}/board/blind/edit.do?blindNo='+blindNo
            /*'${contextPath}/board/blind/edit.do?blindNo='+blindNo*/
            /*'${contextPath}/board/blind/edit.do'*/
    } else {
        alert(data.message );
    }
  });
}
//비밀번호 맞을시, 삭제      
function validateRemove(blindNo, password) {
  fetch('${contextPath}/board/blind/validateRemove.do', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: new URLSearchParams({ blindNo: blindNo, password: password })
  })
  .then(response => response.json())
  .then(data => {
      // alert(data);
      if (data.success) {
          window.location.href = '${contextPath}/board/blind/removeBlind.do?blindNo='+blindNo
      } else {
          alert(data.message);
      }
  });
} 
      
//----------------------------댓글등록, 삭제 js
// 댓글등록
const fnRegisterComment = () => {
 $('#btn-comment-registrer').on('click', (e) => {
	 
	 const commentContents = $('#comment-contents').val();
	 const commentPassword = $('#comment-password').val();
	 
   if (!commentContents) {
     alert('댓글 내용을 입력해주세요.');
     return;
   }

	 
   if (!commentPassword) {
       alert('비밀번호를 입력해주세요.');
       return;
   }
	 
   $.ajax({
     type:'POST',
     url:'${contextPath}/board/blind/regitserComment.do',
     data:$('#frm-comment').serialize(),
     dataType:'json',
     success:(resData) => {
       if(resData.insertCount === 1){
         updateCommentCount('${blind.blindNo}');
         alert('댓글이 등록되었습니다.');
         $('#comment-contents').val('');
          fnCommentList();
       }else{
         alert('댓글 등록이 실패했습니다.')
       }
     },
     error:(jqXHR) => {
       alert(jqXHR.statusText + '(' + jqXHR.status + ')');
     }
   })
 })
}



// 댓글 불러오기
let page = 1;
const fnCommentList = () => {
   
   $.ajax({
      type:'get',
      url:'${contextPath}/board/blind/comment/list.do',
      data:'blindNo=${blind.blindNo}',
      dataType:'json',
      success: (resData) => {
        console.log(resData.commentList);
        const commentList = $('#comment-list');
        //const paging = $('#paging');
        commentList.empty();
        //paging.empty();
        if(resData.commentList.length == 0) {
          commentList.append('<div></div>');
          //paging.empty();
          
         $('.comment-count').text(resData.commentList.length);
         $('#comment-count').text(resData.commentList.length);
          
          return;
        }
        let commentCount = 0; // 댓글 수 초기화
        $.each(resData.commentList, (i, comment)=>{
          let str = '';
          if(comment.depth==0){
            str += '<div class="comment-div">';
          } else{
            str += '<div class="comment-reply-div">';
          }
          
          if(comment.delYn === 'Y'){
            str +='<div class="deleted-comment">삭제된 댓글입니다.</div>';
          }else{
            str += '<div class="comment-area">'
            str += '  <span> 익명 </span>';
            str += '  <div class="comment">'+ comment.contents + '</div>';
            str += '  <div class="comment-bottom">'
            str += '    <div class="date"><i class="bx bx-time-five"></i>날짜'+resData.commentList.length+'</div>'
            str += '    <div class="comment-btns-area"><i class="bx bx-dots-horizontal"></i>'
            str += '    <div class="comment-btns blind">'
              if(comment.depth === 0) {
                str += '  <button type="button" class="btn-reset btn-reply sd-btn sd-point-bg">답글</button>';
              }
            
            str += '      <button type="button" class="btn-reset btn-remove-comment sd-btn sd-danger-bg "  data-comment-no="' + comment.commentNo + '">삭제</button>';
            str += '  </div>'
            str+='  </div>'
            
            str += '</div></div>'
            /*
            if(comment.depth === 0) {
              str += '<button type="button" class="btn btn-success btn-reply">답글</button>';
            }
            // 삭제 버튼 (내가 작성한 댓글에만 삭제 버튼이 생성됨)
            
            if(Number('${sessionScope.user.userNo}') === comment.user.userNo) {
            }
            
            str += '<button type="button" class="btn btn-danger btn-remove-comment" data-comment-no="' + comment.commentNo + '">삭제</button>';
            */
;           }
          /************************ 답글 입력 화면 ************************/
          if(comment.depth === 0) {          
            str += '<div class="div-frm-reply blind">';
            str += '  <form class="frm-reply">';
            str += '    <input type="hidden" name="groupNo" value="' + comment.groupNo + '">';
            str += '    <input type="hidden" name="blindNo" value="${blind.blindNo}">';
            
            str += '    <textarea name="contents" class="reply-contents form-control" placeholder="답글 입력"></textarea>';
            
            str += '      <input type="password" id="comment-password" class="form-control" name="commentPassword" placeholder="password">'
            
            str += '    <button type="button" class="btn-reset sd-btn sd-point-bg btn-register-reply">등록</button>';
            str += '  </form>';
            str += '</div>';
            str += '</div>'
          }
          /****************************************************************/
          // 댓글 닫는 <div>
          str += '</div>';
          // 목록에 댓글 추가
          commentList.append(str);
          
          if (comment.delYn !== 'Y') {
            commentCount++; // 댓글 수 증가
        }
          
        })
         $('.comment-count').text(resData.commentList.length);
         $('#comment-count').text(resData.commentList.length);
        //paging.append(resData.paging);
      },
      error: (jqXHR) => {
        alert(jqXHR.statusText + '(' + jqXHR.status + ')');
      }
   })
}


const fnPaging = (p) => {
    page = p;
    fnCommentList();
  }


// 버튼 누르면 댓글, 삭제 창 나오게

const fnShowBtns = () => {
  $(document).on('click', '.comment-btns-area', (e) => {
    e.stopPropagation(); // 이벤트 전파 중단
    const commentBtns = $(e.target).closest('.comment-btns-area').find('.comment-btns');
    if (commentBtns.hasClass('blind')) {
      commentBtns.removeClass('blind');
    } else {
      commentBtns.addClass('blind');
    }
  });

  $(document).on('click', (e) => {
    const commentBtns = $('.comment-btns');
    commentBtns.addClass('blind');
  });
};


// ---------------------------------------- 답글(Reply)등록
const fnRegisterReply = () => {
 $(document).on('click', '.btn-register-reply', (evt)=>{
   
   const replyContents = $(evt.target).closest('.frm-reply').find('.reply-contents').val();
   const replyPassword = $(evt.target).closest('.frm-reply').find('input[name="commentPassword"]').val();

   if (!replyContents) {
       alert('답글 내용을 입력해주세요.');
       return;
   }

   if (!replyPassword) {
       alert('비밀번호를 입력해주세요.');
       return;
   }
	 
   $.ajax({
     type:'POST',
     url:'${contextPath}/board/blind/comment/registerReply.do',
     data:$(evt.target).closest('.frm-reply').serialize(),
     dataType:'json',
     success: (resData) => {
       if(resData.insertReplyCount === 1) {
          alert('답글이 등록되었습니다.');
          $(evt.target).prev().val('');
          fnCommentList();
        } else {
          alert('답글 등록이 실패했습니다.');
        }
     },
     error: (jqXHR) => {
        alert(jqXHR.statusText + '(' + jqXHR.status + ')');
      }
   })
 })
}


//답글 입력 창 보이기/숨기기
const fnSwitchingReplyInput = () => {
  $(document).on('click', '.btn-reply', (evt) => {
    const divReplyInput = $(evt.target).closest('.comment-div').find('.div-frm-reply')
   
    console.log(divReplyInput)
    if(divReplyInput.hasClass('blind')){
      //$('.div-frm-reply').addClass('blind');
      divReplyInput.removeClass('blind');
    } else {
      divReplyInput.addClass('blind');
    }
  })
}


let commentType;
let commentNo;

function commentPwType(x, commentNo) {
  commentType = x;
  document.getElementById('commentModal').style.display = 'block';
  //alert(commentNo+ '뱉어');
}



//댓글 삭제
const fnRemoveComment = () => {
  $(document).on('click', '.btn-remove-comment', (evt) => {
    //fnCheckSignin();
    if(!confirm('해당 댓글을 삭제할까요?')){
      return;
    }
      // 요청
      /*
    $.ajax({
      type: 'post',
      url: '${contextPath}/board/blind/removeComment.do',
      data: 'commentNo=' + $(evt.target).data('commentNo'),
      // 응답
      dataType: 'json',
      success: (resData) => {  // resData = {"removeResult": "댓글이 삭제되었습니다."}
        alert(resData.removeResult);
        fnCommentList();
      }
    })
    원래코드
    */
    commentNo = $(evt.target).data('commentNo')
    //return commentNo;
    commentPwType('remove', commentNo);
    //alert(commentNo);
  })
}

//비밀번호 입력 후 전송버튼 클릭시
document.getElementById('commentPasswordForm').addEventListener('submit', (e) => {
    e.preventDefault();
    submitPw();
});

function submitPw() {
  
  const password = document.getElementById('comment-modal-pw').value;
  //const commentNo = document.querySelector('[name="commentNo"]').value;
  
  alert('확인중 '+ password +' 확인중'+ commentNo)
  if (password) {
          
      if(commentType === 'edit'){
          //validateEdit(blindNo, password);
      }else if(commentType === 'remove'){
          validatePw(commentNo, password);
      }
      
  } else {
      alert("비밀번호를 입력해주세요.");
  }

  document.getElementById('pwModal').style.display = 'none';
}

function validatePw(commentNo, pw) {
  fetch('${contextPath}/board/blind/validatePw.do', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: new URLSearchParams({ commentNo: commentNo, pw: pw })
  })
  .then(response => response.json())
  .then(data => {
          // alert(data);
      if (data.success) {
          //window.location.href = '${contextPath}/board/blind/removeComment.do?commentNo='+commentNo
          removeComment(commentNo)
      } else {
          alert(data.message);
      }
  });
} 
//ajax뺌
const removeComment = (commentNo) => {
    $.ajax({
    type: 'GET',
    url: '${contextPath}/board/blind/removeComment.do',
    data: 'commentNo=' +commentNo,
    // 응답
    dataType: 'json',
    success: (resData) => {  // resData = {"removeResult": "댓글이 삭제되었습니다."}
      alert(resData.removeResult);
      fnCommentList();
    }
  })
}



///


function updateCommentCount(blindNo) {
    // 댓글 수 갱신을 위한 AJAX 요청
    $.ajax({
        type: 'GET',
        url: '${contextPath}/board/blind/comment/count.do',
        data: { blindNo: blindNo },
        dataType: 'json',
        success: function(data) {
            // 성공적으로 데이터를 받아왔을 때
            if (data.success) {
                // 받아온 댓글 수로 화면 갱신
                const commentCountSpan = $('.board-title-etc span');
                commentCountSpan.text(data.commentCount);
            } else {
                // 실패한 경우에 대한 처리 (예: 알림 메시지 표시 등)
                console.error('댓글 수 갱신에 실패하였습니다.');
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            // AJAX 요청 실패 시 처리
            console.error('댓글 수 갱신 AJAX 요청 중 에러 발생:', textStatus, errorThrown);
        }
    });
}




//함수목록★
fnRegisterComment();
fnCommentList();
fnRegisterReply();    
fnSwitchingReplyInput();   
fnShowBtns();

fnRemoveComment();


  </script>

<%@ include file="../../layout/footer.jsp"%>