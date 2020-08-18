package com.official.alouer;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.logging.Level;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gargoylesoftware.htmlunit.WebClient;
import com.gargoylesoftware.htmlunit.html.DomElement;
import com.gargoylesoftware.htmlunit.html.DomNode;
import com.gargoylesoftware.htmlunit.html.DomNodeList;
import com.gargoylesoftware.htmlunit.html.HtmlElement;
import com.gargoylesoftware.htmlunit.html.HtmlPage;

import mybatis.ArtsDTO;
import mybatis.ArtsImpl;
import mybatis.MemberImpl;
import mybatis.MemberVO;
import mybatis.MybatisDAOImpl;
import util.crawlUtil;

@Controller
public class CrawlerController {

	@Autowired
	private SqlSession sqlSession;

	ArtsDTO artsDTO = new ArtsDTO();
	MemberVO memberVO = new MemberVO();	

	public void crawl() {		

		WebClient webClient = new WebClient();
		java.util.logging.Logger.getLogger("com.gargoylesoftware").setLevel(Level.OFF);//중간로그 off
		java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);
		webClient.getOptions().setThrowExceptionOnScriptError(false);
		webClient.getOptions().setJavaScriptEnabled(true);
		webClient.getOptions().setCssEnabled(false);
		webClient.getOptions().setThrowExceptionOnFailingStatusCode(false);

		int num = 0;
		int end = 9999;
		boolean flag = false;

