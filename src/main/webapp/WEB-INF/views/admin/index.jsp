<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<script>	

	
</script>


<title>관리자 메인 페이지</title>

</head>

<body id="page-top">


	<!-- Page Wrapper -->
	<div id="wrapper">



		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">


				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
						<a href="#"
							class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
							class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
					</div>

					<!-- Content Row -->
					<div class="row">

						<!-- Earnings (Monthly) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-primary text-uppercase mb-1">금일
												주문건수(렌탈)</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">
												${todayRentalCount }건</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-calendar fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Earnings (Monthly) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-success shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-success text-uppercase mb-1">
												금일 매출액
												<!-- <br/>(렌탈 totalamout + auction의 총 경매금액 * 20%) -->
											</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">
												<fmt:formatNumber value="${todaySales }" pattern="#,###원" />
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Earnings (Monthly) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-info shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-info text-uppercase mb-1">진행중인
												경매</div>
											<div class="row no-gutters align-items-center">
												<div class="col-auto">
													<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${AuctionCount }건</div>
												</div>
												<div class="col">
													<div class="progress progress-sm mr-2">
														<div class="progress-bar bg-info" role="progressbar"
															style="width: 50%" aria-valuenow="37" aria-valuemin="0"
															aria-valuemax="100"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Pending Requests Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-warning shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-warning text-uppercase mb-1">금일
												신규 작품 수</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">${todayUploadArts }개</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-comments fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Content Wrapper -->
					<div id="content-wrapper" class="d-flex flex-column">

						<!-- Main Content -->
						<div id="content">

							<!-- Begin Page Content -->
							<div class="container-fluid">
								
								
								<div class="row">
								
							<!-- Area Chart -->
								<div class="col-xl-8 col-lg-7">
									<%-- <div class="card shadow mb-4">
										<!-- Card Header - Dropdown -->
										<div
											class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
											<h6 class="m-0 font-weight-bold text-primary">Earnings
												Overview</h6>
											<div class="dropdown no-arrow">
												<a class="dropdown-toggle" href="#" role="button"
													id="dropdownMenuLink" data-toggle="dropdown"
													aria-haspopup="true" aria-expanded="false"> <i
													class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
												</a>
												<div
													class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
													aria-labelledby="dropdownMenuLink">
													<div class="dropdown-header">Dropdown Header:</div>
													<a class="dropdown-item" href="/admin/buttons">Action</a>
													<a class="dropdown-item" href="#">Another action</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item" href="#">Something else here</a>
												</div>
											</div>
										</div>
										<!-- Card Body -->
										<div class="card-body">
											<div class="chart-area">
												<canvas id="myAreaChart"></canvas>
											</div>
										</div>
									</div> --%>
									<div class="card shadow mb-4">
										<div class="card-header py-3">
											<h6 class="m-0 font-weight-bold text-primary">입찰중 경매</h6>
										</div>
										<!--  http://localhost:8080/alouer/admin/auction?searchField=code&searchTxt=A0111-0007 -->
										<div class="card-body">
											<c:set var="now" value="<%=new java.util.Date()%>" />

											<c:forEach items="${terminatingAuctionList}" var="auctionDTO"
												varStatus="status">
												<a
													href="${pageContext.request.contextPath += '/admin/auction?searchField=code&searchTxt=' += auctionDTO.code}">
													<h4 class="small font-weight-bold">${auctionDTO.title+='('+=auctionDTO.code+=')'}<span
															id="progRate${status.count }" class="float-right">20%</span>
													</h4>
													<div class="progress mb-4 bordered"
														style="height: 0.6em; color: red; background-color: black;">
														<div id="${'progress'+=status.count }"
															class="progress-bar bg-info progress-bar-striped progress-bar-animated"
															role="progressbar" aria-valuenow="50" aria-valuemin="0"
															aria-valuemax="100"></div>
													</div>
												</a>

												<fmt:formatDate value="${auctionDTO.startTime }"
													var="startTime" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
												<fmt:formatDate value="${auctionDTO.endTime }" var="endTime"
													type="both" pattern="yyyy-MM-dd HH:mm:ss" />
												<script>
													var now = new Date(); 
													var startTime = new Date("${startTime }")
													var endTime = new Date("${endTime }")
													console.log("now:",now.getTime(),"endTime:",endTime.getTime(),"startTime",startTime.getTime());
													
													startTime = startTime.getTime();
													endTime = endTime.getTime();
													now = now.getTime();
													console.log("계산:", ((now-startTime)/(endTime-startTime))*100);
													var remain = ((now-startTime)/(endTime-startTime))*100 ;
													//(now-start)/(end-start)*100
													$("${'#progress'+=status.count}").css("width",(remain>100?100:remain)+"%");
													if(remain>100){
														$("${'#progress'+=status.count}").attr("class","progress-bar bg-success");
													}
													$("${'#progRate'+=status.count}").text(parseInt((remain>100?100:remain))+"%");
												</script>
											</c:forEach>
										</div>
									</div>
								</div>
								
								
								

								<!-- Pie Chart -->
								<div class="col-xl-4 col-lg-5">
									<div class="card shadow mb-4">
										<!-- Card Header - Dropdown -->
										<div
											class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
											<h6 class="m-0 font-weight-bold text-primary">작품 서비스 현황</h6>
											<div class="dropdown no-arrow">
												<a class="dropdown-toggle" href="#" role="button"
													id="dropdownMenuLink" data-toggle="dropdown"
													aria-haspopup="true" aria-expanded="false"> <i
													class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
												</a>
												<div
													class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
													aria-labelledby="dropdownMenuLink">
													<div class="dropdown-header">Dropdown Header:</div>
													<a class="dropdown-item" href="#">Action</a> <a
														class="dropdown-item" href="#">Another action</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item" href="#">Something else here</a>
												</div>
											</div>
										</div>
										<!-- Card Body -->
										<div class="card-body">
											<div class="chart-pie pt-4 pb-2">
												<canvas id="myPieChart"></canvas>
											</div>
											<div class="mt-4 text-center small">
												<c:forEach items="${countStatus }" var="item">
													<span class="mr-auto"> <i class="fas fa-circle "></i>
														${item.status }
													</span>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>

									</div>
								

									
									<!-- Project Card Example -->

									<!-- progress bar -->					
		

						</div>

						<!-- /.container-fluid -->

					</div>
					<!-- End of Main Content -->

					<!-- Footer -->
					<footer class="sticky-footer bg-white">
						<div class="container my-auto">
							<div class="copyright text-center my-auto">
								<span>Copyright &copy; Alouer 2020</span>
							</div>
						</div>
					</footer>
					<!-- End of Footer -->

				</div>
				<!-- End of Content Wrapper -->

			</div>
			<!-- End of Page Wrapper -->
		</div>



		<!-- Page level plugins -->
		<script
			src="${pageContext.request.contextPath}/resources/vendor/chart.js/Chart.min.js"></script>

		<script>
  $(function(){
	
	//원형그래프의 데이터명 ㅇ에 각각 컬러를 적용함
	const colorArr = ['#4e73df', '#1cc88a', '#36b9cc','#d66666','#d36ad8','#d5d86c'];
	$("i.fas.fa-circle").each(function(index,item){
		console.log("item",item);
		$(item).css("color",colorArr[index]);
	});
  	


	//Pie Chart Example
	  var ctx = document.getElementById("myPieChart");
	  var myPieChart = new Chart(ctx, {
	    type: 'doughnut',
	    data: {
	      labels: ["${countStatus[0].status}", "${countStatus[1].status}", "${countStatus[2].status}","${countStatus[3].status}","${countStatus[4].status}","${countStatus[5].status}"],
	      datasets: [{
	        data: [${countStatus[0].sum}, ${countStatus[1].sum}, ${countStatus[2].sum},${countStatus[3].sum}, ${countStatus[4].sum}, ${countStatus[5].sum}],
	        backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc','#d66666','#d36ad8','#d5d86c'],
	        hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf','#c15b5b','#b75cbc','#c1c462'],
	        hoverBorderColor: "rgba(234, 236, 244, 1)",
	      }],
	    },
	    options: {
	      maintainAspectRatio: false,
	      tooltips: {
	        backgroundColor: "rgb(255,255,255)",
	        bodyFontColor: "#858796",
	        borderColor: '#dddfeb',
	        borderWidth: 1,
	        xPadding: 15,
	        yPadding: 15,
	        displayColors: false,
	        caretPadding: 10,
	      },
	      legend: {
	        display: false
	      },
	      cutoutPercentage: 80,
	    },
	  });	
  });

  
  </script>


		<!-- Page level custom scripts -->
		<%-- <script src="${pageContext.request.contextPath}/resources/js/demo/chart-area-demo.js"></script> --%>
		<script
			src="${pageContext.request.contextPath}/resources/js/demo/chart-pie-demo.js"></script>



		<script>

Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

