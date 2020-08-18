<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!-- action > view -->

<!--Spring Security에서 제공하는 form태그 사용을 위한 선언  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!--Spring Security에서 제공하는 security 관련 태그사용을 위한 선언  -->
<%@ taglib prefix="sec"   uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL의 국제화 라이브러리를 사용하기 위한 지시어 선언 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${artsDTO.title }</title>

<!--jquery와 부트스트랩 CDN 추가함 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<!-- jQuery library -->
<script   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<!-- 아임포트 결제1 -->
<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script> -->
<!-- 아임포트 결제2 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<!-- 폰트; Noto Sans KR -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap" rel="stylesheet">
<!-- share icon -->
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<!-- StyleSheet -->
<link rel="stylesheet"
   href="https://og-data.s3.amazonaws.com/CACHE/css/da921b58086e.css"
   type="text/css">
<link rel="stylesheet"
   href="https://og-data.s3.amazonaws.com/CACHE/css/1dabfcb04043.css"
   type="text/css">
<link rel="stylesheet"
   href="${pageContext.request.contextPath }/resources/css/auction/Auction.css"
   type="text/css">
   

</head>
<style>
.currentBid td{ text-align: center;}
p{font-family: font-family: 'Roboto', 'Noto Sans KR','Malgun Gothic', sans-serif; }
</style>
<body>
   <section class="artworkDetail-head">
      <span class="artworkDetail-artworkTitle">${artsDTO.title }</span>
      <span id="timeOut" class="float-right text-danger" style="display: inline;">경매 준비중 입니다</span>
   </section>
   
   <div class="artworkDetail">
      <div class="artworkDetail-inner">
         <div class="row " >
            <!-- 이미지 뷰어 -->
            <div class="col-7" id="artCol">
               <section class="artworkDetail-artworkImage">
                  <div class="artworkDetail-imageViewer">
                     <div class="artworkDetail-imageViewer-imgWrap">
                        <img class="artworkDetail-imageViewer-img" src="${artsDTO.imageUrl }" data-image_url="${artsDTO.imageUrl }" style="cursor: auto;">
                     </div>
                  </div>
                  
                  <div class="detail-right-text">
                     <div class="productT p-3 rounded-lg bg-light" >
                        <div class="product-about">${artsDTO.name }</div>
                        <span>출시년도 : ${artsDTO.prodYear }년</span><br /> 
                        <span>소재 : ${artsDTO.material }</span><br /> 
                        <span>사이즈 : ${artsDTO.width+='x'+=artsDTO.height+=' ('+= artsDTO.sizeHo+='호)' }</span>
                     </div>
                  </div>
                  <div class="artworkDetail-copyright" >
                     이미지를 클릭하면 확대하여 보실 수 있습니다.<br class="artworkDetail-copyright-br">
                     무단 도용 및 재배포를 금지합니다.<br> Copyright &copy; ${artsDTO.name } All
                     rights reserved.
                  </div>
               </section>
                  
            </div>


            <div class="col-5" id="bidCol" style="border: 0px solid red; box-sizing: border-box;">
               
               <div class="detail-right detailRight">
               <!--<div class="unit"><span class="re-red">(단위: KRW)</span></div> -->
                  <ul class="detail-texts detaileTexts p-3 rounded-lg bg-light mt-2">
                     <li class="clear">
                        <span class="detail-texts-name">작품 추정가치</span>
                        <span class="detail-texts-name1">
                           ￦<fmt:formatNumber value="${artsDTO.artValue - artsDTO.artValue*0.2}"/>
                           ~ <fmt:formatNumber value="${artsDTO.artValue + artsDTO.artValue*0.2}"/>
                        </span>
                     </li>
                     <li class="clear">
                        <span class="detail-texts-name">시작가</span>
                        <span class="detail-texts-name1">
                           <fmt:formatNumber value="${auctionInfoDTO.startBids }" type="currency"/>
                        </span>
                     </li>
                     <li class="clear">
                        <span class="detail-texts-name">낙찰최저가</span> 
                        <span class="detail-texts-name1 detail-texts-name1-color" id="nowPrice" >
                           <fmt:formatNumber value="${auctionInfoDTO.minPrice}" type="currency"/>
                        </span>
                     </li>
                     <li class="clear">
                        <span class="detail-texts-name">지분경매수량</span> 
                        <span class="detail-texts-name1 detail-texts-name1-color" id="auctionTotal" >
                           <fmt:formatNumber value="${auctionInfoDTO.auctionTotal}"  />
                        </span>
                     </li>
                     
                        <!-- <hr style="line-height: 50%;"/> -->
                     <li class="clear">
                        <hr />
                        <div>
                           <span class="detail-texts-name ">입찰수량</span> 
                           <span class="detail-input " >
                               <input type="number" min="1" step="1" id="lot" maxlength="4" size="4" value="1"/>주
                           </span>                           
                        </div>
                     </li>
                     <li class="clear">
                        <div >
                           <span class="detail-texts-name">입찰가격</span> 
                           <span class="detail-input" >
                               <input  type="number" name="bidsPrice" step="1000" min="1000" id="bidsPrice" value=""/>원
                           </span>      
                        </div>   
                     </li>
                     <li class="clear">                  
                        <div>
                           <span class="detail-texts-name">총 입찰가</span> 
                           <span class="detail-input" >
                               <input  type="number" name="totalPrice" id="totalPrice" disabled="disabled"/>원
                           </span>   
                        </div>   
                     </li>   
                     <li>
                        <div>
                           <span class="detail-texts-name">나의 예치금</span>
                           <span class="detail-input">
                              <sec:authorize access="isAuthenticated()">
                                 <button class="btn btn-sm btn-dark" onclick="loadMemberInfo()" data-toggle="modal" data-target="#myModal">
                                    충전</button>
                               </sec:authorize>
                              <fmt:formatNumber value="${balance }" var="fmtBalance"/>
                              <input id="myBalance" type="text" value="${fmtBalance }" disabled="disabled"/>원
                           </span>
                        </div>
                     </li>
                  
                     <li class="clear order">
                        <div class="mt-4 ">
                           <!--action="${pageContext.request.contextPath }/auction/view.do"  -->         
                           <div class="btn btn-dark btn-sm rounded w-100" id="bidPut" >입찰하기</div>      
                           <div class="rate text-center">경매 수수료율 : 낙찰가 * 0.2%</div>
                        </div>
                     </li>
                  </ul> 
                  <!-- 입찰하기 버튼 클릭후 띄우는 토스트창 -->
                  <div class="toast ml-5 centered" data-autohide="true" style="width:100%; float: none; position: absolute; top: 25%;vertical-align:middle;" >
                      <div class="toast-header bg-dark" >
                        <strong class="mr-auto text-light">결과 </strong>
                      </div>
                      <div class="toast-body">입찰되었습니다.</div>
                  </div>
                  <div hidden class="mt-3"  style="float: inherit;">
                     <p>경매아이디:<input type="text" value="${auctionInfoDTO.auctionId }" name="auctionId" size="3"/></p>
                     <p>멤버아이디:<input type="text" value="${memberId }" name="memberId" /></p>                     
                     <p>시작:<input type="text" value="${auctionInfoDTO.startTime }" name="startTime" /></p>                     
                     <p>종료:<input type="text" value="${auctionInfoDTO.endTime }" name="endTime" /></p>                     
                     <p>작품코드:<input type="text" value="${artsDTO.code }" name="code" size="8"/>   </p>                        
                     <p>작품제목:<input type="text" value="${artsDTO.title }" name="title" size="8"/>   </p>                        
                  </div>
               </div>
            </div>
         </div>
         
         <!-- 실시간 경매 현황 판 -->
         <div class="row mt-4"  >
            <div class="col-6 currentDisplay">
               <div id="tableTitle" class="title bg-dark text-center  p-2 2em " >입찰현황</div>
               <table class="table table-hover mt-0 mb-5 ml-3 mr-3" >
                  <thead>
                     
                     <tr>
                        <th class="pl-1 pr-1">No.</th>
                        <th class="pl-1 pr-1">입찰가<br>(1주)</th>
                        <th class="pl-1 pr-1">입찰시간</th>
                      </tr>
                  </thead>
                  <tbody class="currentBid" style="overflow: auto; height: 300px;">
                     <c:if test="${empty auctionResult }">
                        <tr>
                           <td colspan="4" id="introStr">실시간 입찰 현황이 표시됩니다.</td>
                        </tr>                  
                     </c:if>
                     <c:if test="${not empty auctionResult }">
                        <c:forEach items="${auctionResult }" var="AuTransDTO">
                           <tr>
                              <td>${AuTransDTO.rn }</td>
                              <td><fmt:formatNumber value="${AuTransDTO.bidsPrice }"/></td>
                              <%-- <td><fmt:formatDate value="${AuTransDTO.fmtAuctionTime }" dateStyle="short" timeStyle="short" type="both" /> </td> --%>
                              <td>${AuTransDTO.fmtAuctionTime } </td>
                           </tr>
                        </c:forEach>
                     </c:if>
                     
                  
                  </tbody>
               </table>
            </div>
            
            <div class="col-6 currentAuction" >
               <div id="tableTitle" class="title text-center bg-dark p-2  2em " >경매현황</div>
               <table class="table table-hover mt-0 mb-5  ">
                  <thead>
                     <tr>
                        <th class="pl-1 pr-1">입찰수량</th>
                        <th class="pl-1 pr-1">입찰가<br>(1주)</th>
                        <th class="pl-1 pr-1">옥션결과</th>
                      </tr>
                  </thead>
                  <tbody class="currentBid " style="overflow: auto; height: 300px;">
                     <c:if test="${empty auctionResult }">
                        <tr>
                           <td colspan="4" id="introStr">실시간 낙찰 예상이 표시됩니다.</td>
                        </tr>                  
                     </c:if>
                     <c:if test="${not empty auctionResult }">
                        <c:forEach items="${auctionResult }" var="AuTransDTO">
                           <tr>
                              <td>${AuTransDTO.lot }</td>
                              <td><fmt:formatNumber value="${AuTransDTO.bidsPrice }"/></td>
                              <td> <td>
                           </tr>
                        </c:forEach>
                     </c:if>
                     
                  
                  </tbody>
               </table>
            </div>
         </div>
         
         <!-- 작품상세보기 -->
         <section class="artworkDetail-section">
            <div class="artworkDetail-infoTable">
               <div class="artworkDetail-infoTable-head cf">
                  <div class="artworkDetail-collectionBox" data-code="A0113-0014"></div>
                  <div class="artworkDetail-shareButton" data-pathname="/artwork/A0113-0014/" data-txt="이흙 작가 <어느 날 구름-my home> #오픈갤러리 #작품정보"></div>
               </div>
               <div class="artworkDetail-infoTable-body">
                  <div class="artworkDetail-artistInfo">
                     <div class="artworkDetail-artworkInfo-left">

                        <a href="/artist/A0113/#cv" class="artworkDetail-artistLink">${artsDTO.name }</a>
                        <a href="${pageContext.request.contextPath}/showroom/art/artistview.do?memberId=${artsDTO.memberId}" onclick="ga_evt_artwork('detail_action', 'more_artwork', '${artsDTO.code}')" class="artworkDetail-artistTableBtn">작품 더보기</a>

                        <div class="artist-education-set">
                           <span>${edu }</span>
                        </div>
                     </div>
                  </div>
                  <div class="artworkDetail-infoTable-details">
                     <h2 class="artworkDetail-title">${artsDTO.title }</h2>
                     <p class="artworkDetail-infoTable-details-p">
                        ${artsDTO.material } <br /> ${artsDTO.height }x${artsDTO.width }cm
                        (${artsDTO.sizeHo }호), ${artsDTO.prodYear } <span
                           class="artworkDetail-code-view">작품코드 : ${artsDTO.code }</span>
                     </p>
                     <input type="hidden" name="rental_rate_value" value="99000">
                     <p class="artworkDetail-infoTable-details-pNotice">
                        * 출장비 및 설치비는 별도입니다.<br> * 렌탈 중인 작품 구매시 렌탈요금을 돌려드립니다.<br>
                        * 작품에 따라 액자가 포함될 수 있습니다.
                     </p>
                  </div>
               </div>
            </div>
         </section>
         <section class="artworkDetail-section">
            <h3 class="artworkDetail-section-title">큐레이터 노트</h3>
            <div class="artworkDetail-section-bar"></div>
            <div class="artworkDetail-note_recommend">${artsDTO.note1 }</div>
         </section>
         <section class="artworkDetail-section">
            <h3 class="artworkDetail-section-title">추천 이유</h3>
            <div class="artworkDetail-section-bar"></div>
            <div class="artworkDetail-note_recommend">${artsDTO.note1 }</div>
         </section>
         
      </div>
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

