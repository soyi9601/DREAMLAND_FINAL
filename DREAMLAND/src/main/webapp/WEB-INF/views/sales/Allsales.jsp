<!-- notie/list.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<c:set var="loginEmployee"
    value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<jsp:include page="../layout/header.jsp" />

<!-- link -->
<link rel="stylesheet" href="/resources/assets/css/board_sd.css" />
<link rel="stylesheet" href="/resources/assets/vendor/fonts/boxicons.css" />
<!-- include moment.js -->
<script src="/resources/assets/moment/moment-with-locales.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
		 
		<style>
    .custom-col {
        flex: 0 0 20%; 
        max-width: 20%; 
    }
    .cardT {
        display: none;
        }
    .cardT.active {
        display: block;
        }
    #sales {
    display: flex;
  	justify-content:center;
				}
		</style>
  </head>
				
			<body>	
			<!-- Style variation -->
				<div id="sales" class="row">
			    <div class="col-6 col-md-4 col-xl-3 custom-col">
			        <div class="card shadow-none bg-transparent border border-success mb-3">
			            <div class="card-body">                              
			                <h5 class="card-title">일간</h5 >
			                <p class="card-text">매출:
			                    <fmt:formatNumber value="${TodaySalesTotal}" type="currency" />
			                </p>
			            </div>
			        </div>
			    </div>
			    <div class="col-6 col-md-4 col-xl-3 custom-col">
			        <div class="card shadow-none bg-transparent border border-danger mb-3">
			            <div class="card-body">
			                <h5 class="card-title">주간</h5>
			                <p class="card-text">매출:
			                    <fmt:formatNumber value="${CurrentWeekSalesTotal}" type="currency" />
			                </p>
			            </div>
			        </div>
			    </div>
			    <div class="col-6 col-md-4 col-xl-3 custom-col">
			        <div class="card shadow-none bg-transparent border border-warning mb-3">
			            <div class="card-body">
			                <h5 class="card-title">월간</h5>
			                <p class="card-text">매출:
			                    <fmt:formatNumber value="${CurrentMonthSalesTotal}" type="currency" />
			                </p>
			            </div>
			        </div>
			    </div>
			    <div class="col-6 col-md-4 col-xl-3 custom-col">
			        <div class="card shadow-none bg-transparent border border-info mb-3">
			            <div class="card-body">
			                <h5 class="card-title">연간</h5>
			                <p class="card-text">매출:
			                    <fmt:formatNumber value="${CurrentYearSalesTotal}" type="currency" />
			                </p>
			            </div>
			        </div>
			    </div>
			</div>
			
			
		
		<div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
    	<div class="card">
      	<div class="row row-bordered g-0">
        	<div class="col-md-8">
          	<h5 class="card-header m-0 me-2 pb-3">매출 추이 (그래프)</h5>
          	<div id="totalRevenueChart" class="px-2">
          		<canvas id="monthlySalesChart"></canvas>
          	</div>
          </div>
        </div>
      </div>
    </div>
    
		<div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
    	<div class="card">
      	<div class="row row-bordered g-0">
        	<div class="col-md-8">
          	<h5 class="card-header m-0 me-2 pb-3">매출 추이 (바)</h5>
          	<div id="totalRevenueChart" class="px-2">
          		<canvas id="yearlySalesChart"></canvas>
          	</div>
          </div>
        </div>
      </div>
    </div>
    
    
                                   
			
			<label for="pageSelect">지역 선택</label>
			<select id="pageSelect" onchange="showPage(this.value)">
    		<option value="Zootopia">주토피아</option>
    		<option value="MagicLand">매직랜드</option>
    		<option value="AmericanAdventure">아메리칸어드벤처</option>
    		<option value="GloverFair">글로버페어</option>
    		<option value="EuropeanAdventure">유로피언어드벤처</option>
			</select>
			
			
			<!-- Hoverable Table rows -->
              <div id="Zootopia" class="cardT">
						    <h5 class="card-header">주토피아</h5>
						    	<div class="table-responsive text-nowrap">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>번호</th>
                        <th>이름</th>
                        <th>일간</th>
                        <th>주간</th>
                        <th>월간</th>
                        <th>연간</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                    	 <c:set var="Hsale" value="${getHunPartSales[0]}" />
				                <tr>
				                		<td>5100</td>
				                		<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>주토피아</strong></td>               
				                    <td><fmt:formatNumber value="${Hsale.Htds}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${Hsale.Htws}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${Hsale.Htms}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${Hsale.Htas}" type="currency" /></td>
				                </tr>	
                   		<c:forEach items="${getPartSales}" var="sale">
                      	<tr>
                      		<c:if test="${sale.deptNo ge 5120 && sale.deptNo le 5130}"> 
                      			<td>${sale.deptNo}</td>
                        		<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>${sale.deptName}</strong></td>
                        		<td><fmt:formatNumber value="${sale.dailySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.weeklySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.monthlySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.annualSales}" type="currency" /></td>
                      		</c:if>
                      	</tr>
                      </c:forEach>	
                    </tbody>
                  </table>
                </div>
              </div>
		
			<!-- Hoverable Table rows -->
              <div id="MagicLand" class="cardT">
                <h5 class="card-header">매직랜드</h5>
                <div class="table-responsive text-nowrap">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>번호</th>
                        <th>이름</th>
                        <th>일간</th>
                        <th>주간</th>
                        <th>월간</th>
                        <th>연간</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                    	 <c:set var="THsale" value="${getTHunPartSales[0]}" />
				                <tr>
				                		<td>5200</td>
				                		<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>매직랜드</strong></td>               
				                    <td><fmt:formatNumber value="${THsale.Htds}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${THsale.Htws}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${THsale.Htms}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${THsale.Htas}" type="currency" /></td>
				                </tr>	
                   		<c:forEach items="${getPartSales}" var="sale">
                      	<tr>
                      		<c:if test="${sale.deptNo ge 5220 && sale.deptNo le 5230}"> 
                      			<td>${sale.deptNo}</td>
                        		<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>${sale.deptName}</strong></td>
                        		<td><fmt:formatNumber value="${sale.dailySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.weeklySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.monthlySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.annualSales}" type="currency" /></td>
                      		</c:if>
                      	</tr>
                      </c:forEach>	
                    </tbody>
                  </table>
                </div>
              </div>
		
			<!-- Hoverable Table rows -->
              <div id="AmericanAdventure" class="cardT">
                <h5 class="card-header">아메리칸어드벤처</h5>
                <div class="table-responsive text-nowrap">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>번호</th>
                        <th>이름</th>
                        <th>일간</th>
                        <th>주간</th>
                        <th>월간</th>
                        <th>연간</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                    	 <c:set var="TrHsale" value="${getTrHunPartSales[0]}" />
				                <tr>
				                		<td>5300</td>
				                		<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>아메리칸어드벤처</strong></td>               
				                    <td><fmt:formatNumber value="${TrHsale.Htds}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${TrHsale.Htws}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${TrHsale.Htms}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${TrHsale.Htas}" type="currency" /></td>
				                </tr>	
                   		<c:forEach items="${getPartSales}" var="sale">
                      	<tr>
                      		<c:if test="${sale.deptNo ge 5320 && sale.deptNo le 5330}"> 
                      			<td>${sale.deptNo}</td>
                        		<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>${sale.deptName}</strong></td>
                        		<td><fmt:formatNumber value="${sale.dailySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.weeklySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.monthlySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.annualSales}" type="currency" /></td>
                      		</c:if>
                      	</tr>
                      </c:forEach>	
                    </tbody>
                  </table>
                </div>
              </div>
		
			<!-- Hoverable Table rows -->
              <div id="GloverFair" class="cardT">
                <h5 class="card-header">글로버페어</h5>
                <div class="table-responsive text-nowrap">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>번호</th>
                        <th>이름</th>
                        <th>일간</th>
                        <th>주간</th>
                        <th>월간</th>
                        <th>연간</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                    	 <c:set var="FHsale" value="${getFHunPartSales[0]}" />
				                <tr>
				                		<td>5400</td>
				                		<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>글로버페어</strong></td>               
				                    <td><fmt:formatNumber value="${FHsale.Htds}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${FHsale.Htws}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${FHsale.Htms}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${FHsale.Htas}" type="currency" /></td>
				                </tr>	
                   		<c:forEach items="${getPartSales}" var="sale">
                      	<tr>
                      		<c:if test="${sale.deptNo ge 5420 && sale.deptNo le 5430}"> 
                      			<td>${sale.deptNo}</td>
                        		<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>${sale.deptName}</strong></td>
                        		<td><fmt:formatNumber value="${sale.dailySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.weeklySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.monthlySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.annualSales}" type="currency" /></td>
                      		</c:if>
                      	</tr>
                      </c:forEach>	
                    </tbody>
                  </table>
                </div>
              </div>
		
			<!-- Hoverable Table rows -->
              <div id="EuropeanAdventure" class="cardT">
                <h5 class="card-header">유로피언어드벤처</h5>
                <div class="table-responsive text-nowrap">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>번호</th>
                        <th>이름</th>
                        <th>일간</th>
                        <th>주간</th>
                        <th>월간</th>
                        <th>연간</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                    	 <c:set var="FvHsale" value="${getFvHunPartSales[0]}" />
				                <tr>
				                		<td>5500</td>
				                		<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>유로피언어드벤처</strong></td>               
				                    <td><fmt:formatNumber value="${FvHsale.Htds}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${FvHsale.Htws}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${FvHsale.Htms}" type="currency" /></td>
				                    <td><fmt:formatNumber value="${FvHsale.Htas}" type="currency" /></td>
				                </tr>	
                   		<c:forEach items="${getPartSales}" var="sale">
                      	<tr>
                      		<c:if test="${sale.deptNo ge 5520 && sale.deptNo le 5530}"> 
                      			<td>${sale.deptNo}</td>
                        		<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>${sale.deptName}</strong></td>
                        		<td><fmt:formatNumber value="${sale.dailySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.weeklySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.monthlySales}" type="currency" /></td>
                        		<td><fmt:formatNumber value="${sale.annualSales}" type="currency" /></td>
                      		</c:if>
                      	</tr>
                      </c:forEach>	
                    </tbody>
                  </table>
                </div>
              </div>
          </body>
          