		HtmlPage page;
		try {

			while(num!=end) {

				System.out.println("현재페이지 : " + num);
				System.out.println("끝페이지 : " + end);
				String url = "https://www.opengallery.co.kr/discover/?p="+ num +"&f_ts=&f_ps=&f_ra=false&f_pa=true&r_ex=0&";

				page = webClient.getPage(url);

				List<DomElement> aTag = page.getElementsByTagName("a");


				for (DomElement e : aTag) {				

					if(e.getAttribute("class").equals("discoverCard-a")) {
						String dpageUrl = "https://www.opengallery.co.kr" + e.getAttribute("href").toString();

						System.out.println("페이지 URL: " + dpageUrl);

						HtmlPage dpage = webClient.getPage(dpageUrl);

						List<DomElement> imgTag = dpage.getElementsByTagName("img");
						for (DomElement de : imgTag) {
							if(de.getAttribute("class").equals("artworkDetail-imageViewer-img")) {
								String imgURL = de.getAttribute("src").toString();

								System.out.println("이미지주소 : " + imgURL);
							}
						}				
					}else if((e.getAttribute("class").equals("paginator-btn pb-end")) && flag==false) {
						System.out.println("===========================================");
						System.out.println("페이지번호  :"+e.getTextContent());
						end = Integer.parseInt(e.getTextContent());
						flag = true;
					}
				}
				num++;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	
	
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	@RequestMapping("/admin/crawler/crawl.do")
	public void crawl(int startNum, int endNum) {

		WebClient webClient = new WebClient();
		java.util.logging.Logger.getLogger("com.gargoylesoftware").setLevel(Level.OFF);//중간로그 off
		java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);
		webClient.getOptions().setThrowExceptionOnScriptError(false);
		webClient.getOptions().setJavaScriptEnabled(true);
		webClient.getOptions().setCssEnabled(false);
		webClient.getOptions().setThrowExceptionOnFailingStatusCode(false);
		webClient.getOptions().setUseInsecureSSL(true); //ignore ssl certificate
		webClient.getOptions().setThrowExceptionOnScriptError(false);
		webClient.getOptions().setThrowExceptionOnFailingStatusCode(false);

		int num = startNum;
		int end = endNum+1;

		//rentalprice, theme, color, material 안들어감
		//material은 xpath로?

		HtmlPage page;

		//theme/color 작업은 여기에 넣어야 합니다.
		HashSet<String> artistSet = new HashSet<String>();
		HashSet<String> artSet = new HashSet<String>();

		Map<String, String> colorMap = new HashMap<String, String>();
		Map<String, String> themeMap = new HashMap<String, String>();

		String[] colorKey = {"빨강", "파랑", "초록", "노랑", "파스텔", "흑백", "기타"};
		String[] colorVal = {"53","54","55","56","125","58", "59"};
		String[] themeKey = {"인물", "풍경", "정물", "동물", "상상", "추상"};
		String[] themeVal = {"4","5","6","7","8","19"};

		for(int i = 0; i<colorKey.length ; i++) {
			colorMap.put(colorKey[i], colorVal[i]);
		}
		for(int i = 0; i<themeKey.length ; i++) {
			themeMap.put(themeKey[i], themeVal[i]);
		}

		for(Entry<String, String> theme : themeMap.entrySet()) {
			for(Entry<String, String> color : colorMap.entrySet()) {
				num = startNum;						
				while(num!=end) {

					try {
						System.out.println("현재페이지 : " + num);
						System.out.println("끝페이지 : " + end);
						System.out.println(theme.getKey());
						System.out.println(color.getKey());
						String url = "https://www.opengallery.co.kr/discover/?p="+ num +"&f_ts="+ theme.getValue() +"-"+color.getValue()+ "&f_ps=&f_ra=false&f_pa=true&r_ex=0&";
						page = webClient.getPage(url);

						List<DomElement> aTag = page.getElementsByTagName("a");

						int dPageCnt = 0;
						for (DomElement e : aTag) {	
							//상세페이지내부 loop
							if(e.getAttribute("class").equals("discoverCard-a")) {

								System.out.println("=========================\r\n\r\n\r\n\r\n\r\n");
								System.out.println(num + "페이지" + ++dPageCnt + "번째 작품\r\n\r\n\r\n\r\n\r\n");
								System.out.println("=========================");

								String dpageUrl = "https://www.opengallery.co.kr" + e.getAttribute("href").toString();
								System.out.println("페이지 URL: " + dpageUrl);


								artsDTO.setPageUrl(dpageUrl);
								//테마/컬러
								artsDTO.setTheme(theme.getKey());
								artsDTO.setColor(color.getKey());

								System.out.println("테마:"+theme);
								System.out.println("색상:"+color);

								String memberId = dpageUrl.substring(dpageUrl.indexOf('A'), dpageUrl.indexOf('-'));

								System.out.println("작가id:" + memberId);
								//작가 아이디/비번 설정
								memberVO.setMemberId(memberId);
								artsDTO.setMemberId(memberId);
								memberVO.setPass("1111");


								HtmlPage dpage = webClient.getPage(dpageUrl);
								List<DomElement> imgTag = dpage.getElementsByTagName("img");
								for (DomElement de : imgTag) {
									if(de.getAttribute("class").equals("artworkDetail-imageViewer-img")) {
										//DTO.set
										String imageUrl = de.getAttribute("src").toString();
										if(!imageUrl.contains("sub")) {
											artsDTO.setImageUrl(imageUrl);
											System.out.println("이미지주소 : " + imageUrl);

										}
									}				
								}

								List<DomElement> aDpageTag = dpage.getElementsByTagName("a");
								for (DomElement de : aDpageTag) {
									if(de.getAttribute("class").equals("artworkDetail-artistLink")) {
										//DTO.set DB작업시 작가테이블에 먼저 넣고 작품테이블에 넣어야함(cause FK)
										String name = de.getTextContent().trim();
										artsDTO.setName(name);
										memberVO.setName(name);
										System.out.println("작가명 : " + name);
									}				
								}


								List<DomElement> divTag = dpage.getElementsByTagName("div");
								List<String> recommand = new ArrayList<String>();
								int notecnt=1;
								for (DomElement de : divTag) {
									if(de.getAttribute("class").equals("artist-education-set")) {								
										List<HtmlElement> spanTag = de.getElementsByTagName("span");

										int ecnt = 1;
										String edu = "";
										for(HtmlElement d : spanTag) {
											//DTO.set
											edu += d.getTextContent().trim();
										}									

										memberVO.setEdu(edu);
										System.out.println("학력 : " + edu );
									}else if(de.getAttribute("class").equals("artworkDetail-note_recommend")) {
										if(notecnt==1) {
											String note1 = new crawlUtil().byteCut(de.getTextContent());
											artsDTO.setNote1(note1);
											System.out.println(note1);
											notecnt++;
										}else {
											String note2 = new crawlUtil().byteCut(de.getTextContent());
											artsDTO.setNote2(note2);
											System.out.println(note2);
										}
									}
								}

								List<DomElement> h2Tag = dpage.getElementsByTagName("h2");
								for (DomElement de : h2Tag) {
									if(de.getAttribute("class").equals("artworkDetail-title")) {								
										String title = de.getTextContent();
										title = title.trim();
										artsDTO.setTitle(title);
										System.out.println("제목 : "+title);
									}
								}

								List<DomElement> pTag = dpage.getElementsByTagName("p");

								int pcnt = 0;

								for (DomElement de : pTag) {

									if(de.getAttribute("class").equals("artworkDetail-infoTable-details-p")) {								
										pcnt++;

										DomNodeList<DomNode> deNode = de.getChildNodes();
										Iterator<DomNode> itr = deNode.iterator();
										int cnt = 0;


										if(pcnt==1) {

											while(itr.hasNext()) {
												String txt = itr.next().getTextContent();
												System.out.println("소재부분 전체 :" +txt);

												if(cnt==0) {
													String material = txt;
													System.out.println("소재 : " + material);//소재 안뜸
													artsDTO.setMaterial(material);
													cnt++;
												}else if(txt.contains("cm") && txt.contains("x")) {
													String size = txt.trim().replace(",","");
													size = size.replace("(", "");
													size = size.replace(")", "");
													size = size.replace("cm", "");
													size = size.replace("호", "");
													size = size.replace("변형 ", "");


													String[] sizeArr = size.split(" ");

													char[] hoArr = sizeArr[1].toCharArray();
													String sizeHo = "";
													for(char s : hoArr) {
														if(s>=48 && s<=57) {
															sizeHo += s;
														}
													}

													//														sizeArr[1] = sizeArr[1].replace("호", "");

													String[] sizeCm = sizeArr[0].split("x");

													artsDTO.setSizeHo(Integer.parseInt(sizeHo));
													artsDTO.setHeight(Integer.parseInt(sizeCm[0]));
													artsDTO.setWidth(Integer.parseInt(sizeCm[1]));
													artsDTO.setProdYear(Integer.parseInt(sizeArr[2]));												

													System.out.println("세로 : " + sizeCm[0]);
													System.out.println("가로 : " + sizeCm[1]);
													System.out.println("사이즈(호) : " + sizeArr[1]);
													System.out.println("연도 : " + sizeArr[2]);

												}else if(txt.contains("작품코드")) {
													String[] code = txt.trim().split(":");
													artsDTO.setCode(code[1]);
													System.out.println("작품코드 : " + code[1]);

												}

											}
										}///pcnt1 end
										else if(pcnt==2) {

											while(itr.hasNext()) {
												String txt = itr.next().getTextContent();
												System.out.println("소재부분 전체 :" +txt);

												if(txt.contains("렌탈요금")) {
													String rentalPrice = itr.next().getNextSibling().getTextContent().replace("원", "");
													rentalPrice = rentalPrice.replace(",", "").trim();														
													artsDTO.setRentalPrice(Integer.parseInt(rentalPrice));
													System.out.println("렌탈요금 :" + rentalPrice);
												}else if(txt.contains("구매가격:")) {
													String artValue = itr.next().getNextSibling().getTextContent().replace("원", "");
													artValue = artValue.replace(",", "").trim();
													artsDTO.setArtValue(Integer.parseInt(artValue));
													System.out.println("구매가격 :" +artValue);
												}
											}
										}///pcnt==3 end
									}///p tag if문 end
								}/// p tag for문 end



								String historyUrl = "https://www.opengallery.co.kr/artist/" + memberVO.getMemberId() + "/#cv";
								System.out.println(historyUrl);

								HtmlPage historyPage;

								historyPage = webClient.getPage(historyUrl);


								List<DomElement> hisElem = historyPage.getElementsByTagName("div");
								int cnt = 1;
								for (DomElement elem : hisElem) {
									if(elem.getAttribute("class").equals("adb-subsection-inner")) {
										if(cnt==1) {
											String history = elem.asText();
											history = history.replace("  ", "");
											history = new crawlUtil().byteCut(history);
											memberVO.setHistory(history);
											cnt++;
										}
									}
								}		

								if(sqlSession==null) {
									System.out.println("sqlSession_null");
								}
								
								int memExist = sqlSession.getMapper(MemberImpl.class).memExist(memberVO);
								
								if(memExist==0) {
									System.out.println("MemberImpl 바로 전:" + memberVO.getMemberId());
									sqlSession.getMapper(MemberImpl.class).register(memberVO);
								}
								
								int artExist = sqlSession.getMapper(ArtsImpl.class).artExist(artsDTO);
								
								if(artExist==0) {
									System.out.println("ArtsImpl 바로 전:" + artsDTO.getCode());
									sqlSession.getMapper(ArtsImpl.class).artregister(artsDTO);
								}

							}//상세페이지1개 끝

						}//1페이지 끝	


					}catch (Exception e) {
						e.printStackTrace();
					}	
					num++;//페이지 1 증가
				}//while문 끝
			}//color for문끝
		}//theme for문 끝

		return;
	}	

}