<!-- 모바일 사이즈로 로딩시 입찰 부분의 css를 변경 -->
<script>
$(function(){
    if($(window).width() < 767)
    {
        $("#artCol").attr("class","col-12");
        $("#bidCol").attr("class","col-12");
    } else {
       $("#artCol").attr("class","col-7");
       $("#bidCol").attr("class","col-5");
    }
});
</script>




<script>
//입찰 리스트를 반복 호출하는 함수를 중지하기위한 전역변수
let bidListingPlag;
//경매 현황을 반복 호출하는 함수를 중지하기위한 전역변수
let currentAuctionListingPlag;
//300000 => 300,000
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//   "￦800,000" => 800000
function priceParse(price){
   while(price.includes(" ")||price.includes(",")){
      price = price.replace(" ","").replace(",","");
   }
   price = price.replace("￦","");
   price = parseInt(price);
   return price;
}
function bidSuccess(d){
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
         $("#myBalance").val( numberWithCommas(value)+" 원" );
      }else{
         floatToast(value);
      }
    });
}
function bidError(e){
   floatToast("실패:"+e.status+e.statusText);
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
               $("#myBalance").val( numberWithCommas(value) );
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
         $("#loadPhone").val(콜);            
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
   $('.toast').toast({delay: 5000});
   $('.toast').toast('show');
}
</script>


