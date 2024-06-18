<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
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
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<!-- include moment.js -->
<script src="/resources/assets/moment/moment-with-locales.min.js"></script> 


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
                          <div class="board-title" data-board-create-dt="${blind.boardCreateDt}">
                            <c:if test="${blind.commentCount >= 5}">
                              <span class="new rounded-pill bg-label-danger">hot</span>
                            </c:if>
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
                                <span> <fmt:formatDate value="${blind.boardCreateDt}" pattern="yyyy.MM.dd HH:mm"/></span>
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
                          <form id="frm-comment" method="post">
                            <input type="hidden" name="blindNo" value="${blind.blindNo}">
                            <textarea id="comment-contents" class="form-control" name="contents" placeholder="댓글을 작성해주세요!"></textarea>
                            <input type="password" id="comment-password" class="form-control" name="commentPassword" placeholder="password">
                            <button type="submit" id="btn-comment-registrer" class="sd-btn sd-point-bg sd-btn-none">등록</button> 
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


<!-- 모달창 -->

<div class="pop">
  <div class="pop_x">
    <span class="material-symbols-outlined">cancel</span>
  </div>
  
  <!-- 게시글 비밀번호: 편집,삭제 -->
  <div id="boardPwModal" style="display:none;">
    <form id="boardPasswordForm" 
          method="POST" >
      <input type="hidden" name="blindNo" value="${blind.blindNo}">
      <label for="password">비밀번호 입력</label>
      <div class="align">
        <input type="password" id="board-password" name="password" class="form-control">
        <button type="submit" id="submit-btn" class="btn-reset sd-btn sd-point-bg">입력</button>
      </div>
    </form>
  </div>
  
  <!-- 댓글 비밀번호:삭제 -->
  <div id="commentModal" style="display:none;">
    <form id="commentPasswordForm" 
          method="POST" >
      <input type="hidden" name="commentNo" value="${comment.commentNo}">
      <label for="comment-modal-pw">비밀번호 입력</label>
      <div class="align">
        <input type="password" id="comment-modal-pw" name="commentPassword" class="form-control">
        <button type="submit" id="submit-btn2" class="btn-reset sd-btn sd-point-bg" >입력</button>
      </div>
    </form>
  </div>  
</div>
<div class="pop_bg" ></div>

<script>
    
// ※ ----------------------------게시글 편집, 삭제 js
let type;
 
// 비밀번호받는 모달창 보임 & 편집(eidt) or 삭제(remove)
function boardPwType(x) {
  type = x;
  document.getElementById('boardPwModal').style.display = 'block';
  $('#board-password').focus();
}

// 1. btn-edit 편집버튼 누르면 passwordModal창 뜨도록 
document.getElementById('btn-edit').addEventListener('click', () => {
    $('.pop_bg, .pop').show();
    boardPwType('edit');
});

// 모달창 사라짐
$('.pop_bg, .pop_x').click(function(){
  $('.pop_bg, .pop').stop(true,true).fadeOut("fast");
  document.getElementById('boardPwModal').style.display = 'none';
  return false;
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
    if(confirm('해당 게시물을 삭제하시겠습니까?')){
      $('.pop_bg, .pop').show();
      boardPwType('remove');
    }
  }
});
 

//모달창에 비밀번호 입력 후 전송버튼 클릭시
document.getElementById('boardPasswordForm').addEventListener('submit', (e) => {
  e.preventDefault();
  submitPassword();
});

//편집/삭제버튼 구분 & 전송된 비밀번호 확인 
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
  $('.pop_bg, .pop').hide();
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
    if (data.success) {
      const frmBtn = document.getElementById('frm-btn');
      frmBtn.action = '${contextPath}/board/blind/edit.do';
      frmBtn.submit();
    } else {
      alert('비밀번호가 일치하지 않습니다.');
      $('#board-password').val("");
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
    if (data.success) {
      window.location.href = '${contextPath}/board/blind/removeBlind.do?blindNo='+blindNo
    } else {
      alert('비밀번호가 일치하지 않습니다.');
      $('#board-password').val("");
    }
  });
} 
      
