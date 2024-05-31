<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
<jsp:include page="../layout/header.jsp" /> 

            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">쪽지함 /</span> 쪽지함</h4>

              <div class="row">

                <div class="col-xl-12">
                  <div class="nav-align-top mb-4">
                    <ul class="nav nav-tabs nav-fill" role="tablist">
                      <li class="nav-item">
                        <button
                          type="button"
                          class="nav-link"
                          role="tab"
                          data-bs-toggle="tab"
                          data-bs-target="#navs-justified-home"
                          aria-controls="navs-justified-home"
                          aria-selected="false"
                        >
                          받은편지함
                          <span class="badge rounded-pill badge-center h-px-20 w-px-20 bg-label-danger">3</span>
                        </button>
                      </li>
                      <li class="nav-item">
                        <button
                          type="button"
                          class="nav-link active"
                          role="tab"
                          data-bs-toggle="tab"
                          data-bs-target="#navs-justified-profile"
                          aria-controls="navs-justified-profile"
                          aria-selected="true"
                        >
                          보낸편지함
                        </button>
                      </li>
                    </ul>
                    <div class="tab-content">
                      <div class="tab-pane fade" id="navs-justified-home" role="tabpanel">
					              <!-- Hoverable Table rows -->
					              <div class="card">
					                <h5 class="card-header">받은편지함</h5>
					                <div class="table-responsive text-nowrap">
					                  <table class="table table-hover">
					                    <thead>
					                      <tr>
					                        <th>번호</th>
					                        <th>쪽지내용</th>
					                        <th>받은시간</th>
					                        <th>보낸사람</th>
					                      </tr>
					                    </thead>
					                    <tbody class="table-border-bottom-0">
					                      <tr>
					                        <td><strong>1</strong></td>
					                        <td>메롱</td>
					                        <td>20240531</td>
					                        <td>관리자</td>
					                        <td>
					                          <div class="dropdown">
					                            <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
					                              <i class="bx bx-dots-vertical-rounded"></i>
					                            </button>
					                            <div class="dropdown-menu">
					                              <a class="dropdown-item" href="javascript:void(0);"
					                                ><i class="bx bx-edit-alt me-1"></i> Edit</a
					                              >
					                              <a class="dropdown-item" href="javascript:void(0);"
					                                ><i class="bx bx-trash me-1"></i> Delete</a
					                              >
					                            </div>
					                          </div>
					                        </td>
					                      </tr>
					                      <tr>
					                        <td><strong>1</strong></td>
					                        <td>메롱</td>
					                        <td>20240531</td>
					                        <td>관리자</td>
					                        <td>
					                          <div class="dropdown">
					                            <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
					                              <i class="bx bx-dots-vertical-rounded"></i>
					                            </button>
					                            <div class="dropdown-menu">
					                              <a class="dropdown-item" href="javascript:void(0);"
					                                ><i class="bx bx-edit-alt me-1"></i> Edit</a
					                              >
					                              <a class="dropdown-item" href="javascript:void(0);"
					                                ><i class="bx bx-trash me-1"></i> Delete</a
					                              >
					                            </div>
					                          </div>
					                        </td>
					                      </tr>
					                       <tr>
					                        <td><strong>1</strong></td>
					                        <td>메롱</td>
					                        <td>20240531</td>
					                        <td>관리자</td>
					                        <td>
					                          <div class="dropdown">
					                            <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
					                              <i class="bx bx-dots-vertical-rounded"></i>
					                            </button>
					                            <div class="dropdown-menu">
					                              <a class="dropdown-item" href="javascript:void(0);"
					                                ><i class="bx bx-edit-alt me-1"></i> Edit</a
					                              >
					                              <a class="dropdown-item" href="javascript:void(0);"
					                                ><i class="bx bx-trash me-1"></i> Delete</a
					                              >
					                            </div>
					                          </div>
					                        </td>
					                      </tr>
					                       <tr>
					                        <td><strong>1</strong></td>
					                        <td>메롱</td>
					                        <td>20240531</td>
					                        <td>관리자</td>
					                        <td>
					                          <div class="dropdown">
					                            <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
					                              <i class="bx bx-dots-vertical-rounded"></i>
					                            </button>
					                            <div class="dropdown-menu">
					                              <a class="dropdown-item" href="javascript:void(0);"
					                                ><i class="bx bx-edit-alt me-1"></i> Edit</a
					                              >
					                              <a class="dropdown-item" href="javascript:void(0);"
					                                ><i class="bx bx-trash me-1"></i> Delete</a
					                              >
					                            </div>
					                          </div>
					                        </td>
					                      </tr>
					                    </tbody>
					                  </table>
					                </div>
					              </div>
					              <!--/ Hoverable Table rows -->
                      </div>
                      <div class="tab-pane fade show active" id="navs-justified-profile" role="tabpanel">
                        <p>
                          Donut dragÃ©e jelly pie halvah. Danish gingerbread bonbon cookie wafer candy oat cake ice
                          cream. Gummies halvah tootsie roll muffin biscuit icing dessert gingerbread. Pastry ice cream
                          cheesecake fruitcake.
                        </p>
                        <p class="mb-0">
                          Jelly-o jelly beans icing pastry cake cake lemon drops. Muffin muffin pie tiramisu halvah
                          cotton candy liquorice caramels.
                        </p>
                      </div>
                      <div class="tab-content">
                      <nav aria-label="Page navigation">
                          <ul class="pagination justify-content-center">
                            <li class="page-item prev">
                              <a class="page-link" href="javascript:void(0);"
                                ><i class="tf-icon bx bx-chevrons-left"></i
                              ></a>
                            </li>
                            <li class="page-item">
                              <a class="page-link" href="javascript:void(0);">1</a>
                            </li>
                            <li class="page-item">
                              <a class="page-link" href="javascript:void(0);">2</a>
                            </li>
                            <li class="page-item active">
                              <a class="page-link" href="javascript:void(0);">3</a>
                            </li>
                            <li class="page-item">
                              <a class="page-link" href="javascript:void(0);">4</a>
                            </li>
                            <li class="page-item">
                              <a class="page-link" href="javascript:void(0);">5</a>
                            </li>
                            <li class="page-item next">
                              <a class="page-link" href="javascript:void(0);"
                                ><i class="tf-icon bx bx-chevrons-right"></i
                              ></a>
                            </li>
                          </ul>
                        </nav>
                        </div>
                                              
                    </div>
                    
                  </div>
                  
                </div>
                
              </div>
              </div>
            <!-- / Content -->
<!-- <script src="../assets/js/pages-account-mypage.js"></script> -->
<%@ include file="../layout/footer.jsp" %>