<!-- 실시간 입찰현황을 갱신  -->
<script>
function biddingList(){
   console.log("입찰현황갱신");
   //실시간 경매 현황을 갱신
   $.ajax({
      url: "${pageContext.request.contextPath }/auction/view/bidListing",
      type:'get',
      data:{
         auctionId : $("input[name='auctionId']").val()
         /* code : $("input[name='code']").val(), */
      },
      dataType:'json',//콜백데이터타입
      contentType:"text/html;chatset:utf-8",//전송방식
      /*POST 방식=> contentType:"application/x-www-form-urlencoded;charset:utf-8;",*/
      success : function(d){
         var dStr = JSON.stringify(d);
         let htmlStr = "";
         $(d).each(function(index,item){
            var strData = JSON.stringify(d[index]);
            var parseData = JSON.parse(strData);
            let memberId = parseData.memberId;
            for(var i=0; i<3; i++){
               memberId = memberId.replace(memberId.charAt(i), "*");
            }
            htmlStr +=   
               '<tr>'+
                  '<td>'+parseData.rn+'</td>'+
                  "<td>"+numberWithCommas(parseData.bidsPrice)+"</td>"+
                  '<td>'+parseData.fmtAuctionTime+'</td>'+
               '</tr>';      
         })
         $(".currentDisplay table tbody").append().html(htmlStr);
      },
      error: function(e){
         console.log("biddingList():error:" + e.status + e.statusText);
      }
   });
   setTimeout(biddingList, 2000);
}
</script>

   
<!-- 경매 현황 낙찰 예상리스트 -->
<script>
let auctionTotal = ${auctionInfoDTO.auctionTotal};


