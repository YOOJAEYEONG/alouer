<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- JSTL의 국제화 라이브러리를 사용하기 위한 지시어 선언 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="en">

<link rel="stylesheet"href="${pageContext.request.contextPath}/resources/css/mypagelist2.css">	
	
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>마이 페이지</title>

</head>
<style>
.myModify-inner:before {
	content: '';
	position: absolute;
	width: 54px;
	height: 54px;
	top: 50%;
	left: 0;
	-webkit-transform: translateY(-50%);
	-ms-transform: translateY(-50%);
	transform: translateY(-50%);
	background:
		url('${pageContext.request.contextPath}/resources/img/member/alouer.png')
		no-repeat;
	background-size: 54px 54px
}
h1, h2, h3, h4, h5, h6 {
    color: #2a2a2a;
    font-family: 'Roboto', 'Noto Sans KR','Malgun Gothic', sans-serif;
}
th, td{
    text-align: right;
}
</style> 

<body>
	<div id="contents" data-login_required="true">
        <section class="pageHead" id="my_account_head">
            <div class="pageHead-bar"></div>
            <h2 class="pageHead-title">마이페이지</h2>
            <div class="pageHead-description">고객님과 관련된 정보입니다.</div>
        </section>
        <section id="myModify">
            <div class="myModify-inner">
                <h3 id="myModify-name"><sec:authentication property="principal.username" /> <span>님, 반갑습니다.</span></h3>
                <a href="${pageContext.request.contextPath}/mypage/modify/" onclick="ga_clk_account('account_modify');">
                    <div class="myModify-btn">
                        <p>회원정보수정</p>
                    </div>
                </a>
            </div>
        </section>
        <nav id="myAccountNav" class="cf">
        <nav id="myAccountNav" class="cf">
            <a href="${pageContext.request.contextPath}/mypage/rental" class="myAccountNav-btn " onclick="ga_clk_account('account_orders');">나의 렌탈</a>
            <%-- <a href="${pageContext.request.contextPath}/mypage/art" class="myAccountNav-btn" onclick="ga_clk_account('account_gifts');">관심 목록</a> --%>
            <a href="${pageContext.request.contextPath}/mypage/auction" class="myAccountNav-btn" onclick="ga_clk_account('account_contacts');">지분 경매</a>
            <a href="${pageContext.request.contextPath}/mypage/deposit" class="myAccountNav-btn current" onclick="ga_clk_account('account_points');">예치금 관리</a>
            <%-- <a href="${pageContext.request.contextPath}/mypage/stock" class="myAccountNav-btn" onclick="ga_clk_account('account_contacts');">지분 거래</a> --%>
            <a href="${pageContext.request.contextPath}/mypage/revenue" class="myAccountNav-btn " >나의 수익</a>
            <a href="${pageContext.request.contextPath}/mypage/inquiry/inquiryList" class="myAccountNav-btn " >1:1 문의하기</a>
<c:if test="${mVO.authority eq 'ROLE_ARTIST'}">
            <a href="${pageContext.request.contextPath}/showroom/art/artistview.do?memberId=${mVO.memberId}" class="myAccountNav-btn " >나의 작품 </a>
            <a href="${pageContext.request.contextPath}/mypage/artist/artistWrite" class="myAccountNav-btn " >작품 등록하기</a>
