<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp" /> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>


          <!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">인사관리 /</span> 직원등록</h4>

              <div class="row">
                <div class="col-md-12">
                  <div class="card mb-4">
                    <h5 class="card-header">직원등록</h5>
                    
                    <!-- Account -->
                    <form id="frm-add-employee" method="POST" action="${contextPath}/employee/add.do" enctype="multipart/form-data">
                    <div class="card-body">
                      <div class="d-flex align-items-start align-items-sm-center gap-4">
                        <img
                          src="../assets/img/user-solid.png"
                          alt="user-avatar"
                          class="d-block rounded"
                          height="100"
                          width="100"
                          id="uploadedAvatar"
                        />
                        <div class="button-wrapper">
                          <label for="profilePath" class="btn btn-primary me-2 mb-4" tabindex="0">
                            <span class="d-none d-sm-block">사진등록</span>
                            <i class="bx bx-upload d-block d-sm-none"></i>
                            <input
                              type="file"
                              id="profilePath"
                              name="profilePath"
                              class="account-file-input"
                              hidden
                              accept="image/png, image/jpeg, image/gif"
                            />
                          </label>
                          <button type="button" class="btn btn-outline-secondary account-image-reset mb-4">
                            <i class="bx bx-reset d-block d-sm-none"></i>
                            <span class="d-none d-sm-block">초기화</span>
                          </button>
                          <p class="text-muted mb-0">JPG, GIF, PNG 가능. 최대 800KB</p>
                        </div>
                      </div>
                    </div>
                    <hr class="my-0" />
                    <div class="card-body">
                      
                        <div class="row">
                          <div class="mb-3 col-md-6">
                            <label for="empName" class="form-label">이름</label>
                            <input
                              class="form-control"
                              type="text"
                              id="emp-name"
                              name="empName"
                            />
                            <div id="name-result"></div>
                          </div>
                          <div class="mb-3 col-md-6">
                            <label for="birth" class="form-label">생년월일</label>
                            <input
                              class="form-control"
                              type="date"
                              id="birth"
                              name="birth"
                              value="2024-05-20"
                            />
                          </div>
                          <div class="mb-3 col-md-6">
                            <label for="empPw" class="form-label">비밀번호</label>
                            <input class="form-control" type="password" name="empPw" id="empPw" readOnly />
                          </div>
                          <div class="mb-3 col-md-6">
                            <label class="form-label" for="mobile">휴대전화</label>
                              <input
                                type="tel"
                                id="emp-mobile"
                                name="mobile"
                                class="form-control"
                                placeholder="- 붙여서 작성해주세요"
                              />
	                          <div id="result-mobile"></div>
                          </div>
                          <div class="mb-3">
                            <label for="email" class="form-label">E-mail</label>
                            <input
                              class="form-control"
                              type="text"
                              id="emp-email"
                              name="email"
                              placeholder="example@example.com"
                            />
                            <div id="result-email"></div>
                          </div>
                          <div class="mb-3 col-md-6">
                            <label class="form-label" for="deptNo">소속</label>
                            <select id="dept-no" name="deptNo" class="select2 form-select">
                              <option value="">선택하세요</option>
                              <option value="9999">대표이사</option>
                              <option value="1000">인사</option>
                              <option value="2000">경영지원</option>
                              <option value="3000">안전관리</option>
                              <option value="5000">시설운영</option>
                              <option value="6000">마케팅</option>
                            </select>
                          </div>
                          <div class="mb-3 col-md-6">
                            <label for="posNo" class="form-label">직급</label>
                            <select id="pos-no" name="posNo" class="select2 form-select">
                              <option value="">선택하세요</option>
                              <option value="10">사원</option>
                              <option value="20">주임</option>
                              <option value="30">대리</option>
                              <option value="40">과장</option>
                              <option value="50">부장</option>
                              <option value="60">팀장</option>
                              <option value="100">대표이사</option>
                            </select>
                          </div>
                          <div class="mb-3 col-md-6">
                            <label for="enterDate" class="form-label">입사일</label>
                            <input
                              class="form-control"
                              type="date"
                              value="2024-05-20"
                              id="enterDate"
                              name="enterDate"
                            />
                          </div>
<!--                           <div class="mb-3 col-md-6">
                            <label for="dayOff" class="form-label">연차</label>
                            <input
                              class="form-control"
                              type="text"
                              id="dayOff"
                              name="dayOff"
                              value="15"
                            />
                          </div> -->
                          <div class="mb-3 col-md-6">
                            <label for="role" class="form-label">권한</label>
                            <select id="role" name="role" class="select2 form-select">
                              <option value="">선택하세요</option>
                              <option value="ROLE_USER">직원</option>
                              <option value="ROLE_ADMIN">관리자</option>
                            </select>
                          </div>
                        </div>
                        <div class="mt-2">
                          <button type="submit" class="btn btn-primary me-2" id="frm-add-employee">저장</button>
                          <button type="reset" class="btn btn-outline-secondary">취소</button>
                        </div>
                    </div>
                      </form>
                    
                    <!-- /Account -->
                  </div>
                </div>
              </div>
            </div>
            <!-- / Content -->
<script src="../assets/js/pages-add-employee.js"></script>
<%@ include file="../layout/footer.jsp" %>
    