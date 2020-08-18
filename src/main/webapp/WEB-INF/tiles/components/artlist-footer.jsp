<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script lang="JavaScript">
   
   

   //300000 => 300,000
   function numberWithCommas(x) {
       return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
   }

   //쿠키 저장 함수: cookie 명, cookie 값, 기간을 파라미터로 받는다.
   var setCookie = function(name, value, day) {
          var date = new Date();
          date.setTime(date.getTime() + day * 60 * 60 * 24 * 1000);//1일동안 저장
          document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
   };

   //쿠키를 조회: 조회할쿠키명
   var getCookie = function(name) {
       var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
         return value? value[2] : null;
   };
   //쿠키삭제 : 삭제할 쿠키명
   var deleteCookie = function(name) {
        var date = new Date();
        document.cookie = name + "= " + "; expires=" + date.toUTCString() + "; path=/";
    }

$(function() {
	//상태에따라 다른색을 부여
	$(".discoverCard-tagBox span").each(function(index,item){
		var select = $(item).parent().parent().parent().children("figcaption.statusPlag");
		switch($(item).text()){
			case '렌탈중':
				$(item).parent().css("color","#ff8989");//레드
				$(select).css("backgroundColor","#ff8989");
				break;
			case '렌탈가능': 
				$(item).parent().css("color","#4f9bff");//블루
				$(select).css("backgroundColor","#4f9bff");
				break;
			case '렌탈준비중':
				$(item).parent().css("color","gray");
				$(select).css("backgroundColor","gray");
				break;
			case '지분경매':
				$(item).parent().css("color","#d866ff");//보라
				$(select).css("backgroundColor","#d866ff");
				break;
			case '경매준비중':
				$(item).parent().css("color","gray");//초록
				$(select).css("backgroundColor","gray");
				break;
			case '준비중':
				$(item).parent().css("color","#bcb600");//노랑
				$(select).css("backgroundColor","#bcb600");
				break;
		}
		
	});
	   
	   
	 //페이지가 로딩된후 각 게시물마다 상세페이지 링크를 설정해줌
      console.log("location.pathname:",window.location.pathname);
      $(".cardPath").each(function(index,item){
         let path = $(this).attr("href");//=>/view.do?code=A0847-0001&nowPage=
            $(this).attr("href",window.location.pathname+path);
         console.log($(this).attr("href"));//=>/alouer/showroom/art/view.do?code=A0847-0001&nowPage=
      });

    //현재 페이지 버튼 active속성부여
  	$("li.page-link").css({"color":"#274FC2","fontWeight":"bolder", "background-color":"#e9ecef"});
		
      
      //렌탈가능/낮은가격순 폼값 서밋
      $("#ds-filter-status").change(function(e){
         console.log("e.target.name:",e.target.name)//fltStatus
         console.log("e.target.checked:",e.target.checked)//true or false
         $("#quickChk").val(e.target.name+(""+e.target.checked))//fltStatustrue => 컨트롤러로 전송
         $("#orderByFrm").submit();
      });
      //경매 페이지로 들어왔을경우 경매만 보기 에 자동 체크/해제 필요 + 히든
      
      
   
      //필터에서 사이즈+ 눌렀을경우 가려진 메뉴 표시해줌
      $(".ds-filter-fold-btn").click(function(){
         var attr = $("div.ds-filter-item.size").attr("class");
         console.log("속성:",attr);
         if(attr == "ds-filter-item size" ){
            $("div.ds-filter-item.size").attr("class","ds-filter-item size unfold");
         }else{
            $("div.ds-filter-item.size").attr("class","ds-filter-item size");
         }
      });
      
      //필터에서 전체 삭제 버튼을 누르는 경우
      $("#filter-reset-btn").click(function() {
         $("#ds-selected-filter").css({"display":"none"});
         document.fltDeleteFrm.submit();
      });
   
      
      //필터 전체 보임/숨김
      $("#filter_collapse_btn").on("click",function(e){
         let btnClass = $("#filter_collapse_btn").attr("class");
         console.log("btnClass:",btnClass);
         //열려있으면
         if(btnClass.indexOf("opened") != -1){
            console.log("닫기");
            $("#discover_filter").slideUp(200);
            $("#filterToggleLine").slideDown(200);
            setCookie("filterBtnOnOff","closed", 1);
            $("#filter_collapse_btn").attr("class","btn btn-sm closed");
         }else{
            console.log("열기");
            $("#discover_filter").slideDown(200);
            $("#filterToggleLine").slideUp(200);
            //필터를 열고 닫는 정보는 쿠키로 저장해놓고 그 값을 지속 적용한다
            setCookie("filterBtnOnOff","opened", 1);
            $("#filter_collapse_btn").attr("class","btn btn-sm opened");
         }
         
         console.log("저장된 쿠키값:",getCookie("filterBtnOnOff"));
      });
      
      console.log("저장했던 쿠키값:",getCookie("filterBtnOnOff"));
      //저장된 쿠키값을 조회하여 필터 on/off여부에 따라 적용한다
      if(getCookie("filterBtnOnOff")=="opened"){
         $("#discover_filter").slideDown(0);
         $("#filterToggleLine").slideUp(0);
         $("#filter_collapse_btn").attr("class","btn btn-sm opened");
      }else if(getCookie("filterBtnOnOff")=="closed"){
         console.log("전에 필터를닫아놓았으므로 자동적용함");
         $("#discover_filter").slideUp(0);
         $("#filterToggleLine").slideDown(0);
         $("#filter_collapse_btn").attr("class","btn btn-sm closed");
      }
      
      //console.log("테마체크박스들", $("#filterFrm_pc [name='fltTheme']"));
      //console.log("filterFrm_pc폼 하위의 input들", $("#filterFrm_pc input"));
      //pc용 폼 하위의 테마체크박스들을 선택함
      $("[name='fltTheme']").each(
         function(index, item) {
            /*
            item은 인물, 풍경,등 체크박스 요소이다 
            서버에서 받은 테마선택값들 중에 value 속성값과 일치하는것이 있으면
            그 item 요소에 checked 속성 부여 한다.
             */
            let theme_Flt = $("#theme_Flt").val();
            //console.log("item.value:", item.value);
            //console.log("theme_Flt:",theme_Flt);
            if( theme_Flt.indexOf(item.value) != -1 ) {
               $(item).attr("checked", "checked");
            }
            
         }
      );
      
      $("[name='fltColor']").each(
         function(index, item) {    
            let color_Flt = $("#color_Flt").val();
            //console.log("item.value:", item.value);
            //console.log("color_Flt:",color_Flt);
            if( color_Flt.indexOf(item.value) != -1 ) {
               $(item).attr("checked", "checked");
            }
         }
      );
      $("[name='fltSize']").each(
         function(index, item) {    
            let size_Flt = $("#size_Flt").val();
            //console.log("item.value:", item.value);
            //console.log("size_Flt:",color_Flt);
            if( size_Flt.indexOf(item.value) != -1 ) {
               $(item).attr("checked", "checked");
            }
         }
      );
      $("[name='fltShape']").each(
         function(index, item) {    
            let shape_Flt = $("#shape_Flt").val();
            //console.log("item.value:", item.value);
            //console.log("shape_Flt:",shape_Flt);
            if( shape_Flt.indexOf(item.value) != -1 ) {
               $(item).attr("checked", "checked");
            }
         }
      );
      $("[name='fltPrice']").each(
         function(index, item) {    
            let price_Flt = $("#price_Flt").val();
            //console.log("item.value:", item.value);
            //console.log("price_Flt:",price_Flt);
            if( price_Flt.indexOf(item.value) != -1 ) {
               $(item).attr("checked", "checked");
            }
         }
      );
      
      /*
      선택중인 필터들은 하단에 따로 나열한다
      나열된 버튼을 클릭하면 해당 필터는 사라지게 된다
      */
      let selectingArr = new Array();
      $("#ds-filter-container-mobile :checked, #ds-filter-container-pc :checked").each(
         function(index, item){
            //console.log(">>item:", item);//checked상태인 label의 텍스트 출력됨
            let selectId = $(item).attr("for");
            //console.log(">>item.text:", $(item).val());
            let itemVal = $(item).val();
            switch(itemVal) {
            case " 0 AND 30000 ": 
               itemVal = "~3만원";      break;
            case " 30000 AND 50000 ": 
               itemVal = "3~5만원";   break;
            case " 50000 AND 100000 ": 
               itemVal = "5~10만원";   break;
            case " 100000 AND 200000 ": 
               itemVal = "10~20만원";   break;
            case " 200000 AND 300000 ": 
               itemVal = "20~30만원";   break;
            case " 300000 AND 500000 ": 
               itemVal = "30~50만원";   break;
            case " 500000 AND 1000000 ": 
               itemVal = "50~100만원";   break;
            case " >= 1000000 ":    
               itemVal = "100만원~";   break;
            }
            let value = $(item).attr("value");
            let name = $(item).attr("name");
            //console.log("item attr value:",value);
            //console.log("item attr name:",name);
            
           console.log("이미추가된값:",$(".ds-selected-filter-left").text().trim());
           console.log("value:",value);
    
            
            //필터를 클릭하면 하단에 선택된필터 버튼 생성
            let divStr = "<div class='ds-sf-item ds-selected-filter-item' name="+name+" value='"+value+"' >"+itemVal+"</div>";
            let appendedFlt = $(".ds-selected-filter-left").text().trim();
            
            //모바일필터와 pc화면용 필터 선택시 중복 추가를 방지
            if( !appendedFlt.includes(value) && !appendedFlt.includes(itemVal) ){
               $(".ds-selected-filter-left").append(divStr);               
            }
            
            //console.log("배열에 넣을인덱스:"+index);
            selectingArr[index] = item;
            //console.log(index+"번째배열:"+selectingArr[index].value);
            //생성된 버튼에 클릭이벤트 리스너:클릭하면 해당 필터가 사라짐   
            for(let i=0;i<selectingArr.length;i++){
               $("#ds-selected-filter-list > div > div:nth-child("+(i+1)+")").on("click",function(){
                  $(selectingArr[i]).trigger("click");
               });
            }
         }
      );
      
      
      //하나라도 선택된 필터가 있을때 하단필터바를 보임/숨김
      let selectedFilter = $("#ds-filter-container-mobile :checked, #ds-filter-container-pc :checked").length;
      if(selectedFilter>0){
         
         $("#ds-selected-filter").css({"display":"block"});
      }else{
         $("#ds-selected-filter").css({"display":"none"});
      }
   
      
      //모바일 페이지용 필터, pc용 페이지용 필터에서 선택하면 이벤트를 가져온다.
      $("#ds-filter-container-mobile, #ds-filter-container-pc").on("change",
         function(e) {
            console.log("클릭한체크박스>" + e.target.name);//fltTheme
            console.log("클릭한체크박스의 값>" + e.target.value);//인물
            let chkBox = e.target.name;
            let chkedValue = e.target.value;
            $("#selectedValue").val(chkedValue);
            $("#filterFrm_pc").submit();
            
         }
      );

      //모바일 페이지에서 테마,필터,사이즈 등을 선택할때 해당 필터들을 보여줌
      $(".ds-filter-header").click(function(e){
         console.log("dataindex:",e.target);
         let dataIdx = $(e.target).attr("data-index");
         $(e.target).attr("class","ds-filter-title active");
         $(".ds-filter-tags[data-index="+dataIdx+"]").attr("class","ds-filter-tags cf active")
         $(".ds-filter-title").not(e.target).attr("class","ds-filter-title");
         $(".ds-filter-tags").not("[data-index="+dataIdx+"]").attr("class","ds-filter-tags cf")
      });
   });
   
</script>