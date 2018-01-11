package com.bit_fr.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.ProductDao;
import com.bit_fr.vo.ProductVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class ProductController {

	@Autowired
	private ProductDao dao;

	public void setDao(ProductDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping("/index.do")
	public ModelAndView main(@RequestParam(defaultValue = "1") int pageNum, String category, String quality,
			@RequestParam(defaultValue = "0") int min, @RequestParam(defaultValue = "0") int max) {
		ModelAndView mav = new ModelAndView("main");
		int productMax = 16;
		int endNum = pageNum * productMax;
		int startNum = endNum - (productMax - 1);

		String sql = "select * from (select rownum rnum, product_id,condition, product_name, category, quality, price, main_img, sub_img, member_id from (select product_id,condition, product_name, category, quality, price, main_img, sub_img, member_id from product where condition='물품게시'";

		if (category != null && category.equals("")) {
			category = null;
		}

		if (quality != null && quality.equals("")) {
			quality = null;
		}

		if (min != 0) {
			sql += " and price>=" + min;
		}
		if (max != 0) {
			sql += " and price<=" + max;
		}
		if (category != null) {
			sql += " and category='" + category + "'";
		}
		if (quality != null) {
			sql += " and quality='" + quality + "'";
		}

		sql += " order by product_id desc))";

		List<ProductVo> list = dao.getCust(sql);
		mav.addObject("len", list.size());

		int pageMax = list.size() / productMax;
		if (list.size() % productMax != 0)
			pageMax++;

		sql += "where rnum>=" + startNum + " and rnum<=" + endNum;

		list = dao.getCust(sql);

		mav.addObject("list", list);
		mav.addObject("category", category);
		mav.addObject("min", min);
		mav.addObject("max", max);
		mav.addObject("quality", quality);
		mav.addObject("pageMax", pageMax);
		mav.addObject("viewPage", "index.jsp");

		return mav;
	}
	
	@RequestMapping(value="delete_product.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String delete_product(int product_id){
		System.out.println(product_id);
		String str = "";
		
		int re = dao.delete_product(product_id);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		
		return str;
	}
	
	
}