//※----------------------------댓글등록, 삭제 js
// 댓글등록
const fnRegisterComment = () => {
 $('#frm-comment').on('submit', (e) => {
   
   const commentContents = $('#comment-contents').val();
   const commentPassword = $('#comment-password').val();
   
   if (!commentContents) {
     alert('댓글 내용을 입력해주세요.');
     return;
   }

   if (!commentPassword) {
     alert('비밀번호를 입력해주세요.');
     $('#comment-password').focus();
     e.preventDefault();
     return;
   }
   
   $.ajax({
     type:'POST',
     url:'${contextPath}/board/blind/regitserComment.do',
     data:$('#frm-comment').serialize(),
     dataType:'json',
     success:(resData) => {
       if(resData.insertCount === 1){
         alert('댓글이 등록되었습니다.');
         $('#comment-contents').val('');
         $('#comment-password').val('');
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
        //console.log(resData.commentList);
        const commentList = $('#comment-list');
        commentList.empty();
        if(resData.commentList.length == 0) {
          commentList.append('<div></div>');
         $('.comment-count').text(resData.commentList.length);
         $('#comment-count').text(resData.commentList.length);
          return;
        }
        let commentCount = 0; 
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
            
              //시간 moment함수
              const publishTime = moment(comment.createDt);
              const now = moment();
              const diffHours = now.diff(publishTime, 'hours');
            
            str += '      <div class="date"><i class="bx bx-time-five"></i>&nbsp;'+ publishTime.locale('ko').fromNow()+'</div>'
            str += '      <div class="comment-btns-area"><i class="bx bx-dots-horizontal"></i>'
            str += '        <div class="comment-btns blind"><div class="arrow"></div> '
              if(comment.depth === 0) {
                str += '      <button type="button" class="btn-reset btn-reply sd-btn sd-point-bg">답글</button>';
              }
            
            str += '          <button type="button" class="btn-reset btn-remove-comment sd-btn sd-danger-bg "  data-comment-no="' + comment.commentNo + '">삭제</button>';
            str += '        </div>'
            str+='        </div>'
            str += '     </div>'
            str += '    </div>';
              }
          /************************ 답글 입력 화면 ************************/
          if(comment.depth === 0) {          
            str += '<div class="div-frm-reply blind">';
            str += '  <form class="frm-reply">';
            str += '    <input type="hidden" name="groupNo" value="' + comment.groupNo + '">';
            str += '    <input type="hidden" name="blindNo" value="${blind.blindNo}">';
            str += '      <textarea name="contents" class="reply-contents form-control" placeholder="답글 입력"></textarea>';
            str += '    <input type="password" id="comment-password" class="form-control" name="commentPassword" placeholder="password">'
            str += '    <button type="submit" class="btn-reset sd-btn sd-point-bg btn-register-reply">등록</button>';
            str += '  </form>';
            str += '</div>';         
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
      },
      error: (jqXHR) => {
        alert(jqXHR.statusText + '(' + jqXHR.status + ')');
      }
   })
}

/* 삭제예정
const fnPaging = (p) => {
    page = p;
    fnCommentList();
  }
*/

// 버튼 누르면 댓글, 삭제 창 나오게
const fnShowBtns = () => {
  $(document).on('click', '.comment-btns-area', (e) => {
    e.stopPropagation(); 
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
   
    if(divReplyInput.hasClass('blind')){
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
  $('.pop_bg, .pop').show();
  document.getElementById('commentModal').style.display = 'block';
  $('#comment-modal-pw').focus();
}



//댓글 삭제
const fnRemoveComment = () => {
  $(document).on('click', '.btn-remove-comment', (evt) => {
    if(!confirm('해당 댓글을 삭제할까요?')){
      return;
    }
    commentNo = $(evt.target).data('commentNo')
    commentPwType('remove', commentNo);
  })
}

//비밀번호 입력 후 전송버튼 클릭시
document.getElementById('commentPasswordForm').addEventListener('submit', (e) => {
    e.preventDefault();
    submitPw();
});

function submitPw() {
  const password = document.getElementById('comment-modal-pw').value;
  if (password) {
    if(commentType === 'edit'){
    }else if(commentType === 'remove'){
      validatePw(commentNo, password);
    }
  } else {
    alert("비밀번호를 입력해주세요.");
  }
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
      if (data.success) {
        removeComment(commentNo)
      } else {
        alert('비밀번호가 일치하지 않습니다.');
        $('#comment-modal-pw').val("");
      }
  });
} 

/* */
//ajax 따로 뺌
const removeComment = (commentNo) => {
    $.ajax({
    type: 'GET',
    url: '${contextPath}/board/blind/removeComment.do',
    data: 'commentNo=' +commentNo,
    // 응답
    dataType: 'json',
    success: (resData) => {
      $('.pop_bg, .pop').stop(true,true).fadeOut("fast");
      fnCommentList();
    }
  })
}


const fnTitleNew = () => {
  const boardTitleElement = document.querySelector(".board-title");
  const boardCreateDt = boardTitleElement.getAttribute("data-board-create-dt");
  const now = moment();
  const boardCreateMoment = moment(boardCreateDt);
  
  if (now.diff(boardCreateMoment, 'hours') < 24) {
    const str = '<span class="new rounded-pill bg-label-success">new</span>'
    $(".board-title").prepend(str);
  }
}




//함수목록★
fnRegisterComment();
fnCommentList();
fnRegisterReply();    
fnSwitchingReplyInput();   
fnShowBtns();
fnRemoveComment();
fnTitleNew();


</script>

<%@ include file="../../layout/footer.jsp"%>