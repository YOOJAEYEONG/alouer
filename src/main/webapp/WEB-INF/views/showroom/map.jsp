<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">

<head>
 	<title>작품 현위치</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>	
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
#rentalStatus{text-align: left;}
#map{border-color: blue; border: 1px;}
</style> 
</head>

<body>


    <!--::header part start::-->
   
    <!-- Header part end-->

    <!-- breadcrumb start-->
    <section class="breadcrumb breadcrumb_bg align-items-center">
        <div class="container">
            <div class="row align-items-center justify-content-between">
                <div class="col-sm-6">
                    <div class="breadcrumb_tittle text-left">
                        <h2>Contact us</h2>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="breadcrumb_content text-right">
                        <p>Home<span>/</span>contact us</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb start-->

  <!-- ================ contact section start ================= -->
  <br />
  <section class="contact-section section_padding">
    <div class="container">
      <div class="d-none d-sm-block mb-5 pb-4">
      
      <div class="row">
        <div class="col-12">
          <h2 class="contact-title" id="rentalStatus" style="text-align: center;">Artwork Locator</h2>
        </div>
      </div>
      	<br />
      	
	<!-- 지도 들어가는 부분 -->  
	<div id="map" align="center" style="height:500px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5cc5a6c45a1a4a26d3d283b459cfd3f9&libraries=clusterer"></script>
        
	<!-- 아래는 직접 코드를 주입해서 마커를 생성하는 법이다 -->
	<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	
	mapOption = { 
	     center: new kakao.maps.LatLng(37.481365, 126.882648), // 지도의 중심좌표(가산디지털단지)
	     level: 8 // 지도의 확대 레벨
	  };
	
	var map = new kakao.maps.Map(mapContainer, mapOption);// 지도를 생성합니다
	
	
	//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();
	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
	
	//위도,경도
	var positions = [
		<c:forEach items="${artLoc}" var="row">
		{
	  	    latlng : new kakao.maps.LatLng(${row.lat}, ${row.lng}),
	  	    artcode : ${row.code},
	  	    title : ${row.title}
	  	  },
		</c:forEach>	
	];

	
	
	//마커 생성
	for (var i = 0; i < positions.length; i++) {
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng // 마커의 위치
	    });
	}
	
	//커스텀 오버레이 생성
	for(var i=0 ; i < positions.length ; i++){
		// 커스텀 오버레이를 생성합니다
		var customOverlay = new kakao.maps.CustomOverlay({
		    map: map,
		    position: positions[i].latlng,
		    content: '<div class="customoverlay">' +
	  	    		' <a href="showroom/art/view.do?code='+positions[i].artcode+'&" target="_blank">' +
	  	    		' <span class="title">'+ positions[i].title +'</span>' +
	  	    		' </a>' +
	  	    		'</div>', 
    		yAnchor: 1 
		});
	}  
	</script>	
		
    </div>


      <div class="row">
        <div class="col-12">
          <h2 class="contact-title">Get in Touch</h2>
        </div>
        <div class="col-lg-8">
          <form class="form-contact contact_form" action="contact_process.php" method="post" id="contactForm"
            novalidate="novalidate">
            <div class="row">
              <div class="col-12">
                <div class="form-group">

                  <textarea class="form-control w-100" name="message" id="message" cols="30" rows="9"
                    onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Message'"
                    placeholder='Enter Message'></textarea>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="form-group">
                  <input class="form-control" name="name" id="name" type="text" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'Enter your name'" placeholder='Enter your name'>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="form-group">
                  <input class="form-control" name="email" id="email" type="email" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'Enter email address'" placeholder='Enter email address'>
                </div>
              </div>
              <div class="col-12">
                <div class="form-group">
                  <input class="form-control" name="subject" id="subject" type="text" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'Enter Subject'" placeholder='Enter Subject'>
                </div>
              </div>
            </div>
            <div class="load_btn">
              <a href="#" class="btn_1">Send Message </a>
            </div>
          </form>
        </div>
        <div class="col-lg-4">
          <div class="media contact-info">
            <span class="contact-info__icon"><i class="ti-home"></i></span>
            <div class="media-body">
              <h3>Buttonwood, California.</h3>
              <p>Rosemead, CA 91770</p>
            </div>
          </div>
          <div class="media contact-info">
            <span class="contact-info__icon"><i class="ti-tablet"></i></span>
            <div class="media-body">
              <h3>00 (440) 9865 562</h3>
              <p>Mon to Fri 9am to 6pm</p>
            </div>
          </div>
          <div class="media contact-info">
            <span class="contact-info__icon"><i class="ti-email"></i></span>
            <div class="media-body">
              <h3>support@colorlib.com</h3>
              <p>Send us your query anytime!</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- ================ contact section end ================= -->

  <!-- social_connect_part part start-->
  <section class="social_connect_part">
      <div class="container-fluid">
          <div class="row">
              <div class="col-xl-12">
                  <div class="social_connect">
                  <div class="single-social_connect">
                      <div class="social_connect_img">
                          <img src="img/insta/instagram_1.png" class="" alt="blog">
                          <div class="social_connect_overlay">
                              <a href="#"><span class="ti-instagram"></span></a> 
                          </div>
                      </div>
                  </div>
                  <div class="single-social_connect">
                      <div class="social_connect_img">
                          <img src="img/insta/instagram_2.png" class="" alt="blog">
                          <div class="social_connect_overlay">
                              <a href="#"><span class="ti-instagram"></span></a> 
                          </div>
                      </div>
                  </div>
                  <div class="single-social_connect">
                      <div class="social_connect_img">
                          <img src="img/insta/instagram_3.png" class="" alt="blog">
                          <div class="social_connect_overlay">
                              <a href="#"><span class="ti-instagram"></span></a> 
                          </div>
                      </div>
                  </div>
                  <div class="single-social_connect">
                      <div class="social_connect_img">
                          <img src="img/insta/instagram_4.png" class="" alt="blog">
                          <div class="social_connect_overlay">
                              <a href="#"><span class="ti-instagram"></span></a> 
                          </div>
                      </div>
                  </div>
                  <div class="single-social_connect">
                      <div class="social_connect_img">
                          <img src="img/insta/instagram_5.png" class="" alt="blog">
                          <div class="social_connect_overlay">
                              <a href="#"><span class="ti-instagram"></span></a> 
                          </div>
                      </div>
                  </div>
                  <div class="single-social_connect">
                      <div class="social_connect_img">
                          <img src="img/insta/instagram_6.png" class="" alt="blog">
                          <div class="social_connect_overlay">
                              <a href="#"><span class="ti-instagram"></span></a> 
                          </div>
                      </div>
                  </div>
              </div>
          </div>
          </div>
      </div>
  </section>
  <!-- social_connect_part part end-->

   <!-- footer part start-->

    <!-- footer part end-->

  <!-- jquery plugins here-->

</body>

</html>