function currentAuctionList(){
   console.log("경매현황갱신");
   var totalBids = 0;
   
   //실시간 경매 현황을 갱신
   $.ajax({
      url: "${pageContext.request.contextPath }/auction/view/currentAuction",
      type:'get',
      data:{
         auctionId : $("input[name='auctionId']").val()
      },
      dataType:'json',//콜백데이터타입
      contentType:"text/html;chatset:utf-8",//전송방식
      /*POST 방식=> contentType:"application/x-www-form-urlencoded;charset:utf-8;",*/
      success : function(d){
         var dStr = JSON.stringify(d);
         let htmlStr = "";
         $(d).each(function(index,item){
            var strData = JSON.stringify(d[index]);
            var parseData = JSON.parse(strData);
            let resultBid = ""; 
            console.log("auctionTotal",auctionTotal)
            console.log("totalBids",totalBids)
            
            if(auctionTotal > totalBids ){
               totalBids = totalBids+parseData.lot;
               resultBid = "낙찰예정";
            }else{
               resultBid = " ";
            }
            console.log("결과:",resultBid,index+' lot:',parseData.lot,'auctionTotal:',auctionTotal,'totalBids:',totalBids)
            htmlStr +=   
               '<tr>'+
                  '<td>'+parseData.lot+'</td>'+
                  "<td>"+numberWithCommas(parseData.bidsPrice)+"</td>"+
                  '<td>'+resultBid+'</td>'+
               '</tr>';      
         })
         $(".currentAuction table tbody").append().html(htmlStr);
      },
      error: function(e){
         console.log("currentAuctionList():error:" + e.status + e.statusText);
      }
   });
   setTimeout(currentAuctionList, 3000);
}
</script>