<script>

function showPage(pageId) {
    const pages = document.querySelectorAll('.cardT');
    pages.forEach(page => {
        page.classList.remove('active');
    });
    document.getElementById(pageId).classList.add('active');
}

// Initialize to show the first page
showPage('Zootopia');


   const monthlySalesData = {
        labels: [],
        sales: []
   };

    <c:forEach items="${monthlySalesTotals}" var="recordGraph">
        monthlySalesData.labels.push("${recordGraph.SALESMONTH}");
        monthlySalesData.sales.push(${recordGraph.TOTALSALES});
    </c:forEach>

    const ctx = document.getElementById('monthlySalesChart').getContext('2d');
    const gradient = ctx.createLinearGradient(0, 0, 0, 400);
    gradient.addColorStop(0, 'rgba(0, 123, 255, 0.5)');
    gradient.addColorStop(1, 'rgba(0, 123, 255, 0)');

    const monthlySalesChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: monthlySalesData.labels,
            datasets: [{
                label: '월간 매출액',
                backgroundColor: gradient,
                borderColor: 'rgba(0, 123, 255, 1)',
                data: monthlySalesData.sales,
                fill: true,
                pointBackgroundColor: 'white',
                pointBorderColor: 'rgba(0, 123, 255, 1)',
                pointHoverBackgroundColor: 'rgba(0, 123, 255, 1)',
                pointHoverBorderColor: 'white'
            }]
        },
        options: {
            responsive: true,
            title: {
                display: true,
                text: '월간 매출 추이',
                fontColor: 'black',
                fontSize: 20
            },
            scales: {
                y: {
                    grid: {
                        drawBorder: true,
                        color: 'lightgrey'
                    },
                    beginAtZero: true,
                    ticks: {
                        fontColor: 'black'
                    }
                },
                x: {
                    grid: {
                        drawBorder: true,
                        color: 'lightgrey'
                    },
                    ticks: {
                        fontColor: 'black'
                    }
                }
            },
            legend: {
                labels: {
                    fontColor: 'black'
                }
            },
            hover: {
                mode: 'nearest',
                intersect: true
            },
            tooltips: {
                mode: 'index',
                intersect: false
            }
        }
    });    

