<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--JSTL -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>








<!-- 
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">


	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>



필터 css 

<link rel="stylesheet" href="https://og-data.s3.amazonaws.com/CACHE/css/e702f4e34fd2.css" type="text/css" />
<link rel="stylesheet" href="../resources/css/ListFilter1.css" />
<link rel="stylesheet" href="../resources/css/ListFilter2.css" />
<link rel="apple-touch-icon-precomposed" href="https://og-data.s3.amazonaws.com/static/common/img/apple-touch-icon.png">
 Stylesheet
        <style>
            
                @font-face {
                   font-family: 'Noto Sans KR';
                   font-style: normal;
                   font-weight: normal;
                   src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff2) format('woff2'),
                        url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff) format('woff'),
                        url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.otf) format('opentype');
                }
                @font-face {
                   font-family: 'Noto Sans KR';
                   font-style: normal;
                   font-weight: bold;
                   src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff2) format('woff2'),
                        url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff) format('woff'),
                        url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.otf) format('opentype');
                }
                body {
                    font-family: 'Noto Sans KR', sans-serif;
                    -webkit-font-smoothing: antialiased;
                    letter-spacing: -0.5px;
                }
                
        </style>
       
<body>
	
<section id="discover_filter" style="margin: 0px;max-width: 1160px;">
            
            <div id="ds-filter-container-pc" class="cf" style="">
                <div class="ds-filter-item" style="background-color:gray; ">
                    <div class="ds-filter-title" style="border: 1px dotted red;">테마</div>
                    <div class="ds-filter-tags cf" style="border: 1px solid red;" >
                        <div class="ds-filter-tag-theme">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-theme-1" name="f_t" data-context="인물"
                                   value="4"/>
                            <label for="ds-filter-theme-1">인물</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-theme-2" name="f_t" data-context="풍경"
                                   value="5"/>
                            <label for="ds-filter-theme-2">풍경</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-theme-3" name="f_t" data-context="정물"
                                   value="6"/>
                            <label for="ds-filter-theme-3">정물</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-theme-4" name="f_t" data-context="동물"
                                   value="7"/>
                            <label for="ds-filter-theme-4">동물</label>
                        </div>
                         
                        <div class="ds-filter-tag-theme" style="border: 1px solid red;">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox" 
                                   id="ds-filter-theme-5" name="f_t" data-context="상상"
                                   value="8"/>
                            <label for="ds-filter-theme-5">상상</label>
                        </div> 
                       
                        
                        <div class="ds-filter-tag-theme" style="border: 1px solid red;display: inline;">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-theme-6" name="f_t"  data-context="추상"
                                   value="19"/>
                            <label for="ds-filter-theme-6">추상</label>
                        </div>
                    </div>
                </div>
                <div class="ds-filter-item ">
                    <div class="ds-filter-title" style="border: 1px solid yellow;">색상</div>
                    <div class="ds-filter-tags cf">
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color red"
                                   id="ds-filter-color-1" name="f_t" data-context="1"
                                   value="53"/>
                            <label for="ds-filter-color-1"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color blue"
                                   id="ds-filter-color-2" name="f_t" data-context="2"
                                   value="54"/>
                            <label for="ds-filter-color-2"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color green"
                                   id="ds-filter-color-3" name="f_t" data-context="3"
                                   value="55"/>
                            <label for="ds-filter-color-3"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color yellow"
                                   id="ds-filter-color-4" name="f_t" data-context="4"
                                   value="56"/>
                            <label for="ds-filter-color-4"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color pastel"
                                   id="ds-filter-color-5" name="f_t" data-context="5"
                                   value="125"/>
                            <label for="ds-filter-color-5"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color b-w"
                                   id="ds-filter-color-6" name="f_t" data-context="6"
                                   value="58"/>
                            <label for="ds-filter-color-6"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color multiple"
                                   id="ds-filter-color-7" name="f_t" data-context="7"
                                   value="59"/>
                            <label for="ds-filter-color-7"></label>
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
                                   id="ds-filter-size-1" name="f_t" data-context="1~5호"
                                   value="28"/>
                            <label for="ds-filter-size-1">1~5호<br/><span>(렌탈불가)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-size-2" name="f_t" data-context="6~10호"
                                   value="29"/>
                            <label for="ds-filter-size-2">6~10호<br/><span>(월 3.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-size-3" name="f_t" data-context="~20호"
                                   value="30"/>
                            <label for="ds-filter-size-3">~20호<br/><span>(월 6.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-size-4" name="f_t" data-context="~30호"
                                   value="31"/>
                            <label for="ds-filter-size-4">~30호<br/><span>(월 9.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-size-5" name="f_t" data-context="~40호"
                                   value="32"/>
                            <label for="ds-filter-size-5">~40호<br/><span>(월 12만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-size-6" name="f_t" data-context="~60호"
                                   value="33"/>
                            <label for="ds-filter-size-6">~60호<br/><span>(월 15만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-size-7" name="f_t" data-context="80호"
                                   value="34"/>
                            <label for="ds-filter-size-7">80호<br/><span>(월 20만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-size-8" name="f_t" data-context="100~120호"
                                   value="35"/>
                            <label for="ds-filter-size-8">100~120호<br/><span>(월 25~30만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-size-9" name="f_t" data-context="150호~"
                                   value="36"/>
                            <label for="ds-filter-size-9">150호~<br/><span>(월 40만원+)</span></label>
                        </div>
                    </div>
                </div>
                <div class="ds-filter-item shape">
                    <div class="ds-filter-title">형태</div>
                    <div class="ds-filter-tags">
                        <div class="ds-filter-tag-shape">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-shape-1" name="f_t" data-context="정사각형"
                                   value="122"/>
                            <label for="ds-filter-shape-1">정사각형</label>
                        </div>
                        <div class="ds-filter-tag-shape">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-shape-2" name="f_t" data-context="가로형"
                                   value="120"/>
                            <label for="ds-filter-shape-2">가로형</label>
                        </div>
                        <div class="ds-filter-tag-shape">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-shape-3" name="f_t" data-context="세로형"
                                   value="121"/>
                            <label for="ds-filter-shape-3">세로형</label>
                        </div>
                        <div class="ds-filter-tag-shape">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-shape-4" name="f_t" data-context="세트"
                                   value="123"/>
                            <label for="ds-filter-shape-4">세트</label>
                        </div>
                    </div>
                </div>
                <div class="ds-filter-item price">
                    <div class="ds-filter-title">구매가격</div>
                    <div class="ds-filter-tags">
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-price-1" name="f_p" data-context="~30만원"
                                   value="1"/>
                            <label for="ds-filter-price-1">~ 30만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-price-2" name="f_p" data-context="30만~50만원"
                                   value="2"/>
                            <label for="ds-filter-price-2">30만 ~ <br/>50만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-price-3" name="f_p" data-context="50만~100만원"
                                   value="3"/>
                            <label for="ds-filter-price-3">50만 ~ <br/>100만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-price-4" name="f_p" data-context="100만~200만원"
                                   value="4"/>
                            <label for="ds-filter-price-4">100만 ~ <br/>200만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-price-5" name="f_p" data-context="200만~300만원"
                                   value="5"/>
                            <label for="ds-filter-price-5">200만 ~ <br/>300만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-price-6" name="f_p" data-context="300만~500만원"
                                   value="6"/>
                            <label for="ds-filter-price-6">300만 ~ <br/>500만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-price-7" name="f_p" data-context="500만~1,000만원"
                                   value="7"/>
                            <label for="ds-filter-price-7">500만 ~ <br/>1,000만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-price-8" name="f_p" data-context="1,000만원 ~"
                                   value="8"/>
                            <label for="ds-filter-price-8">1,000만원 ~</label>
                        </div>
                    </div>
                </div>
            </div>
            <div id="ds-filter-container-mobile" class="cf">
                <div class="ds-filter-header cf">
                    <div class="ds-filter-title active" data-index="1">테마</div>
                    <div class="ds-filter-title" data-index="2">색상</div>
                    <div class="ds-filter-title" data-index="3">사이즈</div>
                    <div class="ds-filter-title" data-index="4">형태</div>
                    <div class="ds-filter-title" data-index="5">구매가격</div>
                </div>
                <div class="ds-filter-content">
                    테마
                    <div class="ds-filter-tags cf active" data-index="1">
                        <div class="ds-filter-tag-theme">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-theme-1" name="f_t" data-context="인물"
                                   value="4"/>
                            <label for="ds-filter-m-theme-1">인물</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-theme-2" name="f_t" data-context="풍경"
                                   value="5"/>
                            <label for="ds-filter-m-theme-2">풍경</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-theme-3" name="f_t" data-context="정물"
                                   value="6"/>
                            <label for="ds-filter-m-theme-3">정물</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-theme-4" name="f_t" data-context="동물"
                                   value="7"/>
                            <label for="ds-filter-m-theme-4">동물</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-theme-5" name="f_t" data-context="상상"
                                   value="8"/>
                            <label for="ds-filter-m-theme-5">상상</label>
                        </div>
                        <div class="ds-filter-tag-theme">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-theme-6" name="f_t"  data-context="추상"
                                   value="19"/>
                            <label for="ds-filter-m-theme-6">추상</label>
                        </div>
                    </div>
                    색상 
                    <div class="ds-filter-tags cf" data-index="2">
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color red"
                                   id="ds-filter-m-color-1" name="f_t" data-context="1"
                                   value="53"/>
                            <label for="ds-filter-m-color-1"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color blue"
                                   id="ds-filter-m-color-2" name="f_t" data-context="2"
                                   value="54"/>
                            <label for="ds-filter-m-color-2"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color green"
                                   id="ds-filter-m-color-3" name="f_t" data-context="3"
                                   value="55"/>
                            <label for="ds-filter-m-color-3"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color yellow"
                                   id="ds-filter-m-color-4" name="f_t" data-context="4"
                                   value="56"/>
                            <label for="ds-filter-m-color-4"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color pastel"
                                   id="ds-filter-m-color-5" name="f_t" data-context="5"
                                   value="125"/>
                            <label for="ds-filter-m-color-5"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color b-w"
                                   id="ds-filter-m-color-6" name="f_t" data-context="6"
                                   value="58"/>
                            <label for="ds-filter-m-color-6"></label>
                        </div>
                        <div class="ds-filter-tag-color">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox dsf-tbc-color multiple"
                                   id="ds-filter-m-color-7" name="f_t" data-context="7"
                                   value="59"/>
                            <label for="ds-filter-m-color-7"></label>
                        </div>
                    </div>
                    사이즈 
                    <div class="ds-filter-tags cf" data-index="3">
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-size-1" name="f_t" data-context="1~5호"
                                   value="28"/>
                            <label for="ds-filter-m-size-1">1~5호<br/><span>(렌탈불가)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-size-2" name="f_t" data-context="6~10호"
                                   value="29"/>
                            <label for="ds-filter-m-size-2">6~10호<br/><span>(월 3.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-size-3" name="f_t" data-context="~20호"
                                   value="30"/>
                            <label for="ds-filter-m-size-3">~20호<br/><span>(월 6.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-size-4" name="f_t" data-context="~30호"
                                   value="31"/>
                            <label for="ds-filter-m-size-4">~30호<br/><span>(월 9.9만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-size-5" name="f_t" data-context="~40호"
                                   value="32"/>
                            <label for="ds-filter-m-size-5">~40호<br/><span>(월 12만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-size-6" name="f_t" data-context="~60호"
                                   value="33"/>
                            <label for="ds-filter-m-size-6">~60호<br/><span>(월 15만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-size-7" name="f_t" data-context="80호"
                                   value="34"/>
                            <label for="ds-filter-m-size-7">80호<br/><span>(월 20만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-size-8" name="f_t" data-context="100~120호"
                                   value="35"/>
                            <label for="ds-filter-m-size-8">100~120호<br/><span>(월 25~30만원)</span></label>
                        </div>
                        <div class="ds-filter-tag-size">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-size-9" name="f_t" data-context="150호~"
                                   value="36"/>
                            <label for="ds-filter-m-size-9">150호~<br/><span>(월 40만원+)</span></label>
                        </div>
                    </div>
                    형태
                    <div class="ds-filter-tags cf" data-index="4">
                        <div class="ds-filter-tag-shape">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-shape-1" name="f_t" data-context="정사각형"
                                   value="122"/>
                            <label for="ds-filter-m-shape-1">정사각형</label>
                        </div>
                        <div class="ds-filter-tag-shape">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-shape-2" name="f_t" data-context="가로형"
                                   value="120"/>
                            <label for="ds-filter-m-shape-2">가로형</label>
                        </div>
                        <div class="ds-filter-tag-shape">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-shape-3" name="f_t" data-context="세로형"
                                   value="121"/>
                            <label for="ds-filter-m-shape-3">세로형</label>
                        </div>
                        <div class="ds-filter-tag-shape">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-shape-4" name="f_t" data-context="세트"
                                   value="123"/>
                            <label for="ds-filter-m-shape-4">세트</label>
                        </div>
                    </div>
                   
					구매가격 
                    <div class="ds-filter-tags cf" data-index="5">
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-price-1" name="f_t" data-context="~30만원"
                                   value="1"/>
                            <label for="ds-filter-m-price-1">~ 30만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-price-2" name="f_t" data-context="30만~50만원"
                                   value="2"/>
                            <label for="ds-filter-m-price-2">30만 ~ <br/>50만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-price-3" name="f_t" data-context="50만~100만원"
                                   value="3"/>
                            <label for="ds-filter-m-price-3">50만 ~ <br/>100만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-price-4" name="f_t" data-context="100만~200만원"
                                   value="4"/>
                            <label for="ds-filter-m-price-4">100만 ~ <br/>200만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-price-5" name="f_t" data-context="200만~300만원"
                                   value="5"/>
                            <label for="ds-filter-m-price-5">200만 ~ <br/>300만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-price-6" name="f_t" data-context="300만~500만원"
                                   value="6"/>
                            <label for="ds-filter-m-price-6">300만 ~ <br/>500만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-price-7" name="f_t" data-context="500만~1,000만원"
                                   value="7"/>
                            <label for="ds-filter-m-price-7">500만 ~ <br/>1,000만원</label>
                        </div>
                        <div class="ds-filter-tag-price">
                            <input type="checkbox" class="ds-filter-tag-bt-checkbox"
                                   id="ds-filter-m-price-8" name="f_t" data-context="1,000만원 ~"
                                   value="8"/>
                            <label for="ds-filter-m-price-8">1,000만원 ~</label>
                        </div>
                    </div>
                </div>
            </div>
            <div id="ds-selected-filter">
                <div id="ds-selected-filter-list">
                    <div class="ds-selected-filter-left"></div>
                </div>
                <div class="ds-selected-filter-right">
                    <div id="filter-reset-btn">전체삭제</div>
                </div>
            </div>
        </section>
        <script>
        	$(function(){
	        	
        		//필터>사이즈 + 버튼 클릭 이벤트
	        	$("div.ds-filter-fold-btn").click(function(){
	        		console.log("사이즈 플러스 클릭됨");
	        		if($(".size").attr("class") == "ds-filter-item size unfold"){
		        		$(".size").attr("class", "ds-filter-item size");
	        		}else{
		        		$(".size").attr("class", "ds-filter-item size unfold");
	        		}
	        	});      
        		
        		
        		$(".ds-filter-title").click(function(){
        			if($(this).attr("class")=="ds-filter-title"){
        				$(".ds-filter-title").attr("class", "ds-filter-title");     
        				$(this).attr("class", "ds-filter-title active");
        				let dataIndex = $(this).attr("data-index");
        				console.log(dataIndex);
        				$(".ds-filter-tags").not("[data-index="+dataIndex+"]").attr("class", "ds-filter-tags cf active");
        				//$("[data-index="+dataIndex+"]").attr("class", "ds-filter-tags cf active");
        			}else{
        				$(this).attr("class", "ds-filter-title");      
        				//$("[data-index="+dataIndex+"]").attr("class", "ds-filter-tags cf");
        			}
        		});
        	});
        </script>
	
</body>
</html>


 -->