</c:if>
        </nav>
        <section id="my_account_body" class="gift">
            <div class="inquiries_view contact">
                <div class="account-gifts">
                    <div class="account-gifts-text">
                        <h3 style="border-bottom: none;">사용 가능한 예치금</h3>
                        <fmt:formatNumber value="${balance+0 }" var="fmtBalance"/>
                        <span id="myBalance">${fmtBalance } 원</span>
                    </div>
                    <div id="gift_enrollment" data-toggle="modal" data-target="#myModal" 
                    	onclick="loadMemberInfo()">예치금 충전</div>
                    
                </div>
            </div>
            <div class="inquiries_view contact">
                <h3>예치금 충전 / 사용내역</h3>
                <div class="gift-table">
                    <table class="table" style="width: 100%">
                        <colgroup>
                        	<col width="5%">
                        	<col width="15%" >
                        	<col width="15%" >
                        	<col width="20%" >
                        	<col width="15%" >
                        	<col width="*" >
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="col" class="gift-contact">No.</th>
                                <th scope="col" class="gift-type">입금액</th>
                                <th scope="col" class="gift-text">출금액</th>
                                <th scope="col" class="gift-text">잔여예치금</th>
                                <th scope="col" class="gift-text">거래일자</th>
                                <th scope="col" class="gift-value text-left">비고</th>
                            </tr>
                            
                            <c:if test="${not empty balanceHistory }">
                            	<c:forEach var="history" items="${balanceHistory }">
	                            	<tr>
	                            		<td>${history.r}</td>
	                            		<td><fmt:formatNumber value="${history.deposit}"/> </td>
	                            		<td><fmt:formatNumber value="${history.withdraw}"/></td>
	                            		<td><fmt:formatNumber value="${history.balance}"/></td>
	                            		<td><fmt:formatDate value="${history.transtime}" dateStyle="medium" timeStyle="medium"/></td>
	                            		<td class="text-left">${history.history}</td>
	                            	</tr>
                            	</c:forEach>
                            </c:if>
                            <c:if test="${empty balanceHistory }">
	                            <tr>
	                                <td colspan="6" class="empty text-center">거래 내역이 없습니다.</td>
	                            </tr>                            
                            </c:if>
                            
                        </tbody>
                    </table>
                    
                </div>
                <div class="page_pageniation">
					<nav aria-label="Page navigation example">
						<!-- 페이지버튼 -->
						<ul class="pagination justify-content-center">${pagingBtn }</ul>
					</nav>
				</div>
            </div>
        </section>
    </div>
    
<!-- 모달 시작 /////////////////////////////////////////////////// -->
<!-- Button to Open the Modal -->
  <button type="button" hidden="" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
    Open modal
  </button>

  <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered modal-sm">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header bg-light">
          <h4 class="modal-title">예치금 충전하기</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<div class="row">     
	        	<h6 class="mx-auto">결제 정보 입력</h6>   	
	        		
	        	<div class="col-12">
	        		<input type="email" id="loadId" disabled="disabled" class="form-control mb-1" placeholder="아이디"/>
	        		<input type="text" id="loadName" class="form-control mb-1" placeholder="이름"/>
	        		<input type="number" maxlength="11" min="0" id="loadPhone" class="form-control mb-1" placeholder="전화번호"/>
	        	</div>
        	</div>
        	<hr />
        	<div class="row">        		
	        	<div class="col">
	        		충전금액:<input type="number" min="500" step="500" id="chargeVal"  class="form-control" />
	        	</div>
        	</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer bg-light" >
          <button type="button" class="btn btn-sm btn-danger" data-dismiss="modal">취소</button>
          <button id="btnPay"  type="button" class="btn btn-sm btn-primary" data-dismiss="modal" 
          	onclick="checkPayLoad();">결제</button>
        </div>
        
      </div>
    </div>
  </div>

<!-- 모달 끝 /////////////////////////////////////////////////// -->
</body>

