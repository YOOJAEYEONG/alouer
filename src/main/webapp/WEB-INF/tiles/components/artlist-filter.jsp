<%@page import="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<section class="all_post section_padding">
   <div class="container">
      <div class="row">

         <div id="hiddenAdaptedFilter" hidden>
            <input id="theme_Flt" value="${theme_Flt }" h-idden="hidden"
               type="text" />테마 <input id="color_Flt" value="${color_Flt }"
               h-idden="hidden" type="text" />컬러 <input id="price_Flt"
               value="${price_Flt }" h-idden="hidden" type="text" />가격 <input
               id="shape_Flt" value="${shape_Flt }" h-idden="hidden" type="text" />형태
            <input id="size_Flt" value="${size_Flt }" h-idden="hidden"
               type="text" />크기
         </div>

         <div id="discover_filter">                        
            
               <form:form id="filterFrm_pc"
                  action="${requestScope['javax.servlet.forward.request_uri']}">            
               
               <!--테이블에서 선택한 값이 채워진다  -->
               <input id="selectedValue" name="selectedVal" type="text" hidden
                  value="" placeholder="선택한값이채워짐" />

               <div id="ds-filter-container-pc" class="cf row">
                  <div class="ds-filter-item">
                     <div class="ds-filter-title">테마</div>
                     <div class="ds-filter-tags">
                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-theme-1" name="fltTheme" data-context="인물"
                              value="인물" /> <label for="ds-filter-theme-1">인물</label>
                        </div>

                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-theme-2" name="fltTheme" data-context="풍경"
                              value="풍경" /> <label for="ds-filter-theme-2">풍경</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-theme-3" name="fltTheme" data-context="정물"
                              value="정물" /> <label for="ds-filter-theme-3">정물</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-theme-4" name="fltTheme" data-context="동물"
                              value="동물" /> <label for="ds-filter-theme-4">동물</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-theme-5" name="fltTheme" data-context="상상"
                              value="상상" /> <label for="ds-filter-theme-5">상상</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-theme-6" name="fltTheme" data-context="추상"
                              value="추상" /> <label for="ds-filter-theme-6">추상</label>
                        </div>
                     </div>
                  </div>
                  <div class="ds-filter-item">
                     <div class="ds-filter-title">색상</div>
                     <div class="ds-filter-tags cf">
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color red"
                              id="ds-filter-color-1" name="fltColor" data-context="1"
                              value="빨강" /> <label for="ds-filter-color-1"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color blue"
                              id="ds-filter-color-2" name="fltColor" data-context="2"
                              value="파랑" /> <label for="ds-filter-color-2"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color green"
                              id="ds-filter-color-3" name="fltColor" data-context="3"
                              value="초록" /> <label for="ds-filter-color-3"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color yellow"
                              id="ds-filter-color-4" name="fltColor" data-context="4"
                              value="노랑" /> <label for="ds-filter-color-4"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color pastel"
                              id="ds-filter-color-5" name="fltColor" data-context="5"
                              value="파스텔" /> <label for="ds-filter-color-5"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color b-w"
                              id="ds-filter-color-6" name="fltColor" data-context="6"
                              value="흑백" /> <label for="ds-filter-color-6"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color multiple"
                              id="ds-filter-color-7" name="fltColor" data-context="7"
                              value="기타" /> <label for="ds-filter-color-7"></label>
                        </div>
                     </div>
                  </div>
                  <div class="ds-filter-item size ">
                     <div class="ds-filter-title">
                        사이즈
                        <div class="ds-filter-fold-btn"></div>
                     </div>
                     <div class="ds-filter-tags">
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-size-1" name="fltSize" data-context="1~5호"
                              value="5호" /> <label for="ds-filter-size-1">1~5호<br />
                              <span>(렌탈불가)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-size-2" name="fltSize" data-context="6~10호"
                              value="10호" /> <label for="ds-filter-size-2">6~10호<br />
                              <span>(월 3.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-size-3" name="fltSize" data-context="~20호"
                              value="20호" /> <label for="ds-filter-size-3">~20호<br />
                              <span>(월 6.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-size-4" name="fltSize" data-context="~30호"
                              value="30호" /> <label for="ds-filter-size-4">~30호<br />
                              <span>(월 9.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-size-5" name="fltSize" data-context="~40호"
                              value="40호" /> <label for="ds-filter-size-5">~40호<br />
                              <span>(월 12만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-size-6" name="fltSize" data-context="~60호"
                              value="60호" /> <label for="ds-filter-size-6">~60호<br />
                              <span>(월 15만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-size-7" name="fltSize" data-context="80호"
                              value="80호" /> <label for="ds-filter-size-7">80호<br />
                              <span>(월 20만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-size-8" name="fltSize" data-context="100~120호"
                              value="120호" /> <label for="ds-filter-size-8">100~120호<br />
                              <span>(월 25~30만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-size-9" name="fltSize" data-context="150호~"
                              value="150호" /> <label for="ds-filter-size-9">150호~<br />
                              <span>(월 40만원+)</span></label>
                        </div>
                     </div>
                  </div>
                  <div class="ds-filter-item shape">
                     <div class="ds-filter-title">형태</div>
                     <div class="ds-filter-tags">
                        <div class="ds-filter-tag-shape">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-shape-1" name="fltShape" data-context="정사각형"
                              value="정사각형" /> <label for="ds-filter-shape-1">정사각형</label>
                        </div>
                        <div class="ds-filter-tag-shape">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-shape-2" name="fltShape" data-context="가로형"
                              value="가로형" /> <label for="ds-filter-shape-2">가로형</label>
                        </div>
                        <div class="ds-filter-tag-shape">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-shape-3" name="fltShape" data-context="세로형"
                              value="세로형" /> <label for="ds-filter-shape-3">세로형</label>
                        </div>
                     </div>
                  </div>
                  <div class="ds-filter-item price">
                     <div class="ds-filter-title">구매가격</div>
                     <div class="ds-filter-tags">
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-price-1" name="fltPrice" data-context="~30만원"
                              value=" 0 AND 30000 " /> <label for="ds-filter-price-1">~
                              3만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-price-2" name="fltPrice" data-context="30만~50만원"
                              value=" 30000 AND 50000 " /> <label for="ds-filter-price-2">3만
                              ~ 5만원 </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-price-3" name="fltPrice"
                              data-context="50만~100만원" value=" 50000 AND 100000 " /> <label
                              for="ds-filter-price-3">5만 ~ 10만원 </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-price-4" name="fltPrice"
                              data-context="100만~200만원" value=" 100000 AND 200000 " /> <label
                              for="ds-filter-price-4">10만 ~ 20만원 </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-price-5" name="fltPrice"
                              data-context="200만~300만원" value=" 200000 AND 300000 " /> <label
                              for="ds-filter-price-5">20만 ~ 30만원 </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-price-6" name="fltPrice"
                              value=" 300000 AND 500000 " /> <label for="ds-filter-price-6">30만
                              ~ 50만원 </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-price-7" name="fltPrice"
                              value=" 500000 AND 1000000 " /> <label
                              for="ds-filter-price-7">50만 ~ 100만원 </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-price-8" name="fltPrice"
                              data-context="1,000만원 ~" value=" >= 1000000 " /> <label
                              for="ds-filter-price-8">100만원 ~</label>
                        </div>
                     </div>
                  </div>
               </div>
            </form:form>

            <form:form id="filterFrm_mobile"
               action="${pageContext.request.contextPath }/showroom/art">

               <div id="ds-filter-container-mobile" class="row">
                  <div class="ds-filter-header cf">
                     <div class="ds-filter-title" data-index="1">테마</div>
                     <div class="ds-filter-title" data-index="2">색상</div>
                     <div class="ds-filter-title " data-index="3">사이즈</div>
                     <div class="ds-filter-title" data-index="4">형태</div>
                     <div class="ds-filter-title" data-index="5">구매가격</div>
                  </div>
                  <div class="ds-filter-content">
                     <div class="ds-filter-tags cf active" data-index="1">
                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-theme-1" name="fltTheme" data-context="인물"
                              value="인물" /> <label for="ds-filter-m-theme-1">인물</label>

                        </div>
                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-theme-2" name="fltTheme" data-context="풍경"
                              value="풍경" /> <label for="ds-filter-m-theme-2">풍경</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-theme-3" name="fltTheme" data-context="정물"
                              value="정물" /> <label for="ds-filter-m-theme-3">정물</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-theme-4" name="fltTheme" data-context="동물"
                              value="동물" /> <label for="ds-filter-m-theme-4">동물</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-theme-5" name="fltTheme" data-context="상상"
                              value="상상" /> <label for="ds-filter-m-theme-5">상상</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-theme-6" name="fltTheme" data-context="추상"
                              value="추상" /> <label for="ds-filter-m-theme-6">추상</label>
                        </div>
                     </div>
                     <div class="ds-filter-tags cf" data-index="2">
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color red"
                              id="ds-filter-m-color-1" name="fltColor" data-context="1"
                              value="빨강" /> <label for="ds-filter-m-color-1"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color blue"
                              id="ds-filter-m-color-2" name="fltColor" data-context="2"
                              value="파랑" /> <label for="ds-filter-m-color-2"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color green"
                              id="ds-filter-m-color-3" name="fltColor" data-context="3"
                              value="초록" /> <label for="ds-filter-m-color-3"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color yellow"
                              id="ds-filter-m-color-4" name="fltColor" data-context="4"
                              value="노랑" /> <label for="ds-filter-m-color-4"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color pastel"
                              id="ds-filter-m-color-5" name="fltColor" data-context="5"
                              value="파스텔" /> <label for="ds-filter-m-color-5"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color b-w"
                              id="ds-filter-m-color-6" name="fltColor" data-context="6"
                              value="흑백" /> <label for="ds-filter-m-color-6"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                           <input type="checkbox"
                              class="ds-filter-tag-bt-checkbox dsf-tbc-color multiple"
                              id="ds-filter-m-color-7" name="fltColor" data-context="7"
                              value="기타" /> <label for="ds-filter-m-color-7"></label>
                        </div>
                     </div>
                     <div class="ds-filter-tags cf" data-index="3">
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-size-1" name="fltSize" data-context="1~5호"
                              value="5호" /> <label for="ds-filter-m-size-1">1~5호<br />
                              <span>(렌탈불가)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-size-2" name="fltSize" data-context="6~10호"
                              value="10호" /> <label for="ds-filter-m-size-2">6~10호<br />
                              <span>(월 3.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-size-3" name="fltSize" data-context="~20호"
                              value="20호" /> <label for="ds-filter-m-size-3">~20호<br />
                              <span>(월 6.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-size-4" name="fltSize" data-context="~30호"
                              value="30호" /> <label for="ds-filter-m-size-4">~30호<br />
                              <span>(월 9.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-size-5" name="fltSize" data-context="~40호"
                              value="40호" /> <label for="ds-filter-m-size-5">~40호<br />
                              <span>(월 12만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-size-6" name="fltSize" data-context="~60호"
                              value="60호" /> <label for="ds-filter-m-size-6">~60호<br />
                              <span>(월 15만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-size-7" name="fltSize" data-context="80호"
                              value="80호" /> <label for="ds-filter-m-size-7">80호<br />
                              <span>(월 20만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-size-8" name="fltSize"
                              data-context="100~120호" value="120호" /> <label
                              for="ds-filter-m-size-8">100~120호<br /> <span>(월
                                 25~30만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-size-9" name="fltSize" data-context="150호~"
                              value="150호" /> <label for="ds-filter-m-size-9">150호~<br />
                              <span>(월 40만원+)</span></label>
                        </div>
                     </div>
                     <div class="ds-filter-tags cf" data-index="4">
                        <div class="ds-filter-tag-shape">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-shape-1" name="fltShape" data-context="정사각형"
                              value="정사각형" /> <label for="ds-filter-m-shape-1">정사각형</label>
                        </div>
                        <div class="ds-filter-tag-shape">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-shape-2" name="fltShape" data-context="가로형"
                              value="가로형" /> <label for="ds-filter-m-shape-2">가로형</label>
                        </div>
                        <div class="ds-filter-tag-shape">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-shape-3" name="fltShape" data-context="세로형"
                              value="세로형" /> <label for="ds-filter-m-shape-3">세로형</label>
                        </div>
                     </div>
                     <div class="ds-filter-tags cf" data-index="5">
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-price-1" name="fltPrice"
                              value=" 0 AND 30000 " /> <label for="ds-filter-m-price-1">~
                              3만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-price-2" name="fltPrice"
                              value=" 30000 AND 50000 " /> <label for="ds-filter-m-price-2">3만
                              ~ <br />5만원
                           </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-price-3" name="fltPrice"
                              value=" 50000 AND 100000 " /> <label
                              for="ds-filter-m-price-3">5만 ~ <br />10만원
                           </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-price-4" name="fltPrice"
                              value=" 100000 AND 200000 " /> <label
                              for="ds-filter-m-price-4">10만 ~ <br />20만원
                           </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-price-5" name="fltPrice"
                              value=" 200000 AND 300000 " /> <label
                              for="ds-filter-m-price-5">20만 ~ <br />30만원
                           </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-price-6" name="fltPrice"
                              value=" 300000 AND 500000 " /> <label
                              for="ds-filter-m-price-6">30만 ~ <br />50만원
                           </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-price-7" name="fltPrice"
                              value=" 500000 AND 1000000 " /> <label
                              for="ds-filter-m-price-7">50만 ~ <br />100만원
                           </label>
                        </div>
                        <div class="ds-filter-tag-price">
                           <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                              id="ds-filter-m-price-8" name="fltPrice" value=" >= 1000000 " />
                           <label for="ds-filter-m-price-8">100만원 ~</label>
                        </div>
                     </div>
                  </div>
               </div>
            </form:form>
            <div id="ds-selected-filter">
               <div id="ds-selected-filter-list">
                  <div class="ds-selected-filter-left">
                     <!--필터에서 체크한 엘리먼트들이 이 안에 추가된다  document.querySelector("#ds-selected-filter-list > div > div:nth-child(1)")-->
                  </div>
               </div>
               <div class="ds-selected-filter-right">
                  <form:form name="fltDeleteFrm"
                     action="${requestScope['javax.servlet.forward.request_uri']}">
                     <input name="fltDelete" value="reset" type="text" hidden="hidden" />
                  </form:form>
                  <div id="filter-reset-btn">전체삭제</div>
               </div>
            </div>
         </div>

         <!-- 필터 보임/숨김 버튼 -->         
         <div id="filterToggleBox"
            style="text-align: center; background-color: black;">
            <!-- 아이콘 -->
            <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
            <button id="filter_collapse_btn" type="button"
               class="btn btn-sm opened">
               <i class="material-icons" style="color: white;"></i>
            </button>
         </div>


         <section id="discover_contents">
            <div id="ds-header-holder">
               <div id="ds-header-inner" class="cf">
                  <span id="ds-filter-count-pc"> <span
                     class="ds-filter-count-num">${totalRecordCount }</span>점의 작품 검색됨
                  </span>
                     <form:form id="orderByFrm"
                        action="${requestScope['javax.servlet.forward.request_uri']}">
                        <input id="quickChk" name="quickChk" type="text"
                           placeholder="서버에 보낼값" hidden />
                     </form:form>
                  
                  <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'showroom')}">
                     <div id="ds-filter-status">
                        <div>
                           <input type="checkbox" class="ds-filter-status-bt-checkbox"
                              id="ds-filter-auction" name="fltShowAuction"
                              value="fltShowAuction"
                              <c:if test="${fltStatus eq '지분경매'}"> checked="checked"</c:if> />
                           <label for="ds-filter-auction">지분경매가능</label>
                        </div>
                        <div>
                           <input type="checkbox" class="ds-filter-status-bt-checkbox"
                              id="ds-filter-rental" name="fltRental" value="fltRental"
                              <c:if test="${fltStatus eq '렌탈가능'}"> checked="checked"</c:if> />
                           <label for="ds-filter-rental">렌탈가능</label>
                        </div>
                        <div>
                           <input type="checkbox" class="ds-filter-status-bt-checkbox"
                              id="ds-filter-purchase" name="fltOrderByPrice"
                              value="fltOrderByPrice"
                              <c:if test="${not empty fltOrderByPrice }"> checked="checked"</c:if> />
                           <label for="ds-filter-purchase">낮은가격순</label>
                        </div>
                     </div>
                  </c:if>
               </div>
            </div>
         </section>
         <!-- ///////////////////////////////////// -->


      </div>
      <!-- row end -->
   </div>
   <!-- container end -->
</section>