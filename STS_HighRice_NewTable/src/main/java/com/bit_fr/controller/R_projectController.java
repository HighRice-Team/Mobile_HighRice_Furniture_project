package com.bit_fr.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStreamWriter;

import javax.servlet.http.HttpServletRequest;

import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;

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
}