<script>
//300000 => 300,000
function numberWithCommas(x) {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//	"￦800,000" => 800000
function priceParse(price){
	while(price.includes(" ")||price.includes(",")){
		price = price.replace(" ","").replace(",","");
	}
	price = price.replace("￦","");
	price = parseInt(price);
	return price;
}


</script>



<!-- 결제성공시 DB처리하기위한 함수 -->
<script>
function sucPayFunc(paidVal){
	console.log("sucPayFunc():호출됨,결제금:"+paidVal);
	$.ajax({
		url: "${pageContext.request.contextPath }/auction/view/deposit",
		type:'get',
		data:{
			memberId : "${memberId}",
			deposit : paidVal
		},
		dataType:'json',//콜백데이터타입
		contentType:"text/html;chatset:utf-8",//전송방식
		//POST 방식=> contentType:"application/x-www-form-urlencoded;charset:utf-8;",
		success : function(d){
			console.log("콜백데이터:",d); //Object
			console.log('d["1"]',d["1"]); // value값 파싱 성공
			
			//JSON 구조 : {"1":"입금처리완료"}
		    $.each(d,function(key,value){
				//출력결과 : key=1 : value=입금처리완료
		    	console.log("key=" + key + " : value=" + value);
		     
				if(key==1){
					//성공토스트창
					floatToast(value);
				}else if(key==2){
					//성공시 예치금 업데이트
					console.log("newBalance:"+value);
					$("#myBalance").text( numberWithCommas(value)+" 원" );
				}else{
					floatToast(value);
				}
		    });
		},error: function(e){
			console.log("checkpayload():error:"+e.status+e.statusText);
		}
	});
} 
</script>




<!-- 충전 버튼을 클릭하면 사용자정보를 불러온다. -->
<script>
function loadMemberInfo(){	
	$.ajax({
		url: "${pageContext.request.contextPath }/auction/view/getMemberInfo",
		type:'get',
		data:{
			auctionId : "${memberId}"
		},
		dataType:'json',//콜백데이터타입
		contentType:"text/html;chatset:utf-8",//전송방식
		//POST 방식=> contentType:"application/x-www-form-urlencoded;charset:utf-8;",
		success : function(d){
			var dStr = JSON.stringify(d);
			console.log(dStr);
			var parseData = JSON.parse(dStr);
			console.log("dStr",parseData);
			console.log("memberId:"+parseData.memberId);
			console.log("memberName:"+parseData.name);
			console.log("memberPhone:"+parseData.hp);
			const id = parseData.memberId;
			const name = parseData.name;
			const phone = parseData.hp;
		
			console.log("사용자정보 항목체크 승인");
			//이름, 폰, 아이디를 가져와서 빈칸을 체워줌
			$("#loadId").val(id);
			$("#loadName").val(name);
			$("#loadPhone").val(phone);				
		},
		error: function(e){
			console.log("checkpayload():error:"+e.status+e.statusText);
		}
	});
}


function checkPayLoad(){
	$("#loadId").val('${memberId}');
	console.log("checkPayLoad():호출됨");
	//충전금액의 값을 가져온다
	let putValue = $("#chargeVal").val();
	//putValue = parseInt(putValue);
	console.log("충전금액:",putValue);
	//금액을 입력하지 않은 경우
	
	if(putValue<100){
		floatToast("100원 이상 금액을 입력해주세요.");
		return;
	}

	let memberId = '${memberId}';
	let memberName = $("#loadName").val();
	let memberPhone = $("#loadPhone").val();			
	console.log("결제창 호출전 확인:",putValue,memberId,memberName,memberPhone);
	payload(putValue,memberId,memberName,memberPhone);
}
</script>


<!-- 빈값,널값 체크함수 -->
<script>
function isEmptyFunc(str){
  if(typeof str == "undefined" || str == null || str == "")
      return true;
  else
      return false ;
}
</script>

<!-- 아임포트 결제 api  -->

<!-- 아임포트 결제1 -->
<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script> -->
<!-- 아임포트 결제2 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
var IMP = window.IMP; // 생략가능
function payload(putValue,memberId,memberName,memberPhone){
	IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	IMP.request_pay({
	    pg : 'inicis', // version 1.1.0부터 지원.
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '주문명:예치금충전',
	    amount : putValue, //최소결제금액이하에러(현대카드:최소50원, 카카오페이:최소100원)
	    buyer_email : memberId,
	    buyer_name : memberName,
	    buyer_tel : memberPhone,
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456',
	    m_redirect_url : '#'//결제 결과를 받을 주소를 지정
	}, function(rsp) {
	    if ( rsp.success ) {
	        var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	        sucPayFunc(rsp.paid_amount);
	        /* 결제하면 뜨는 내용
		        결제가 완료되었습니다.
		        고유ID : imp_069523263238
		        상점 거래ID : merchant_1596093522091
		        결제 금액 : 100
		        카드 승인번호 : 00969974
	        */
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    console.log(msg);
	});
}
</script>

<!-- 인자값:문자열을 받아서 띄우는 토스트창 함수 -->
<script>
function floatToast(msg){
	$('.toast-body').text(msg);
	$('.toast').toast({delay: 2000});
	$('.toast').toast('show');
}
</script>



	
<!--경매가 종료된 페이지일경우 낙찰 정보를 리스팅한다.  -->
<script>
//빈값이 아닐경우 받은 가변인자들을 선택자로 선택해 속성적용
/*
function emptyIsDisable(){
	console.log("emptyIsDisable():",arguments);
	for(var i=0; i< arguments.length; i++){
		if(!isEmptyFunc($("#loadId")) ){
			$(arguments[i]).removeAttr("disabled").removeAttr("placeholder");
		}
	}
}
*/
</script>

<!-- 페이지 로딩후 자동 실행 함수들 -->	
<script>

$(function() {

	
	//금액입력할때 콤마표시로 바꿔줌
	$("[type=number]").on("keyup",function(){
		console.log("ddddd");
	});
	
	
	
	
});
</script>


	
</html>