const yearlySalesData = {
        labels: [],
        sales: []
    };

    <c:forEach items="${yearlySalesTotals}" var="recordBar">
        yearlySalesData.labels.push("${recordBar.SALESYEAR}");
        yearlySalesData.sales.push(${recordBar.TOTALSALES});
    </c:forEach>

    const ctxBar = document.getElementById('yearlySalesChart').getContext('2d');
    const gradientBar = ctxBar.createLinearGradient(0, 0, 0, 400);
    gradientBar.addColorStop(0, 'rgba(255, 99, 132, 0.5)');
    gradientBar.addColorStop(1, 'rgba(255, 99, 132, 0)');

    const yearlySalesBarChart = new Chart(ctxBar, {
        type: 'bar',
        data: {
            labels: yearlySalesData.labels,
            datasets: [{
                label: '연간 매출액',
                backgroundColor: gradientBar,
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1,
                data: yearlySalesData.sales
            }]
        },
        options: {
            Responsive: true,
            legend: {
                position: 'top',
                labels: {
                    fontColor: 'black'
                }
            },
            title: {
                display: true,
                text: '월간 매출 추이 (바 차트)',
                fontColor: 'black',
                fontSize: 20
            },
            scales: {
                yAxes: [{
                    gridLines: {
                        drawBorder: true,
                        color: 'lightgrey'
                    },
                    ticks: {
                        beginAtZero: true,
                        fontColor: 'black'
                    }
                }],
                xAxes: [{
                    gridLines: {
                        drawBorder: true,
                        color: 'lightgrey'
                    },
                    ticks: {
                        fontColor: 'black'
                    }
                }]
            },
            tooltips: {
                mode: 'index',
                intersect: false
            }
        }
    });
</script>


</html>

<%@ include file="../layout/footer.jsp"%>