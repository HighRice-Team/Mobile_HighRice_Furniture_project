package com.bit_fr.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class R_projectController {

	@Autowired
	private MemberDao member_dao;

	public void setDao(MemberDao dao) {
		this.member_dao = dao;
	}

	// R chart 그리기 메소드
	// 유입 검색키워드 빈도수 R차트 생성
	public String makeChart_searchKeywordFrequency(HttpServletRequest request) {
		String img_name = "";
		String json_name = "";
		String out_filename = "searchKeyword.png";

		String img_path = request.getRealPath("resources/chart_img");
		String json_path = request.getRealPath("resources/inflow_log");

		RConnection connection = null;

		try {

			connection = new RConnection();

			img_name = img_path + "/" + out_filename;
			json_name = json_path + "/inflowLog.json";

			connection.eval("library(jsonlite)");
			connection.eval("library(KoNLP)");
			connection.eval("library(wordcloud)");

			connection.eval("json <- fromJSON('" + json_name + "')");
			connection.eval("keyword <- json$keyword");
			connection.eval("keyword1 <- sapply(keyword, extractNoun, USE.NAMES=F)");
			connection.eval("keyword2 <- unlist(keyword1)");
			connection.eval("keyword3 <- Filter(function(x){nchar(x) >= 2}, keyword2)");
			connection.eval("write(unlist(keyword3),\"temp_key.txt\")");
			connection.eval("keyword4 <- read.table(\"temp_key.txt\")");
			connection.eval("wordcount <- table(keyword4)");

			connection.eval("library(RColorBrewer)");
			connection.eval("palete <- brewer.pal(12,\"Set3\")");
			connection.eval("png(filename='" + img_name + "')");
			connection.eval(
					"wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq=1,random.order=F,random.color=T,colors=palete)");
			connection.eval(
					"legend(0.1,1,\"bit 가구대여점 인기 검색키워드\",cex=0.8,fill=NA,border=NA,bg=\"white\",text.col=\"red\",text.font=3,box.col=\"red\")");

			connection.eval("dev.off()");

			connection.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return out_filename;
	}

	// 유입매체 portal R차트 생성
	public String makeChart_inflowPortalRoute(HttpServletRequest request) {
		String img_name = "";
		String json_name = "";
		String out_filename = "inflowPortalRoute.jpg";

		String img_path = request.getRealPath("resources/chart_img");
		String json_path = request.getRealPath("resources/inflow_log");

		RConnection connection = null;

		try {

			connection = new RConnection();

			img_name = img_path + "/" + out_filename;
			json_name = json_path + "/inflowLog.json";

			connection.eval("jpeg(filename='" + img_name + "')");
			connection.eval("library(jsonlite)");
			connection.eval("data = fromJSON('" + json_name + "')");
			connection.eval("naver=0");
			connection.eval("google=0");
			connection.eval("daum=0");
			connection.eval("nate=0");
			connection.eval(
					"for(i in 1:nrow(data)){   if(data[i,1]=='naver'){   naver = naver +1}else if(data[i,1]=='daum'){daum = daum +1}else if(data[i,1]=='nate'){nate= nate+1}else if(data[i,1]=='google'){google= google+1}}");
			connection.eval("engine = c(naver,daum,google,nate)");
			connection.eval("barplot(engine,col=rainbow(4),main='검색매체별 유입량',xlab='검색매체',ylim=c(0,max(engine)+5))");
			connection.eval("axis(1,at=1:4,c('naver','daum','google','nate'))");
			connection.eval(
					"legend(4,max(engine)+5,c('naver','daum','google','nate'),cex=0.9,col=c('red','green','skyblue','purple'),lty=1,lwd=10)");
			connection.eval("dev.off()");

			connection.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return out_filename;
	}
	
	// 유입매체 device R차트 생성
	public String makeChart_inflowDeviceRoute(HttpServletRequest request) {
		String img_name = "";
		String json_name = "";
		String out_filename = "inflowDeviceRoute.jpg";
		
		String img_path = request.getRealPath("resources/chart_img");
		String json_path = request.getRealPath("resources/inflow_log");
		
		RConnection connection = null;
		
		try {
			
			connection = new RConnection();
			
			img_name = img_path + "/" + out_filename;
			json_name = json_path + "/inflowLog.json";
			
			connection.eval("jpeg(filename='" + img_name + "')");
			connection.eval("library(jsonlite)");
			connection.eval("data = fromJSON('" + json_name + "')");
			connection.eval("iphone=0");
			connection.eval("android=0");
			connection.eval("mac=0");
			connection.eval("windows=0");
			connection.eval(
					"for(i in 1:nrow(data)){   if(data[i,3]=='[PC]맥'){   mac = mac +1}else if(data[i,3]=='[PC]윈도우'){windows = windows +1}else if(data[i,3]=='[Mobile]안드로이드'){android= android+1}else if(data[i,3]=='[Mobile]아이폰'){iphone= iphone+1}}");
			connection.eval("engine = c(mac,windows,android,iphone)");
			connection.eval("barplot(engine,col=c('green','red','yellow','skyblue'),main='검색매체 디바이스별 유입량',xlab='디바이스',ylim=c(0,max(engine)+5))");
			connection.eval("axis(1,at=1:4,c('mac','windows','android','iphone'))");
			connection.eval(
					"legend(4,max(engine)+5,c('mac','windows','android','iphone'),cex=0.9,col=c('green','red','yellow','skyblue'),lty=1,lwd=10)");
			connection.eval("dev.off()");
			
			connection.close();
			
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return out_filename;
	}

	// 회원 연령비 차트 생성
	public String makeChart_generationRate(HttpServletRequest request) {

		List<String> list = member_dao.getAllJumin_member();

		int gen10 = 0, gen20 = 0, gen30 = 0, gen40 = 0, overGen50 = 0;
		Date date = new Date();
		int year = date.getYear() + 1900;

		for (String temp : list) {
			int gen = (year - Integer.parseInt(temp.substring(0, 4))) / 10;

			switch (gen) {
			case 1:
				gen10 += 1;
				break;
			case 2:
				gen20 += 1;
				break;
			case 3:
				gen30 += 1;
				break;
			case 4:
				gen40 += 1;
				break;
			default:
				overGen50 += 1;
				break;
			}

		}

		Double dd = (double) gen20 / list.size();
		NumberFormat nf = NumberFormat.getPercentInstance();
		String img_name = "";
		String out_filename = "generationRate.jpg";

		String img_path = request.getRealPath("resources/chart_img");
		img_name = img_path + "/" + out_filename;

		// R로 실행할 명령어
		String tempStr = "jpeg(filename='" + img_name + "') \n pie(c(" + gen10 + "," + gen20 + "," + gen20 + "," + gen20
				+ "," + overGen50 + "),lab=c('10대\\n(" + nf.format((double) gen10 / list.size()) + ")','20대\\n("
				+ nf.format((double) gen20 / list.size()) + ")','30대\\n(" + nf.format((double) gen30 / list.size())
				+ ")','40대\\n(" + nf.format((double) gen40 / list.size()) + ")','50대 이상\\n("
				+ nf.format((double) overGen50 / list.size()) + ")'),main='BIT FR 회원 연령비') \n dev.off()";

		RConnection connection = null;

		try {

			connection = new RConnection();

			connection.eval(tempStr);

			connection.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return out_filename;
	}

	// 회원 성비비 차트 생성
	public String makeChart_genderRate(HttpServletRequest request) {

		List<String> list = member_dao.getAllJumin_member();
		int male = 0, femaile = 0;

		for (String temp : list) {
			if (temp.charAt(8) == '1') {
				male += 1;
			} else if (temp.charAt(8) == '2') {
				femaile += 1;
			}
		}

		String img_path = request.getRealPath("resources/chart_img");
		String img_name = "";
		String out_filename = "genderRate.jpg";
		img_name = img_path + "/" + out_filename;

		// R로 실행할 명령어
		String tempStr = "jpeg('" + img_name + "') \n barplot(c(" + male + "," + femaile
				+ "),col=c(\"skyblue\",\"pink\"),main=\"BIT FR 회원 성비\",names=c(\"남자\",\"여자\"))\n" + " \n dev.off()";

		RConnection connection = null;

		try {

			connection = new RConnection();
			connection.eval(tempStr);
			connection.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return out_filename;
	}

	// R 차트 내보내기
	@RequestMapping(value = "statistics_Rchart.do")
	public ModelAndView StatisticsPage(HttpServletRequest request) {

		ModelAndView view = new ModelAndView("template");

		view.addObject("inflowPortalRoute", makeChart_inflowPortalRoute(request));
		view.addObject("inflowDeviceRoute", makeChart_inflowDeviceRoute(request));
		view.addObject("searchKeyword", makeChart_searchKeywordFrequency(request));
		view.addObject("generationRate", makeChart_generationRate(request));
		view.addObject("genderRate", makeChart_genderRate(request));
		view.addObject("viewPage", "rchart/statisticsPage.jsp");

		return view;
	}

	// 크롤링 메소드
	public int getAveragePrice_FromWebsite(String keyword, String website) {
		int total = 0;
		String encoding_keyword = "";
		int AveragePrice = 0;

		if (website == "action") {
			try {

				// [옥션 가구 중고거래 사이트 ] 판매목록의 최근 60건에 대한 가격.
				encoding_keyword = URLEncoder.encode(keyword, "EUC-KR");
				String URL_Category = "http://corners.auction.co.kr/corner/UsedMarketList.aspx?keyword="
						+ encoding_keyword + "&arraycategory=27000000";

				Document doc_Category = Jsoup.connect(URL_Category).get();
				Elements elem_Category = doc_Category.select("div.list_view");

				for (Element i : elem_Category) {
					String str_Category = i.select("div.market_info > div.present > span.now > strong").text();
					str_Category = str_Category.replaceAll(",", "");
					total += Integer.parseInt(str_Category);
				}

				// 평균 중고거래가격
				// 0 에대한 예외처리하기.
				if (elem_Category.size() != 0) {
					AveragePrice = total / elem_Category.size();
				}

			} catch (Exception e) {
				System.out.println(e);
			}
		} //

		return AveragePrice;
	}

	// 오늘의 중고거래 시세 가져오기.
	@RequestMapping(value = "/getAveragePrice_FromWebsite_AJAX.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String member_age(HttpServletRequest request) {
		String str = "";

		int BED_AveragePrice = 0;
		int SOFA_AveragePrice = 0;
		int CLOSET_AveragePrice = 0;
		int DESK_AveragePrice = 0;

		String keyword_BED = "침대";
		String keyword_SOFA = "소파";
		String keyword_CLOSET = "옷장";
		String keyword_DESK = "책상";

		try {

			// [침대] 중고 판매목록 평균 중고 가격
			BED_AveragePrice = getAveragePrice_FromWebsite(keyword_BED, "action");
			// [소파] 중고 판매목록 평균 중고 가격
			SOFA_AveragePrice = getAveragePrice_FromWebsite(keyword_SOFA, "action");
			// [옷장] 중고 판매목록 평균 중고 가격
			CLOSET_AveragePrice = getAveragePrice_FromWebsite(keyword_CLOSET, "action");
			// [책상] 중고 판매목록 평균 중고 가격
			DESK_AveragePrice = getAveragePrice_FromWebsite(keyword_DESK, "action");

		} catch (Exception e) {
			System.out.println(e);
		}
		HashMap map = new HashMap();

		if (BED_AveragePrice != 0) {
			map.put("BED_AveragePrice", BED_AveragePrice);
		} else {
			map.put("BED_AveragePrice", "-");
		}

		if (SOFA_AveragePrice != 0) {
			map.put("SOFA_AveragePrice", SOFA_AveragePrice);
		} else {
			map.put("SOFA_AveragePrice", "-");
		}

		if (CLOSET_AveragePrice != 0) {
			map.put("CLOSET_AveragePrice", CLOSET_AveragePrice);
		} else {
			map.put("CLOSET_AveragePrice", "-");
		}

		if (DESK_AveragePrice != 0) {
			map.put("DESK_AveragePrice", DESK_AveragePrice);
		} else {
			map.put("DESK_AveragePrice", "-");
		}

		ObjectMapper mapper = new ObjectMapper();

		try {
			str = mapper.writeValueAsString(map);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	// 사용자의 유입경로 저장하기.
	@RequestMapping(value = "/upload_inflowLog.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String upload_inflowLog(HttpServletRequest request, String device, String portal, String keyword) {
		String path = request.getRealPath("resources/inflow_log");

		String str_JSON = "";
		String file_name = path + "/inflowLog.json";

		HashMap map = new HashMap();

		map.put("device", device);
		map.put("portal", portal);
		map.put("keyword", keyword);

		ObjectMapper mapper = new ObjectMapper();

		try {
			str_JSON = mapper.writeValueAsString(map);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		System.out.println(path);

		try {
			BufferedReader reader = null;
			BufferedWriter writer = null;

			try {
				reader = new BufferedReader(new FileReader(file_name));
			} catch (Exception e) {
				File file = new File(file_name);
				FileOutputStream fos = new FileOutputStream(file);

				String temp = "[]";
				fos.write(temp.getBytes());
				fos.flush();
				fos.close();
			}
			String old_str = "";
			File file = new File(file_name);
			if (file.exists()) {
				reader = new BufferedReader(new FileReader(file));
				while (reader.ready()) {
					old_str += reader.readLine();
				}
			}

			int findChar = old_str.lastIndexOf("]");
			StringBuffer sb = new StringBuffer(old_str);

			if (old_str.lastIndexOf("}") != -1) {
				str_JSON = sb.insert(findChar, ("," + str_JSON)).toString();
			} else {
				str_JSON = sb.insert(findChar, str_JSON).toString();

			}

			FileOutputStream fos = new FileOutputStream(file);
			fos.write(str_JSON.getBytes());
			fos.flush();
			fos.close();

		} catch (Exception e) {
			System.out.println("에러 : " + e);
		}

		return str_JSON;
	}

}
