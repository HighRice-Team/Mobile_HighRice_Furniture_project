package com.bit_fr.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit_fr.db.Board_QnAManager;
import com.bit_fr.vo.Board_QnAVo;

@Repository
public class Board_QnADao {

	// ����¡ó���� ���õ� ����

	// ��ȭ�鿡 ������ �Խù��� ��
	public static int pageSIZE = 10;

	// ��ü���ڵ� ��
	public static int totalRecord = 0;

	// ��ü������ ��
	public static int totalPage = 1;

	public int update(Board_QnAVo b) {
		return Board_QnAManager.update(b);
	}

	public int nextNo() {
		return Board_QnAManager.nextNo();
	}

	public int insert(Board_QnAVo b) {
		return Board_QnAManager.insert(b);
	}

	public List<Board_QnAVo> list(int pageNUM, String writer, String my) {
		totalRecord = Board_QnAManager.getTotalRecord(writer, my);

		// ��ü���̼��� ����Ͽ� totalPage�� �����մϴ�.
		/*
		 * ��ȭ�鿡 10���� �����ַ��� �մϴ�. ���࿡ �Խù��� ���� 24����� ��ü���������� 3�̾�� �մϴ�.
		 * 
		 * totlaRecord/pageSIZE
		 * 
		 * ���࿡ totalRecord % pageSIZE 0�� �ƴ϶�� 1����
		 */

		totalPage = (int) Math.ceil(totalRecord / (double) pageSIZE);

		/*
		 * totlaRecord / pageSIZE int int ==> ����� int 2
		 * 
		 * 
		 * �Ǽ��� ����� ���Ѵٸ� ���߿� �ϳ��� �Ǽ��� ĳ�����Ͽ� �����Ų��.
		 * 
		 * totalRecord / (double)pageSIZE ==> ����� double int double 2.4
		 * 
		 * 
		 * ������ �� ���� �ø����� ���ϱ� ���Ͽ� Math.ceil(2.4) ===> 3.0 �Ǽ��� ��ȯ
		 * 
		 * (int)Math.ceil(2.4) 3.0 3
		 */

		return Board_QnAManager.list(pageNUM, writer, my);
	}

	public Object getBoard(int no) {
		// TODO Auto-generated method stub
		return Board_QnAManager.getBoard(no);
	}

	public int deleteBoard(int no) {
		// TODO Auto-generated method stub
		return Board_QnAManager.deleteBoard(no);
	}

	public void updateStep(int b_ref, int b_step) {
		// TODO Auto-generated method stub
		Board_QnAManager.updateStep(b_ref, b_step);
	}
}
