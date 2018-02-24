package com.bit_fr.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.vo.MemberVo;

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
	
	@RequestMapping("/member_age.do")
	public ModelAndView member_age(HttpServletRequest request) {
		String path = request.getRealPath("WEB-INF/views/Rtest");
		ModelAndView view = new ModelAndView("template");
		
//		RConnection connection = null;
//		try {
//			connection = new RConnection();
//			connection.eval("library(devtools)");
//			connection.eval("library(RCurl)");
//			connection.eval("library(d3Network)");
//			connection.eval(
//					"name <- c('한글','Jessica +num1 +','Winona Ryder','Michelle Pfeiffer','Whoopi Goldberg','Emma Thompson','Julia Roberts','Sharon Stone','Meryl Streep', 'Susan Sarandon','Nicole Kidman')");
//			connection.eval(
//					"pemp <- c('한글','한글','Jessica Lange','Winona Ryder','Winona Ryder','Angela Bassett','Emma Thompson', 'Julia Roberts','Angela Bassett', 'Meryl Streep','Susan Sarandon')");
//			connection.eval("emp <- data.frame(이름=name,상사이름=pemp)");
//			connection.eval("d3SimpleNetwork(emp,width=600,height=600,file='~/Desktop/Study/Study_Note/test01.jsp')");
//			connection.eval("aa <- '한글'");
//			System.out.println(connection.eval("aa").asString());
//			connection.close();
//			/*
//			 * 기존 소스는 생성된 .jsp 에서 한글이 깨짐.
//			 */
//			// FileInputStream fis = new
//			// FileInputStream("/Users/jinsoo_mac/Desktop/Study/Study_Note/test01.jsp");
//			// FileOutputStream fos = new FileOutputStream(path+"/test01.jsp");
//			//
//			// FileCopyUtils.copy(fis, fos);
//			/*
//			 * 생성한 .jsp 가 한글이 깨져 한글을 처리함.
//			 */
//			BufferedReader reader = new BufferedReader(
//					new FileReader("/Users/jinsoo_mac/Desktop/Study/Study_Note/test01.jsp"));
//			BufferedWriter writer = new BufferedWriter(
//					new OutputStreamWriter(new FileOutputStream(path + "/test01.jsp"), "UTF-8"));
//			String s;
//			String str = "<%@ page contentType=\"text/html;charset=UTF-8\"%>";
//			writer.write(str);
//			while ((s = reader.readLine()) != null) {
//				writer.write(s);
//				writer.newLine();
//			}
//			FileCopyUtils.copy(reader, writer);
//			view.addObject("viewPage", "Rtest/test01.jsp");
//		} catch (Exception e) {
//			// TODO: handle exception
//			System.out.println(e);
//		}
		return view;
	}
	
	
	@RequestMapping(value = "/getAgeForChart.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String getAgeForChart() {
		
		List<String> list = member_dao.getAllJumin_member();
		
		List<String> male = new ArrayList<String>(); 
		List<String> femaile = new ArrayList<String>();
		List<String> gen10 = new ArrayList<String>();
		List<String> gen20 = new ArrayList<String>();
		List<String> gen30 = new ArrayList<String>();
		List<String> gen40 = new ArrayList<String>();
		List<String> overGen50 = new ArrayList<String>();

		for(String temp : list) {
			Calendar date = Calendar.getInstance();
		    int year, month, day, age, sex, local;
		    sex = 0;

		    /**
		     * 910000-'1'234561 생년월일, 성별, 나이 출력하기 1 : 1900년대 내국인 남자, 2: 1900년대 내국인 여자 3
		     * : 2000년대 내국인 남자, 4: 2000년대 내국인 여자 5 : 1900년대 외국인 남자, 6: 1900년대 외국인 여자 7 :
		     * 2000년대 외국인 남자, 8: 2000년대 외국인 여자 9 : 1800년대 내국인 남자, 0: 1800년대 내국인 여자 생년월일
		     * 값을 받고 Calendar 클래스 사용해서 현재나이 구함.
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


			if(sexchk=='남') {
				male.add(temp);
			}else {
				femaile.add(temp);
			}
			
			switch(Integer.parseInt((age+"").substring(0, 1))) {
				case 1:gen10.add(temp); break;
				case 2:gen20.add(temp); break;
				case 3:gen30.add(temp); break;
				case 4:gen40.add(temp); break;
				default :overGen50.add(temp); break;
			}
		}
		
//		R project 차트 생성식
		
	/*	
	    connection.eval("jpeg(filename='genderRate.jpg')");
	    connection.eval("p1 = c(male.size(),femaile.size())");
	    connection.eval("pie(p1,label=c('남자','여자'),main='연령별 비율')");
	    connection.eval("dev.off()");	 
	*/
		
	/*	
	 	connection.eval("jpeg(filename='ageRate.jpg')");
	 	connection.eval("p2 = c(gen10.size(),gen10.size(),gen10.size(),gen10.size(),overGen50.size())");
	 	connection.eval("pie(p2,label=c('10대','20대','30대','40대','50대 이상'),main='세대 비율')");
	 	connection.eval("dev.off()");
		 
	*/
		
		return "10대: "+gen10.size()+"\n20대: "+gen20.size()+"\n30대: "+gen30.size()+"\n40대: "+gen40.size()+"\n50대: "+overGen50.size()+"\n남자: "+male.size()+"명\n여자: "+femaile.size()+"명";
	}
	
}