function number_format(number, decimals, dec_point, thousands_sep) {

  number = (number + '').replace(',', '').replace(' ', '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };

  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}


	var ctx = document.getElementById("myAreaChart");
	var today = new Date();
	var month = today.getMonth()+1;
	
	var datArr = new Array();
	for (var i=6 ; i>=0; i--){
		
		var month = today.getMonth()+1
		var date = today.getDate()-i;
		console.log(datArr);
		
		datArr.push(month+'/'+date);
		
		
	}
	
	
	
	var myLineChart = new Chart(ctx, {
	  type: 'line',
	  data: {
	    labels: datArr,
	    datasets: [{
	      label: "매출액",
	      lineTension: 0.3,
	      backgroundColor: "rgba(78, 115, 223, 0.05)",
	      borderColor: "rgba(78, 115, 223, 1)",
	      pointRadius: 3,
	      pointBackgroundColor: "rgba(78, 115, 223, 1)",
	      pointBorderColor: "rgba(78, 115, 223, 1)",
	      pointHoverRadius: 3,
	      pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
	      pointHoverBorderColor: "rgba(78, 115, 223, 1)",
	      pointHitRadius: 10,
	      pointBorderWidth: 2,
	      data: ${dailySales},
	    }],
	  },
	  options: {
	    maintainAspectRatio: false,
	    layout: {
	      padding: {
	        left: 10,
	        right: 25,
	        top: 25,
	        bottom: 0
	      }
	    },
	    scales: {
	      xAxes: [{
	        time: {
	          unit: 'date'
	        },
	        gridLines: {
	          display: false,
	          drawBorder: false
	        },
	        ticks: {
	          maxTicksLimit: 7
	        }
	      }],
	      yAxes: [{
	        ticks: {
	          maxTicksLimit: 5,
	          padding: 10,

	          callback: function(value, index, values) {
	            return number_format(value)+'원';
	          }
	        },
	        gridLines: {
	          color: "rgb(234, 236, 244)",
	          zeroLineColor: "rgb(234, 236, 244)",
	          drawBorder: false,
	          borderDash: [2],
	          zeroLineBorderDash: [2]
	        }
	      }],
	    },
	    legend: {
	      display: false
	    },
	    tooltips: {
	      backgroundColor: "rgb(255,255,255)",
	      bodyFontColor: "#858796",
	      titleMarginBottom: 10,
	      titleFontColor: '#6e707e',
	      titleFontSize: 14,
	      borderColor: '#dddfeb',
	      borderWidth: 1,
	      xPadding: 15,
	      yPadding: 15,
	      displayColors: false,
	      intersect: false,
	      mode: 'index',
	      caretPadding: 10,
	      callbacks: {
	        label: function(tooltipItem, chart) {
	          var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
	          return datasetLabel + ':' + number_format(tooltipItem.yLabel)+'원';
	        }
	      }
	    }
	  }
	});
	</script>
</body>

</html>
