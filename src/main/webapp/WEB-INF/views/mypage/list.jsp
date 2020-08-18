<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!doctype html>
<html lang="en">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/css.css">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>마이 페이지</title>

</head>
<style>
/* #memberContent .memberContent-in .contents .user-info .text-right .button 
{ padding: 3px 15px 2px; background: #E9ECEF; border-radius: 100px; font-size: 13px; font-weight: 500; }
 .link_button { float: left; width: 15.2%; height: 100%; border-left: 1px solid #E9ECEF; font-size: 16px; font-weight: 500; text-align: center; line-height: 62px; }
 .link_button:hover { color: #4386F9; }#
 .link_button:first-child { border-left: none; } */
</style> 

<body>
	<!-- content area -->
	<section id="memberContent" class="bg-gray">
		<div class="member-head">
			<h1 class="title">마이 페이지</h1>
		</div>
		<div id="mypage-padding" class="memberContent-in">
			<div class="mypage-main">
				<div class="contents c01">
					<div class="card user-info">
						<div class="clearfix">
							<div class="col user">
								<h2 class="title">
									<span class="art-blue">박성일님</span> 환영합니다.
								</h2>
								<p class="sub-title">psipsi1988@naver.com</p>
							</div>
							<div class="col text-right">
							
								<!-- view/mypage/deposit.jsp 이동 -->
								<a href="${pageContext.request.contextPath}/mypage/modify/"
									class="">회원정보</a>
							</div>
						</div>
						<div class="user-deposit" id="dpstDiv">
							<div class="col">
								<span class="label">예치금</span> <span class="reset-btn"> <a
									href="javascript:fn_selectMmbrDpst();"
									style="cursor: pointer; padding-left: 2px;"> <span
										class="fa fa-refresh animation-2s faster" id="dpstSpinner"></span>
								</a>
								</span>
							</div>
							<div class="col text-right">

								<span class="num" name="dpstAmt">0</span> KRW
							</div>
						</div>
						<div class="virtual-account-number">
							<div class="col">
								<span class="label">예치금 입금계좌 </span>
							</div>
							<div class="col text-right">
								<!-- 예) name:농협, num: 가상 계좌번호 -->
								<span class="name">우리은행</span> <span class="num">62122993718489</span>
							</div>
						</div>
					</div>

					<div class="card user-cont point">
						<ul class="text-list">
							<li>
								<p class="col label">쿠폰</p>
								<p class="col text-right">
									<a href="/myCpnPoint" class="link"> <span>1</span>장
									</a>
								</p>
							</li>
							<li>
								<p class="col label">포인트</p>
								<p class="col text-right">
									<span class="num"> <span>0</span>P
									</span>
								</p>
							</li>
						</ul>

						<a href="/myCpnPoint" class="link">쿠폰 및 포인트 사용내역 확인 &gt;</a>
					</div>

					<div class="card user-cont user-cont-margin">
						<ul class="text-list">
							<span class="text-list-top">
								<li>
									<p class="col label art-blue">보유 작품 수</p>
									<p class="col text-right">
										<a href="/myGallary" class="link"> <span>0</span>개
										</a>
									</p>
							</li>
								<li>
									<p class="col label art-blue">총 수익률</p>
									<p class="col text-right">
										<span class="num"> <span>NaN</span>&nbsp;%
										</span>
									</p>
							</li>
							</span>
							<li>
								<p class="col label">조각거래 미실현손익률</p>
								<p class="col text-right">



									<span class="num"> <span>0.00</span>&nbsp;%
									</span>



								</p>
							</li>
							<li>
								<p class="col label">조각거래 실현손익률</p>
								<p class="col text-right">

									<span class="num"> <span>0.00</span>&nbsp;%
									</span>


								</p>
							</li>
							<li>
								<p class="col label">렌탈</p>
								<p class="col text-right">



									<span class="num"> <span>0.00</span>&nbsp;%
									</span>


								</p>
							</li>
							<li>
								<p class="col label">매각 작품</p>
								<p class="col text-right">



									<span class="num"> <span>0.00</span>&nbsp;%
									</span>


								</p>
							</li>
						</ul>
					</div>
				</div>

				<div class="contents c02">
					<div class="card page-link-list full" style="">
						<a href="${pageContext.request.contextPath}/mypage/deposit"
							class="link_button">예치금 관리</a> <a
							href="${pageContext.request.contextPath}/mypage/artist"
							class="link_button">관심 목록</a> <a
							href="${pageContext.request.contextPath}/mypage/auction"
							class="link_button">지분 경매</a> <a
							href="${pageContext.request.contextPath}/mypage/stock"
							class="link_button">지분 거래</a> <a
							href="${pageContext.request.contextPath}/mypage/rental"
							class="link_button">렌탈</a><a
							href="${pageContext.request.contextPath}/mypage/inquiry"
							class="link_button">1:1 문의하기</a>
					</div>
				</div>

				<div class="contents c03">
					<div class="card user-rate-info full">
						<section class="head clearfix">
							<ul class="tab-list clearfix">
								<li data-tab="tab03" class=" tab active">조각거래</li>
								<li data-tab="tab02" class=" tab">렌탈</li>
								<li data-tab="tab01" class=" tab">매각작품</li>
							</ul>
							<div class="text-right">(단위: KRW)</div>
						</section>

						<section class="body">
							<div class="cont tab01 dis-none">
								<div class="col text-right">
									<ul class="info-list">
										<li>
											<p class="col label">매각작품 수</p>
											<p class="col text-right">
												<span class="num"> <span>0</span>점
												</span>
											</p>
										</li>
										<li>
											<p class="col label">실 지급액</p>
											<p class="col text-right">



												<span class="num"> <span> - </span>
												</span>


											</p>
										</li>
										<li>
											<p class="col label">매각 수익률</p>
											<p class="col text-right">



												<span class="num"> <span> - </span>
												</span>


											</p>
										</li>
										<li class="detailMypage-btn"><a
											href="/myHistory/goodsHistory">상세보기</a></li>
									</ul>
								</div>
								<!-- <div class="col left" style="text-align: center;">
										<img src="/images/com/comingSoon.png" alt="comingSoon.png" style="height: 100%">
									</div> -->

								<div class="col left" style="text-align: center;">
									<section class="table six">
										<div class="thead">
											<dl class="tr clearfix">
												<dt class="th">작품</dt>
												<dt class="th">작품명</dt>
												<dt class="th">작가명</dt>
												<dt class="th">보유조각 수</dt>
												<dt class="th">구입금액</dt>
												<dt class="th">매각금액</dt>
												<dt class="th">실 지급액</dt>
												<dt class="th">수익률</dt>
											</dl>
										</div>
										<div class="tbody">


											<div class='product-list-no'>
												<img src='images/fo/product-list-no.gif'
													alt='product-list-no-image-gif'
													style='margin-left: auto; margin-right: auto; display: block;' />
												<p>조각거래 내역이 없습니다.</p>
											</div>



										</div>
									</section>
								</div>
							</div>

							<div class="cont tab02 dis-none">
								<div class="col text-right">
									<ul class="info-list">
										<li>
											<p class="col label">렌탈작품 수</p>
											<p class="col text-right">
												<span class="num"> <span>0</span> 점
												</span>
											</p>
										</li>

										<li>
											<p class="col label">총 누적지급액</p>
											<p class="col text-right">
												<span class="num red"> <span>0</span>



												</span>
											</p>
										</li>

										<li class="detailMypage-btn"><a
											href="/myHistory/rentalHistory">상세보기</a></li>
									</ul>
								</div>
								<div class="col left">
									<section class="table eight">
										<div class="thead">
											<dl class="tr clearfix">
												<dt class="th">회차</dt>
												<dt class="th">작품</dt>
												<dt class="th">작품명</dt>
												<dt class="th">렌탈이용자</dt>
												<dt class="th">렌탈 기간</dt>
												<dt class="th">지급(월)</dt>
												<dt class="th">누적 지급액</dt>
												<dt class="th">상태</dt>
											</dl>
										</div>
										<div class="tbody">


											<div class='product-list-no'>
												<img src='images/fo/product-list-no.gif'
													alt='product-list-no-image-gif'
													style='margin-left: auto; margin-right: auto; display: block;' />
												<p>렌탈 내역이 없습니다.</p>
											</div>
										</div>
									</section>
								</div>
							</div>
							<div class="cont tab03">
								<div class="col text-right">
									<ul class="info-list">
										<li>
											<p class="col label">보유작품 수</p>
											<p class="col text-right">
												<span class="num"> <span>0</span>점
												</span>
											</p>
										</li>
										<li>
											<p class="col label">조각거래 미실현 손익률</p>
											<p class="col text-right">
												<span class="num"> <span> 0.00 </span> %
												</span>
											</p>
										</li>
										<li class="detailMypage-btn"><a
											href="/myHistory/pieceMarketHistory">상세보기</a></li>
									</ul>
								</div>
								<div class="col left">
									<section class="table six">
										<div class="thead">
											<dl class="tr clearfix">
												<dt class="th">작품</dt>
												<dt class="th">작품명</dt>
												<dt class="th">작가명</dt>
												<dt class="th">보유조각 수</dt>
												<dt class="th">평균단가</dt>
												<dt class="th">구매금액</dt>
												<dt class="th">평가금액</dt>
												<dt class="th">미실현손익</dt>
											</dl>
										</div>
										<div class="tbody">


											<div class='product-list-no'>
												<img src='images/fo/product-list-no.gif'
													alt='product-list-no-image-gif'
													style='margin-left: auto; margin-right: auto; display: block;' />
												<p>조각거래 내역이 없습니다.</p>
											</div>

										</div>
									</section>
								</div>
							</div>
						</section>
					</div>
				</div>
			</div>

		</div>
	</section>

</body>

</html>