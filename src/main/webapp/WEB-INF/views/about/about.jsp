<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!doctype html>
<html lang="en">

<head>
    <title>아루에</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>    
<style>
.customoverlay {position:relative;bottom:50px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}

.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}

.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;
            font-size:10px;font-weight:bold;overflow:hidden;background: #238cfa;
            background: #238cfa url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}

.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;
                  padding:10px 15px;font-size:10px;font-weight:bold;}

.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;
                  height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}


#map{
   width:100%; height:500px;
}
#googlemap{
   width:800px; height:500px;
   margin-right: auto; margin-left: auto;
}

header {text-align: center;}

p{font-family: Noto Sans KR, sans-serif; font-size: 1em;}

h1{align-content:center; font-family: Noto Sans KR, sans-serif; }

h3{color: #01579B}

h4{text-align: center; font-family: Noto Sans KR, sans-serif; color: #01579B}

#BizCategory{font-family: Noto Sans KR, sans-serif; text-align: center;}
         
#table{align-items: center; margin: auto;}

img{object-fit: cover;}

.card-columns {
    column-gap: 70px;
}

#infoimage {width: 120px; height: 120px; object-fit: cover;}
</style>    
    
</head>

<body>


    <!--::header part start::-->
   
    <!-- Header part end-->

    <!-- breadcrumb start-->

    
    
    <section class="" style="padding-top: 100px;">         
      <div class="container">
         <div class="col-lg-12" style="width: 100%; margin-right: auto; margin-left: auto;">

         <table class="table table-borderless justify-content-center" id="table">
            <thead align="center">
               <tr>
                  <td width="col-lg-4">
                  </td>
                  
                  <td width="col-lg-4">
                  </td>
                  
                  <td width="col-lg-4">
                  </td>
               </tr>
            </thead>                        
            <tbody>
               <tr align="center" >
                  <td colspan="3" style="padding-bottom: 80px">
                     <h1>사업소개</h1>
                     <p>
                     Introduction
                     </p>
                  </td>
               </tr>
               <tr align="center">
                  <td>
                     <img src="resources/img/main_slider/working_artist.jpg" alt="Pic 01" class="rounded-circle" 
                     width="200px" height="200px" id="img1" border="1px" />
                  </td>
                  
                  <td>
                     <img src="resources/img/main_slider/public_space.jpg" alt="Pic 02" class="rounded-circle" 
                     width="200px" height="200px" id="img2" border="1" style="border-color: solid black" />
                  </td>
                  
                  <td>
                     <img src="resources/img/main_slider/checking.jpg" alt="Pic 03" class="rounded-circle" 
                     width="200px" height="200px" id="img3" border="1px" />
                  </td>
               </tr>
               <tr>
                  <td>
                     <header>
                     <h3 id="BizCategory"><b>예술인 지원</b></h3>
                     </header>
                     
                     <p style="text-align: center;">
                     예술인에게 자신의 작품을 대중에게<br />
                     알리는 플랫폼을 제공합니다.<br />
                     지속적인 소득은 작가의 활동을 돕습니다.
                     </p>
                  </td>
                  <td>
                     <header>
                     <h3 id="BizCategory"><b>인테리어</b></h3>
                     </header>
                     
                     <p style="text-align: center;">
                     저가로도 미술품 대여를 할 수 있습니다.<br />
                     인테리어에 주기적인 변화를 원하시는<br /> 
                     고객에게 추천하는 서비스입니다.
                     </p>
                  </td>
                  <td>
                     <header>
                     <h3 id="BizCategory"><b>체계적인 관리</b></h3>
                     </header>
                     
                     <p style="text-align: center;">
                     환경에 민감한 미술작품을 전문적으로<br /> 
                     관리하여 항상 최고의 품질로 유지하여<br />
                     사용자의 만족도를 높이고자 합니다.    
                     </p>
                  </td>
               </tr>
               
            </tbody>
               
         </table>

         </div>
      </div>
   </section>
    

   <section class="" style="padding-top: 130px;">         
      <div class="container">
         <div class="col-lg-10" style="width: 70%; margin-right: auto; margin-left: auto;">

         <table class="table table-borderless justify-content-center" id="table">
            <thead align="center">
               <tr>
                  <td width="col-lg-5">
                  </td>
                  
                  <td width="col-lg-5">
                  </td>
               </tr>
            </thead>                        
            <tbody>
               <tr align="center" >
                  <td colspan="2" style="padding-bottom: 80px">
                     <h1>사업분야</h1>
                     <p>
                     Businesses
                     </p>
                  </td>
               </tr>
               <tr align="center">
                  <td style="margin-left: 50px;">
                     <img src="resources/img/main_slider/rent.jpg" alt="Pic 01" class="rounded-circle" 
                     width="200px" height="200px" id="img1" border="1px" />

                  </td>         

                  <td>
                     <img src="resources/img/main_slider/auction_room.jpg" alt="Pic 03" class="rounded-circle" 
                     width="200px" height="200px" id="img3" border="1px" />
                  </td>
               </tr>
               <tr>
                  <td>
                  <header>
                  <h3 id="BizCategory"><b>작품렌탈</b></h3>
                  </header>
                  
                  <p style="text-align: center;">
                  전문가가 선정한 눈여겨볼 신인들,<br />
                  예술분야에서 주목받는 작가들의 작품을<br /> 
                  한눈에 볼 수 있습니다.<br />
                  회원이라면 누구나 대여할 수 있습니다.
                  </p>
               </td>

               <td>
                  <header>
                  <h3 id="BizCategory"><b>지분경매</b></h3>
                  </header>
                  
                  <p style="text-align: center;">
                  아루에에 등록된 작가들의 작품<br /> 
                  지분이 경매에 등록됩니다.<br />
                  회원이라면 누구나 참여할 수 있습니다.
                  </p>
               </td>
               </tr>
            </tbody>
               
         </table>

         </div>
      </div>
   </section> 
    

    
  <!-- ================ contact section start ================= -->
  <section>
   <div class="row" style="padding-top: 350px; padding-bottom: 30px;" align="center">
      <div class="container">
         <div class="col-lg-12" style="width: 100%">
              <div class="col-12-lg" align="center">
                   <h1 style="font-family: Noto Sans KR, sans-serif;">렌탈작품 현위치</h1>
                  <p style="font-family: Noto Sans KR, sans-serif; text-align: center;">
                     Artwork Locations
                  </p>
              </div>
           </div>
        </div>
   </div>  
  </section>
  

  
<!-- 여기는 구글 API -->
<c:choose>
   <c:when test="${param.distance eq 5 }">
      <c:set var="zoomLevel" value="13" />
   </c:when>
   <c:when test="${param.distance eq 7 }">
      <c:set var="zoomLevel" value="12" />
   </c:when>
   <c:when test="${param.distance eq 10 }">
      <c:set var="zoomLevel" value="11" />
   </c:when>
   <c:otherwise>
      <c:set var="zoomLevel" value="10" />
   </c:otherwise>
</c:choose>
<script type="text/javascript">

var span;
window.onload = function(){
   span = document.getElementById("result");
   
   if(navigator.geolocation){
      span.innerHTML = " ";
      
      var options = {   
         enableHighAccurcy:true, 
         timeout:5000,
         maximumAge:3000
      };
      navigator.geolocation.getCurrentPosition(showPosition,showError,options);
   }
   else{
      span.innerHTML = "이 브라우저는 Geolocation API를 지원하지 않습니다.";
   }   
}

var showPosition = function(position){
   //위도를 가져오는 부분
   var latitude = position.coords.latitude;
   //경도를 가져오는 부분
   var longitude = position.coords.longitude;
   
   ////////////////////////////////////////////////////////////////////////
   //위경도를 text input에 입력
   document.getElementById("latTxt").value = latitude;
   document.getElementById("lngTxt").value = longitude;
   ////////////////////////////////////////////////////////////////////////
         
   //위경도를 가져온후 지도 표시
   initMap(latitude, longitude) ;
}

function initMap(latVar, lngVar) {            
   var uluru = {lat: latVar, lng: lngVar};
   var map = new google.maps.Map(document.getElementById('map'), {
      zoom: ${zoomLevel},
      center: uluru
   });
   //현재 내 위치를 맵에 표시
   var marker = new google.maps.Marker({
      position: uluru,
      map: map,
      /////////////////////////////////////////////////////////////////////
      //내위치 아이콘 변경
      icon: '${pageContext.request.contextPath}/resources/img/icon/icon_me.png'
         //   /alouer/src/main/webapp/resources/img/icon/icon_facil.png
      /////////////////////////////////////////////////////////////////////
   });
   
   //////////////////////////////////////////////////////////////////////////
   //다중마커s
   var infowindow = new google.maps.InfoWindow();
      
    //시설을 맵에 표시
   var locations = [      
      <c:forEach items="${searchLists }" var="row">
         ['${row.title}', ${row.lat }, ${row.lng }, '${row.code}', '${row.imageUrl}'], 
      </c:forEach>
   ];
   console.log("locations:", locations);
   
    var marker, i;

   for (i=0; i<locations.length; i++) {  
      marker = new google.maps.Marker({
         id:i,
         position: new google.maps.LatLng(locations[i][1], locations[i][2]),
         map: map,
         icon: '${pageContext.request.contextPath}/resources/img/icon/icon_facil.png'
      });
   
      google.maps.event.addListener(marker, 'click', (function(marker, i) {
         return function() {
            //정보창에 HTML코드가 들어갈 수 있음.0번 인덱스는 작품 제목임.
            infowindow.setContent
            (locations[i][0]+"<br/><img id='infoimage' src='"+locations[i][4]+"'><br/><a href='${pageContext.request.contextPath}/showroom/art/view.do?code="+locations[i][3]+"'>상세보기</a>");
            infowindow.open(map, marker);
         }
      })(marker, i));
   
      if(marker)
      {
         marker.addListener('click', function() {
            map.setZoom(16);
            map.setCenter(this.getPosition());
         });
      }
   }
   //다중마커s
   //////////////////////////////////////////////////////////////////////////
}

var showError = function(error){
   switch(error.code){
      case error.UNKNOWN_ERROR:
         span.innerHTML = "알수없는오류발생";break;
      case error.PERMISSION_DENIED:
         span.innerHTML = "권한이 없습니다";break;
      case error.POSITION_UNAVAILABLE:
         span.innerHTML = "위치 확인불가";break;
      case error.TIMEOUT:
         span.innerHTML = "시간초과";break;
   }
}
</script>

<div class="container" style="padding-bottom: 50px;">
   
   <span type="hidden" id="result" style="color:blue; font-size:8px;"></span>
   <fieldset>
      <form name="searchFrm">
      <div align="center">
         현재위치에서
         <!-- 현재위치 위경도 입력상자 -->
         <input type="hidden" id="latTxt" name="latTxt" />
         <input type="hidden" id="lngTxt" name="lngTxt" />
          
         <select name="distance" id="distance">
            <option value="5" <c:if test="${param.distance==5 }">selected</c:if>>5Km</option>
            <option value="7" <c:if test="${param.distance==7 }">selected</c:if>>7Km</option>
            <option value="10" <c:if test="${param.distance==10 }">selected</c:if>>10Km</option>
            <option value="15" <c:if test="${param.distance==15 }">selected</c:if>>15Km</option>
            <option value="20" <c:if test="${param.distance==20 }">selected</c:if>>20Km</option>
            <option value="50" <c:if test="${param.distance==50 }">selected</c:if>>50Km</option>
         </select>
         반경내 작품 검색하기
          
         <input class="btn btn-outline-secondary" type="submit" value="검색" />
      
      </div>
         
      </form>
   </fieldset>

   <br />
   <div id="map"></div>
   <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCCSHid14Fz-pUKa0vewPRvQz9y7VU3JWc"></script>
</div>  

  

  <!-- ================ contact section end ================= -->
  
  

  <!-- social_connect_part part end-->

   <!-- footer part start-->

    <!-- footer part end-->

  <!-- jquery plugins here-->

</body>

</html>