<!--경매가 종료된 페이지일경우 낙찰 정보를 리스팅한다.  -->
<script>

//경매가 종료되면 입찰방지
function setEndAuction(){
   $("#lot, #bidsPrice, #totalPrice").attr("disabled","disabled");
   $(".order").css("display","none");
   $(".spinner1").css("display","none");
   clearTimeout(bidListingPlag);//입찰 현황 갱신 함수 중지
   clearTimeout(currentAuctionListingPlag);//입찰 현황 갱신 함수 중지
   $("#tableTitle").text("낙찰현황");
   $("#introStr").text("낙찰현황이 표시됩니다.");
}


</script>

<!-- 페이지 로딩후 자동 실행 함수들 -->   
<script>

$(function() {
   //옥션수량
   const auctionTotal = ${auctionInfoDTO.auctionTotal};//현재 10
   //실시간 경매현황 자동 호출
   bidListingPlag = setTimeout(biddingList, 2000);
   //실시간 낙찰현황 자동 호출
   currentAuctionListingPlag = setTimeout(currentAuctionList, 3000);
   currentAuctionList();
   
   
   //입찰 수량에 따라 입찰 가격을 자동 계산
   $("#lot, #bidsPrice").on("change",function(e){
      console.log("입찰수량,입찰가격변경 적용");
      let lot = $("#lot").val();      //입찰수량
      let bidsPrice = $("#bidsPrice").val();//입찰가격
      let totalPrice = lot*bidsPrice;
      $("#totalPrice").val(totalPrice);
   });
   
   $("div#bidPut").on("click", function(){
      console.log("입찰하기버튼클릭됨"+$("#bidsPrice").val());
      
      let val = $("#bidsPrice").val(); //입찰가에 입력한 금액
      let nowPrice = $("#nowPrice").text(); //현재가
      console.log("val:",val);
      console.log("nowPrice>"+priceParse(nowPrice));
      console.log("회원의예치금:", ${balance+0 });
      
      //로그인하지 않은경우 null값처리 (+0 중요)
      var balance = ${balance+0};
      var memberid = '${memberId}';
      if(memberid == ''){
         floatToast("로그인이 필요합니다.");
         return;      
      }else if(val < 1000 || val % 1000 !=0 ||val == ''||val==null){
         floatToast("1000원 단위로 입찰가능 합니다.");
         return;         

      }else if(val < ${auctionInfoDTO.startBids+0 }){

         floatToast("시작가 이상 입찰가능 합니다.");
         return;                  
      }else if(val > balance){
         floatToast("입찰가격보다 예치금이 부족합니다.");
         return;
      }else{
         //컨트롤러로 입찰요청을 보냄
         biddingLogic();      
      }
   });
});
</script>

   
   
   
<!-- view에서 검증을 마친후 컨트롤러에 입찰처리 함수-->
<script>
function biddingLogic(){
   $.ajax({
      url: "view/bid",
      /*url: "${pageContext.request.contextPath }/auction/view/bid",*/
      type:'get',
      data:{
         //입찰가격
         code : $("input[name='code']").val(),
         auctionId : $("input[name='auctionId']").val(),
         memberId : $("input[name='memberId']").val(),
         bidsPrice : $("#bidsPrice").val(),
         lot : $("#lot").val(),   
         totalPrice : $("#totalPrice").val(),
         title : $("input[name='title']").val()
      },
      dataType:'json',//콜백데이터타입
      contentType:"text/html;chatset:utf-8",//전송방식
      /*POST 방식=> contentType:"application/x-www-form-urlencoded;charset:utf-8;",*/
      success : bidSuccess,
      error: bidError
   });
}
</script>

   
<!-- 카운트다운 함수 -->
<script>
/* 카운트 다운 함수 */
const countDownTimer = function (id, date) { 
   var _vDate = new Date(date); // 전달 받은 일자 
   var _mileSecond = 100; 
   var _second = 1000; 
   var _minute = _second * 60; 
   var _hour = _minute * 60; 
   var _day = _hour * 24; 
   var timer; 
   function showRemaining() { 
      var now = new Date(); 
      var distDt = _vDate - now; 
      if (distDt < 0) { 
         clearInterval(timer); 
         document.getElementById(id).innerHTML = '해당 경매가 종료 되었습니다!'; 
         setEndAuction();//경매가 종료표시되는 요소를 변경시킴
         return; 
      }
      var days = Math.floor(distDt / _day); 
      var hours = Math.floor((distDt % _day) / _hour); 
      var minutes = Math.floor((distDt % _hour) / _minute); 
      var seconds = Math.floor((distDt % _minute) / _second); 
      var mileSeconds = Math.floor((distDt % _second) / _mileSecond); 
      //document.getElementById(id).textContent = date.toLocaleString() + "까지 : "; 
      document.getElementById(id).innerHTML = days + '일 '; 
      document.getElementById(id).innerHTML += hours + '시간 '; 
      document.getElementById(id).innerHTML += minutes + '분 '; 
      document.getElementById(id).innerHTML += seconds + '초 '; 
      document.getElementById(id).innerHTML += mileSeconds; 
   } 
   timer = setInterval(showRemaining, 100); 
} 
//경매종료시간
if(${not empty auctionInfoDTO.fmtEndTime}){
   var endTime = '<c:out value='${auctionInfoDTO.fmtEndTime}' />'
   console.log("endTime:"+endTime);
   countDownTimer('timeOut',endTime); 
}
//var dateObj = new Date(); 
//dateObj.setDate(dateObj.getDate()+1); 
//dateObj.setDate(timestamp);
//console.log("timestamp:",timestamp);
//new Date("2020-07-27 18:23:01:000")
//카운드다운함수(카운트다운을표시할DOM, 미래시간)
//countDownTimer('timeOut',endTime); 
// 내일까지 countDownTimer('sample02', '04/01/2024 00:00 AM'); 
// 2024년 4월 1일까지, 시간을 표시하려면 01:00 AM과 같은 형식을 사용한다. countDownTimer('sample03', '04/01/2024'); 
// 2024년 4월 1일까지 countDownTimer('sample04', '04/01/2019'); 
// 2024년 4월 1일까지 

</script>



</html>


















