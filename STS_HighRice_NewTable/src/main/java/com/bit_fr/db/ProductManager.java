package com.bit_fr.db;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit_fr.vo.ProductVo;

public class ProductManager {
	private static SqlSessionFactory factory;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/bit_fr/db/sqlMapConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
	}

	public static List<ProductVo> getCust(String sql) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);

		SqlSession session = factory.openSession();
		List<ProductVo> list = session.selectList("product.getCust", map);
		session.close();
		return list;
	}

	public static List<ProductVo> getAll_product(String sql) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);
		SqlSession session = factory.openSession();
		List<ProductVo> list = session.selectList("product.getAll_product", map);
		session.close();
		return list;
	}

	public static List<ProductVo> getAll_productAdmin(ProductVo v) {
		HashMap<String, String> map = new HashMap<String, String>();

		if (v.getProduct_id() != 0) {

			map.put("product_id", v.getProduct_id() + "");
		}

		if (!v.getCategory().equals("")) {
			// map.put("category",v.getCategory().toUpperCase());
			map.put("category", v.getCategory());
		}
		if (!v.getProduct_name().equals("")) {
			map.put("product_name", "%" + v.getProduct_name() + "%");
		}
		if (!v.getMember_id().equals("")) {
			map.put("member_id", v.getMember_id());
		}
		if (!v.getQuality().equals("")) {
			map.put("quality", v.getQuality().toUpperCase());
		}
		if (v.getPrice() != 0) {
			map.put("price", v.getPrice() + "");
		}
		if (!v.getCondition().equals("")) {
			map.put("condition", v.getCondition());
		}

		SqlSession session = factory.openSession();

		List<ProductVo> list = session.selectList("getAll_productAdmin", map);

		session.close();

		return list;
	}

	public static ProductVo getOne_product(int product_id) {
		SqlSession session = factory.openSession();
		ProductVo p = session.selectOne("product.getOne_product", product_id);
		session.close();
		return p;
	}

	public static int getNextId_product() {

		SqlSession session = factory.openSession();
		int n = session.selectOne("product.getNextId_product");
		session.close();
		return n;
	}

	public static int getCount_product() {
		SqlSession session = factory.openSession();
		int re = session.selectOne("product.getCount_product");
		session.close();
		return re;
	}

	public static ProductVo getCutomizeList_product(String sql) {
		SqlSession session = factory.openSession();
		ProductVo p = (ProductVo) session.selectList("product.getCutomizeList_product", sql);
		session.close();
		return p;
	}

	public static List<ProductVo> getMySell_product(String sql) {
		SqlSession session = factory.openSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);
		List<ProductVo> list = session.selectList("product.getMySell_product", map);
		session.close();
		return list;
	}

	public static int getMySellCount_product(String member_id) {
		SqlSession session = factory.openSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		int n = session.selectOne("product.getMySellCount_product", map);
		session.close();
		return n;
	}

	public static int getMySellCountWithCondition_product(String member_id, String condition) {
		SqlSession session = factory.openSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("condition", condition);
		int n = session.selectOne("product.getMySellCountWithCondition_product", map);
		session.close();
		return n;
	}

	public static List<ProductVo> getMySellForPaging_product(String member_id) {
		SqlSession session = factory.openSession();
		HashMap map = new HashMap();
		map.put("member_id", member_id);
		List<ProductVo> list = session.selectList("product.getMySellForPaging_product", map);
		session.close();
		return list;
	}

	public static int getAllPublishingCount_product(String category, String condition) {
		SqlSession session = factory.openSession();
		HashMap map = new HashMap();
		map.put("category", category);
		map.put("condition", condition);

		int re = session.selectOne("product.getAllPublishingCount_product", map);
		session.close();
		return re;
	}

	public static int getItemPublishingCount_product(String condition) {
		SqlSession session = factory.openSession();
		int re = session.selectOne("product.getItemPublishingCount_product");
		session.close();
		return re;
	}

	public static String getCondition_product(int product_id) {
		SqlSession session = factory.openSession();
		String condition = session.selectOne("product.getCondition_product", product_id);
		session.close();
		return condition;
	}

	public static ProductVo getForAdmin_product() {
		SqlSession session = factory.openSession();
		ProductVo p = (ProductVo) session.selectList("product.getForAdmin_product");
		session.close();
		return p;
	}

	public static int insert_product(ProductVo p) {
		SqlSession session = factory.openSession(true);
		int re = session.insert("product.insert_product", p);
		session.close();
		return re;
	}

	public static int update_product(String product_name, String category, String quality, String main_img,
			String sub_img, int product_id) {
		SqlSession session = factory.openSession(true);
		HashMap map = new HashMap();
		map.put("product_name", product_name);
		map.put("category", category);
		map.put("quality", quality);
		map.put("main_img", main_img);
		map.put("sub_img", sub_img);
		map.put("product_id", product_id);
		int re = session.update("product.update_product", map);
		session.close();
		return re;
	}

	public static int updateCondition_product(int product_id, String condition) {
		SqlSession session = factory.openSession(true);
		HashMap map = new HashMap();
		map.put("product_id", product_id);
		map.put("condition", condition);
		System.out.println(product_id);

		int re = session.update("product.updateCondition_product", map);
		session.close();
		return re;
	}

	public static int updateAdmin_product(ProductVo p) {
		SqlSession session = factory.openSession();

		int re = session.update("product.updateAdmin_product", p);
		session.commit();
		session.close();
		return re;
	}

	public static int updateCollectConfirm_product(int product_id, String category, String quality, int price,
			String condition) {
		SqlSession session = factory.openSession(true);
		HashMap map = new HashMap();
		map.put("product_id", product_id);
		map.put("category", category);
		map.put("quality", quality);
		map.put("price", price);
		map.put("condition", condition);

		int re = -1;
		re = session.update("product.updateCollectConfirm_product", map);

		session.close();
		return re;
	}

	public static int updateReturnConfirm_product(int product_id, String quality, int price, String condition) {
		SqlSession session = factory.openSession(true);
		HashMap map = new HashMap();
		map.put("product_id", product_id);
		map.put("quality", quality);
		map.put("price", price);
		map.put("condition", condition);

		int re = -1;
		re = session.update("product.updateReturnConfirm_product", map);

		session.close();
		return re;
	}

	public static int delete_product(int product_id) {

		SqlSession session = factory.openSession();
		int re = session.delete("product.delete_product", product_id);
		session.commit();
		session.close();
		return re;
	}

}
