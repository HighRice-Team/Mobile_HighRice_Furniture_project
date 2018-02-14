package com.bit_fr.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.bit_fr.db.ProductManager;
import com.bit_fr.vo.ProductVo;

@Repository
public class ProductDao {

	public List<ProductVo> getAll_product(String sql) {
		return ProductManager.getAll_product(sql);
	}
	

	public List<ProductVo> getAll_productAdmin(ProductVo v){
		return ProductManager.getAll_productAdmin(v);

	}

	public ProductVo getOne_product(int product_id) {
		return ProductManager.getOne_product(product_id);
	}

	public int getNextId_product() {
		return ProductManager.getNextId_product();
	}

	public List<ProductVo> getCust(String sql) {
		return ProductManager.getCust(sql);
	}

	public int getCount_product() {
		return ProductManager.getCount_product();
	}

	public ProductVo getCutomizeList_product(String sql) {
		return ProductManager.getCutomizeList_product(sql);
	}

	public List<ProductVo> getMySell_product(String sql) {
		return ProductManager.getMySell_product(sql);
	}

	public int getMySellCount_product(String member_id) {
		return ProductManager.getMySellCount_product(member_id);
	}

	public int getMySellCountWithCondition_product(String member_id, String condition) {
		return ProductManager.getMySellCountWithCondition_product(member_id, condition);
	}

	public int getAllPublishingCount_product(String category, String condition) {
		return ProductManager.getAllPublishingCount_product(category, condition);
	}

	public List<ProductVo> getMySellForPaging_product(String member_id) {
		return ProductManager.getMySellForPaging_product(member_id);
	}

	public int getItemPublishingCount_product(String condition) {
		return ProductManager.getItemPublishingCount_product(condition);
	}

	public ProductVo getForAdmin_product() {
		return ProductManager.getForAdmin_product();
	}
	
	public String getCondition_product(int product_id) {
		return ProductManager.getCondition_product(product_id);
	}

	public int insert_product(ProductVo p) {
		return ProductManager.insert_product(p);
	}

	public int update_product(String product_name, String category, String quality, String main_img, String sub_img, int product_id) {
		return ProductManager.update_product(product_name, category, quality, main_img, sub_img, product_id);
	}

	public int updateCondition_product(int product_id, String condition) {
		return ProductManager.updateCondition_product(product_id, condition);
	}

	public int updateAdmin_product(ProductVo p) {
		return ProductManager.updateAdmin_product(p);
	}

	
	public int delete_product(int product_id) {
		return ProductManager.delete_product(product_id);


	}

}
