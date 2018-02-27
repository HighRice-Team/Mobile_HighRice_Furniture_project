package com.bit_fr.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStreamWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.vo.MemberVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class R_projectController {

	@Autowired
	private MemberDao member_dao;

	public void setDao(MemberDao dao) {
		this.member_dao = dao;
	}

	@RequestMapping("/chart.do")
	public ModelAndView chart(HttpServletRequest request) {
		String path = request.getRealPath("WEB-INF/views");
		ModelAndView view = new ModelAndView("template");
		RConnection connection = null;
		try {
			connection = new RConnection();
			connection.eval("library(devtools)");
			connection.eval("library(RCurl)");
			connection.eval("library(d3Network)");
			connection.eval(
					"name <- c('한글','Jessica +num1 +','Winona Ryder','Michelle Pfeiffer','Whoopi Goldberg','Emma Thompson','Julia Roberts','Sharon Stone','Meryl Streep', 'Susan Sarandon','Nicole Kidman')");
			connection.eval(
					"pemp <- c('한글','한글','Jessica Lange','Winona Ryder','Winona Ryder','Angela Bassett','Emma Thompson', 'Julia Roberts','Angela Bassett', 'Meryl Streep','Susan Sarandon')");
			connection.eval("emp <- data.frame(이름=name,상사이름=pemp)");
			connection.eval("d3SimpleNetwork(emp,width=600,height=600,file='~/Desktop/Study/Study_Note/test01.jsp')");
			connection.eval("aa <- '한글'");
			System.out.println(connection.eval("aa").asString());
			connection.close();
			/*
			 * 기존 소스는 생성된 .jsp 에서 한글이 깨짐.
			 */
			// FileInputStream fis = new
			// FileInputStream("/Users/jinsoo_mac/Desktop/Study/Study_Note/test01.jsp");
			// FileOutputStream fos = new FileOutputStream(path+"/test01.jsp");
			//
			// FileCopyUtils.copy(fis, fos);
			/*
			 * 생성한 .jsp 가 한글이 깨져 한글을 처리함.
			 */
			BufferedReader reader = new BufferedReader(
					new FileReader("/Users/jinsoo_mac/Desktop/Study/Study_Note/test01.jsp"));
			BufferedWriter writer = new BufferedWriter(
					new OutputStreamWriter(new FileOutputStream(path + "/test01.jsp"), "UTF-8"));
			String s;
			String str = "<%@ page contentType=\"text/html;charset=UTF-8\"%>";
			writer.write(str);
			while ((s = reader.readLine()) != null) {
				writer.write(s);
				writer.newLine();
			}
			FileCopyUtils.copy(reader, writer);
			view.addObject("viewPage", "Rtest/test01.jsp");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		return view;
	}

	@RequestMapping("/getAgeForChart.do")
	public ModelAndView getAgeForChart(HttpServletRequest request) {

		String path = request.getRealPath("resources/chart_img");
		ModelAndView view = new ModelAndView("template");
		RConnection connection = null;

		List<String> list = member_dao.getAllJumin_member();

		List<String> male = new ArrayList<String>();
		List<String> femaile = new ArrayList<String>();
		List<String> gen10 = new ArrayList<String>();
		List<String> gen20 = new ArrayList<String>();
		List<String> gen30 = new ArrayList<String>();
		List<String> gen40 = new ArrayList<String>();
		List<String> overGen50 = new ArrayList<String>();

		for (String temp : list) {
			Calendar date = Calendar.getInstance();
			int year, month, day, age, sex, local;
			sex = 0;

			/**
			 * 910000-'1'234561 생년월일, 성별, 나이 출력하기 1 : 1900년대 내국인 남자, 2: 1900년대 내국인 여자 3 :
			 * 2000년대 내국인 남자, 4: 2000년대 내국인 여자 5 : 1900년대 외국인 남자, 6: 1900년대 외국인 여자 7 :
			 * 2000년대 외국인 남자, 8: 2000년대 외국인 여자 9 : 1800년대 내국인 남자, 0: 1800년대 내국인 여자 생년월일 값을
			 * 받고 Calendar 클래스 사용해서 현재나이 구함.
			 */
			char gender = temp.charAt(7);
			year = Integer.parseInt(temp.substring(0, 2));
			month = Integer.parseInt(temp.substring(2, 4));
			day = Integer.parseInt(temp.substring(4, 6));

			// 7번째 숫자로 성별, 년도, 내/외국인 확인
			switch (gender) {
			case '1':
				year += 1900;
				sex = 0;
				local = 1;
				break;
			case '2':
				year += 1900;
				sex = 1;
				local = 1;
				break;
			case '3':
				year += 2000;
				sex = 0;
				local = 1;
				break;
			case '4':
				year += 2000;
				sex = 1;
				local = 1;
				break;
			case '5':
				year += 1900;
				sex = 0;
				local = 0;
				break;
			case '6':
				year += 1900;
				sex = 1;
				local = 0;
				break;
			case '7':
				year += 2000;
				sex = 0;
				local = 0;
				break;
			case '8':
				year += 2000;
				sex = 1;
				local = 0;
				break;
			case '9':
				year += 1800;
				sex = 0;
				local = 1;
				break;
			case '0':
				year += 1800;
				sex = 1;
				local = 1;
				break;
			}
			age = (date.get(Calendar.YEAR)) - year + 1;

			char sexchk = (sex != 1 ? '남' : '여');

			if (sexchk == '남') {
				male.add(temp);
			} else {
				femaile.add(temp);
			}

			switch (Integer.parseInt((age + "").substring(0, 1))) {
			case 1:
				gen10.add(temp);
				break;
			case 2:
				gen20.add(temp);
				break;
			case 3:
				gen30.add(temp);
				break;
			case 4:
				gen40.add(temp);
				break;
			default:
				overGen50.add(temp);
				break;
			}
		}

		// R project 차트 생성식
		try {
			System.out.println(path);

			connection = new RConnection();

			connection.eval("jpeg(filename='" + path + "/genderRate.jpg')");
			connection.eval("p1 = c(" + male.size() + "," + femaile.size() + ")");
			connection.eval("pie(p1,label=c('남자','여자'),main='연령별 비율')");
			connection.eval("dev.off()");

			connection.eval("jpeg(filename='" + path + "/ageRate.jpg')");
			connection.eval("p2 = c(" + gen10.size() + "," + gen20.size() + "," + gen30.size() + "," + gen40.size()
					+ "," + overGen50.size() + ")");
			connection.eval("pie(p2,label=c('10대','20대','30대','40대','50대 이상'),main='세대 비율')");
			connection.eval("dev.off()");

			connection.close();

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		view.addObject("genderRate", "genderRate.jpg");
		view.addObject("ageRate", "ageRate.jpg");
		view.addObject("viewPage", "Rtest/age_genderRate.jsp");

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
	
	
	@RequestMapping(value = "/getAgeForChart.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String getAgeForChart() {
		
		return "";
	}
	
}
