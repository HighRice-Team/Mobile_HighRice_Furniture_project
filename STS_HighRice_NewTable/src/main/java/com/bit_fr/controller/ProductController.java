package com.bit_fr.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
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

	@RequestMapping("/customize.do")
	public ModelAndView gotoCustomize(@RequestParam(defaultValue = "1") int pageNum, String category, String quality,
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
		mav.addObject("viewPage", "customize.jsp");

		return mav;
	}

	@RequestMapping("/index.do")
	public ModelAndView main(@RequestParam(defaultValue = "1") int pageNum, String category, String quality,
			@RequestParam(defaultValue = "0") int min, @RequestParam(defaultValue = "0") int max) {
		ModelAndView mav = new ModelAndView("main");
		int productMax = 8;
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

		ArrayList<String> price_with = new ArrayList<String>();

		for (int i = 0; i < list.size(); i++) {
			DecimalFormat comma = new DecimalFormat("#,###");
			int price = list.get(i).getPrice();
			price_with.add(comma.format(price) + "");
		}

		mav.addObject("list", list);
		mav.addObject("category", category);
		mav.addObject("min", min);
		mav.addObject("max", max);
		mav.addObject("quality", quality);
		mav.addObject("pageMax", pageMax);
		mav.addObject("price_with", price_with);
		mav.addObject("viewPage", "index_mainView.jsp");

		return mav;
	}

	@RequestMapping(value = "delete_product.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String delete_product(int product_id) {
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

	@RequestMapping("/product.do")
	@ResponseBody
	public ModelAndView getAll_product(@RequestParam(defaultValue = "") String sort, String category,
			@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "0") int min,
			@RequestParam(defaultValue = "0") int max) {
		ModelAndView view = new ModelAndView();
		int productMax = 16;
		int endNum = pageNum * productMax;
		int startNum = endNum - (productMax - 1);

		view.setViewName("main");

		String sql = "select * from (select rownum rnum, product_id,condition, product_name, category, quality, price, main_img, sub_img, member_id from (select product_id,condition, product_name, category, quality, price, main_img, sub_img, member_id from product where condition='물품게시'";

		if (category != null && category.equals("")) {
			category = null;
		}
		if (sort != null && sort.equals("")) {
			sort = null;
		}
		if (sort != null && sort.equals("price_min")) {
			sort = "price";
		}
		if (sort != null && sort.equals("price_max")) {
			sort = "price desc";
		}

		if (category != null) {
			sql += " and category='" + category + "'";
		}

		sql += " order by ";

		if (sort != null) {
			sql += sort + ", ";
		}

		sql += "product_id desc))";

		List<ProductVo> list = dao.getAll_product(sql);
		view.addObject("len", list.size());

		int pageMax = list.size() / productMax;

		if (list.size() % productMax != 0)
			pageMax++;

		sql += "where rnum>=" + startNum + " and rnum<=" + endNum;

		list = dao.getAll_product(sql);

		view.addObject("list", list);
		view.addObject("viewPage", "product/product.jsp");
		view.addObject("category", category);
		view.addObject("sort", sort);
		view.addObject("pageMax", pageMax);
		return view;
	}

	@RequestMapping("/productDetail.do")
	public ModelAndView getOne_product(int product_id) {
		ModelAndView view = new ModelAndView();
		view.setViewName("main");
		ProductVo p = dao.getOne_product(product_id);
		view.addObject("list", p);
		view.addObject("viewPage", "product/productDetail.jsp");
		return view;
	}

	@RequestMapping("/sellList.do")
	public ModelAndView sellList(String member_id) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("main");
		mav.addObject("member_id", member_id);
		mav.addObject("viewPage", "sell/sellList.jsp");
		return mav;
	}

	@RequestMapping(value = "/sellList_product.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String getMySell_product(String member_id, @RequestParam(defaultValue = "1") int pageNum) {
		/*
		 * ModelAndView view = new ModelAndView(); view.setViewName("main");
		 */
		int productMax = 10;
		int endNum = pageNum * productMax;
		int startNum = endNum - (productMax - 1);
		System.out.println("member_id: " + member_id);
		String sql = "select * from (select rownum rnum, product_id,condition, product_name, category, quality, price, main_img, sub_img, member_id from (select product_id,condition, product_name, category, quality, price, main_img, sub_img, member_id from product where member_id='"
				+ member_id + "' order by product_id))";

		List<ProductVo> list = dao.getMySell_product(sql);

		int pageMax = list.size() / productMax;
		if (list.size() % productMax != 0)
			pageMax++;
		list = dao.getMySell_product(sql);
		String str = "";
		ObjectMapper mapper = new ObjectMapper();

		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			System.out.println(e);
		}

		return str;

		/*
		 * list = dao.getMySell_product(sql);
		 * 
		 * view.setViewName("main"); view.addObject("len", list.size());
		 * view.addObject("member_id", member_id); view.addObject("list", list);
		 * view.addObject("pageMax", pageMax); view.addObject("viewPage",
		 * "sell/sellList.jsp");
		 * 
		 * 
		 * return view;
		 */
	}

	@RequestMapping(value = "/getCondition_product.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String getCondition_product(int product_id) {
		String str = "";

		ProductVo p = dao.getOne_product(product_id);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(p);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/UpdateCondition_product", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String UpdateConditionToSell_product(int product_id, String condition) {
		String str = "";

		int re = dao.updateCondition_product(product_id, condition);

		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/sellInsert.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public ModelAndView insert_sell(ProductVo p, HttpServletRequest request) {
		String path = request.getRealPath("/resources/img/product");
		String main_img = "";
		String sub_img = "";
		int fsize1 = 0;
		int fsize2 = 0;
		MultipartFile mainIMG = p.getMainIMG();
		MultipartFile subIMG = p.getSubIMG();

		if (mainIMG != null && subIMG != null) {
			try {
				byte[] data1 = mainIMG.getBytes();
				byte[] data2 = subIMG.getBytes();

				main_img = mainIMG.getOriginalFilename();
				sub_img = subIMG.getOriginalFilename();
				fsize1 = data1.length;
				fsize2 = data2.length;
				FileOutputStream fos1 = new FileOutputStream(path + "/" + main_img);
				FileOutputStream fos2 = new FileOutputStream(path + "/" + sub_img);
				fos1.write(data1);
				fos2.write(data2);
				fos1.close();
				fos2.close();

			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
			}
		}
		p.setMain_img(main_img);
		p.setSub_img(sub_img);

		int product_id = dao.getNextId_product();
		p.setProduct_id(product_id);
		p.setCondition("등록");
		String str = "";

		ModelAndView view = new ModelAndView();
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(p);
		} catch (Exception e) {
			System.out.println(e);
		}
		dao.insert_product(p);
		view.setViewName("main");
		view.addObject("member_id", p.getMember_id());
		view.addObject("viewPage", "sell/sellList.jsp");
		return view;
	}

	@RequestMapping("/sellUpdate.do")
	public ModelAndView update_sell() {
		ModelAndView view = new ModelAndView();
		view.setViewName("main");
		view.addObject("viewPage", "sell/sellUpdate.jsp");
		return view;
	}
}
