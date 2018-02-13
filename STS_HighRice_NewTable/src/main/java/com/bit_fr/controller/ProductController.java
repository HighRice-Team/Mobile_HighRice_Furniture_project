package com.bit_fr.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.ProductDao;
import com.bit_fr.dao.QnaBoardDao;
import com.bit_fr.vo.ProductVo;
import com.bit_fr.vo.QnaBoardVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class ProductController {

	@Autowired
	private ProductDao dao;

	public void setDao(ProductDao dao) {
		this.dao = dao;
	}
	@Autowired
	private QnaBoardDao qdao;
	
	
	public void setQdao(QnaBoardDao qdao) {
		this.qdao = qdao;
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
			@RequestParam(defaultValue = "0") int min, @RequestParam(defaultValue = "0") int max, HttpSession session) {
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

	@RequestMapping("/product_list.do")
	@ResponseBody
	public ModelAndView getAll_product(@RequestParam(defaultValue = "") String sort, String category,
			@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "0") int min,
			@RequestParam(defaultValue = "0") int max) {
		ModelAndView view = new ModelAndView();
		int productMax = 10;
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

		ArrayList<String> price_with = new ArrayList<String>();

		for (int i = 0; i < list.size(); i++) {
			DecimalFormat comma = new DecimalFormat("#,###");
			int price = list.get(i).getPrice();
			price_with.add(comma.format(price) + "");
		}

		view.addObject("list", list);
		view.addObject("viewPage", "product/product_list.jsp");
		view.addObject("category", category);
		view.addObject("sort", sort);
		view.addObject("pageMax", pageMax);
		view.addObject("price_with", price_with);
		return view;
	}

	@RequestMapping("/product_detail.do")
	public ModelAndView getProductDetail(int product_id) {
		ModelAndView mav = new ModelAndView("main");
		ProductVo p = dao.getOne_product(product_id);
		List<QnaBoardVo> list = qdao.getAll_qnaBoard();
		mav.addObject("product_id",product_id);
		mav.addObject("vo",p);
		mav.addObject("list",list);
		mav.addObject("viewPage","product/product_detail.jsp");
		
		return mav;
	}

	@RequestMapping("/sellList.do")
	public ModelAndView sellList(HttpSession session, @RequestParam(value = "page", defaultValue = "1") int page) {
		ModelAndView mav = new ModelAndView();

		String member_id = (String) session.getAttribute("id");

		int count = dao.getMySellCount_product(member_id);
		int max = 5;
		int end = page * max;
		int start = end - (max - 1);

		if (end > count) {
			end = count;
		}

		int totalPage = count / max;
		if (count % max != 0) {
			totalPage++;
		}
		
		

		String sql = "select * from (select rownum rnum, product_id,condition, product_name, category, quality, price, main_img, sub_img, member_id from (select product_id,condition, product_name, category, quality, price, main_img, sub_img, member_id from product where member_id='"
				+ member_id + "' order by product_id desc) order by rownum) r where r.rnum>=" + start + "and r.rnum<="
				+ end;
		mav.addObject("list", dao.getMySell_product(sql));
		mav.addObject("member_id", member_id);



		mav.addObject("totalPage", totalPage);
		mav.addObject("viewPage", "sell/sellList.jsp");

		mav.setViewName("main");
		return mav;
	}

	@RequestMapping("/sellDetail.do")
	public ModelAndView sellDetail(int product_id) {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("p", dao.getOne_product(product_id));

		mav.setViewName("main");
		mav.addObject("viewPage" ,"sell/sellDetail.jsp");

		return mav;
	}

	@RequestMapping(value = "/sellList_product.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String getMySell_product(String member_id, @RequestParam(defaultValue = "1") int pageNum) {

		//ModelAndView view = new ModelAndView(); view.setViewName("main");

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


//	      int product_id = dao.getNextId_product();
//	      p.setProduct_id(product_id);
//	      p.setCondition("등록");
//	      
//	      ModelAndView view = new ModelAndView();
//	      
//	      
//	      dao.insert_product(p);
//
//	      view.addObject("member_id", p.getMember_id());
//	      view.setViewName("redirect:/sellList.do");
//	      return view;
//	   }

	@RequestMapping("/sellInsert.do")
	public ModelAndView insert_sell(ProductVo p, HttpServletRequest request, HttpSession session) {
		String path = request.getRealPath("/resources/img/product");
		System.out.println(path);
		String member_id = (String) session.getAttribute("member_id");
		String main_img = "";
		String sub_img = "";
		int fsize1 = 0;
		int fsize2 = 0;
		MultipartFile mainIMG = p.getMainIMG();
		MultipartFile subIMG = p.getSubIMG();


		if (mainIMG.getSize() != 0 && subIMG.getSize() != 0) {
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
		p.setMember_id(member_id);
		p.setMain_img(main_img);
		p.setSub_img(sub_img);

		int product_id = dao.getNextId_product();
		p.setProduct_id(product_id);
		p.setCondition("등록");

		ModelAndView view = new ModelAndView();
		
		dao.insert_product(p);
		// view.setViewName("main");
		view.addObject("member_id", p.getMember_id());
		// view.addObject("viewPage", "sell/sellList");
		view.setViewName("redirect:/sellList.do");
		return view;
	}

	@RequestMapping("/sellUpdate.do")
	public ModelAndView update_sell(ProductVo p, HttpServletRequest request) {

		ModelAndView view = new ModelAndView();

		MultipartFile mainIMG = p.getMainIMG();
		MultipartFile subIMG = p.getSubIMG();

		String main_img = "";
		String sub_img = "";

		String path = request.getRealPath("/resources/img/product");

		String oldMain = dao.getOne_product(p.getProduct_id()).getMain_img();
		String oldSub = dao.getOne_product(p.getProduct_id()).getSub_img();

		p.setMain_img(oldMain);
		p.setSub_img(oldSub);

		if (mainIMG.getSize() != 0) {
			main_img = mainIMG.getOriginalFilename();

			if (!main_img.equals(oldMain)) {
				File file = new File(path + "/" + oldMain);
				file.delete();

				try {
					byte b[] = mainIMG.getBytes();
					FileOutputStream fos = new FileOutputStream(path + "/" + main_img);

					fos.write(b);

					fos.close();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					System.out.println(e);
				}
				p.setMain_img(main_img);

			}
		}

		if (subIMG.getSize() != 0) {
			sub_img = subIMG.getOriginalFilename();

			if (!sub_img.equals(oldSub)) {
				File file = new File(path + "/" + oldSub);
				file.delete();

				try {
					byte b[] = subIMG.getBytes();
					FileOutputStream fos = new FileOutputStream(path + "/" + sub_img);

					fos.write(b);

					fos.close();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					System.out.println(e);
				}

				p.setSub_img(sub_img);

			}
		}

		int re = dao.update_product(p.getProduct_name(), p.getCategory(), p.getQuality(), p.getMain_img(),
				p.getSub_img(), p.getProduct_id());
		if (re == 1) {
			view.setViewName("redirect:/sellList.do");
		}

		return view;
	}
}
