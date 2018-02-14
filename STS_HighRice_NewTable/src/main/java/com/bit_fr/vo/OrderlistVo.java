package com.bit_fr.vo;

public class OrderlistVo {
	private int order_id;
	private String member_id;
	private int product_id;
	private String pay_date;
	private String rent_start;
	private String rent_end;
	private int rent_month;

	// page Vo
	private int rnum;

	// Join product
	private String product_name;
	private String main_img;
	private String price;
	// product_id
	private int pr;
	// condition - product condition과 연동
	private String con;
	// orderlist만의 condition
	private String orderlist_condition;
	private String category;
	private String quality;
	
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getPay_date() {
		return pay_date;
	}
	public void setPay_date(String pay_date) {
		this.pay_date = pay_date;
	}
	public String getRent_start() {
		return rent_start;
	}
	public void setRent_start(String rent_start) {
		this.rent_start = rent_start;
	}
	public String getRent_end() {
		return rent_end;
	}
	public void setRent_end(String rent_end) {
		this.rent_end = rent_end;
	}
	public int getRent_month() {
		return rent_month;
	}
	public void setRent_month(int rent_month) {
		this.rent_month = rent_month;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getMain_img() {
		return main_img;
	}
	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public int getPr() {
		return pr;
	}
	public void setPr(int pr) {
		this.pr = pr;
	}
	public String getCon() {
		return con;
	}
	public void setCon(String con) {
		this.con = con;
	}
	public String getOrderlist_condition() {
		return orderlist_condition;
	}
	public void setOrderlist_condition(String orderlist_condition) {
		this.orderlist_condition = orderlist_condition;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getQuality() {
		return quality;
	}
	public void setQuality(String quality) {
		this.quality = quality;
	}
	public OrderlistVo(int order_id, String member_id, int product_id, String pay_date, String rent_start,
			String rent_end, int rent_month, int rnum, String product_name, String main_img, String price, int pr,
			String con, String orderlist_condition, String category, String quality) {
		super();
		this.order_id = order_id;
		this.member_id = member_id;
		this.product_id = product_id;
		this.pay_date = pay_date;
		this.rent_start = rent_start;
		this.rent_end = rent_end;
		this.rent_month = rent_month;
		this.rnum = rnum;
		this.product_name = product_name;
		this.main_img = main_img;
		this.price = price;
		this.pr = pr;
		this.con = con;
		this.orderlist_condition = orderlist_condition;
		this.category = category;
		this.quality = quality;
	}
	public OrderlistVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "OrderlistVo [order_id=" + order_id + ", member_id=" + member_id + ", product_id=" + product_id
				+ ", pay_date=" + pay_date + ", rent_start=" + rent_start + ", rent_end=" + rent_end + ", rent_month="
				+ rent_month + ", rnum=" + rnum + ", product_name=" + product_name + ", main_img=" + main_img
				+ ", price=" + price + ", pr=" + pr + ", con=" + con + ", orderlist_condition=" + orderlist_condition
				+ ", category=" + category + ", quality=" + quality + "]";
	}
	
	

	
}
