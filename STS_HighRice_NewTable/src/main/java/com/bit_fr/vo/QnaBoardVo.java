package com.bit_fr.vo;

public class QnaBoardVo {
	private int board_id;
	private String post_type;
	private String title;
	private String member_id;
	private int product_id;
	private String regdate;
	private String content;
	private int b_ref;
	private int b_level;

	public QnaBoardVo() {
		super();
	}
	
	

	@Override
	public String toString() {
		return "QnaBoardVo [board_id=" + board_id + ", post_type=" + post_type + ", title=" + title + ", member_id="
				+ member_id + ", product_id=" + product_id + ", regdate=" + regdate + ", content=" + content
				+ ", b_ref=" + b_ref + ", b_level=" + b_level + "]";
	}



	public QnaBoardVo(int board_id, String post_type, String title, String member_id, int product_id, String regdate, String content, int b_ref, int b_level) {
		super();
		this.board_id = board_id;
		this.post_type = post_type;
		this.title = title;
		this.member_id = member_id;
		this.product_id = product_id;
		this.regdate = regdate;
		this.content = content;
		this.b_ref = b_ref;
		this.b_level = b_level;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public String getPost_type() {
		return post_type;
	}

	public void setPost_type(String post_type) {
		this.post_type = post_type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getB_ref() {
		return b_ref;
	}

	public void setB_ref(int b_ref) {
		this.b_ref = b_ref;
	}

	public int getB_level() {
		return b_level;
	}

	public void setB_level(int b_level) {
		this.b_level = b_level;
	}
}