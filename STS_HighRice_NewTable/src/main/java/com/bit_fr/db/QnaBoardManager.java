package com.bit_fr.db;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import com.bit_fr.vo.QnaBoardVo;

public class QnaBoardManager {
	private static SqlSessionFactory factory;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/bit_fr/db/sqlMapConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	public static  List<QnaBoardVo> getAll_qnaBoard(){
		SqlSession session = factory.openSession();
		List<QnaBoardVo> list = session.selectList("qnaBoard.getAll_qnaBoard");
		session.close();
		return list;
	}
	
	public static List<QnaBoardVo> getDetail_qnaBoard(int board_id) {
		SqlSession session = factory.openSession();
		List<QnaBoardVo> list = session.selectList("qnaBoard.getDetail_qnaBoard", board_id);
		session.close();
		return list;
	}
	
	public static QnaBoardVo getOne_qnaBoard(int board_id) {
		SqlSession session = factory.openSession();
		QnaBoardVo qnaboard = session.selectOne("qnaBoard.getOne_qnaBoard", board_id);
		session.close();
		return qnaboard;
	}
	
	public static QnaBoardVo getComment_qnaBoard(int b_ref) {
		SqlSession session = factory.openSession();
		QnaBoardVo qnaboard = session.selectOne("qnaBoard.getComment_qnaBoard", b_ref);
		session.close();
		return qnaboard;
	}
	
	public static int getNextId_qnaBoard(){
		SqlSession session = factory.openSession();
		int nextId = session.selectOne("qnaBoard.getNextId_qnaBoard");
		session.close();
		return nextId;
	}
	
	public static int getCountRef_qnaboard(int b_ref) {
		SqlSession session = factory.openSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("b_ref", b_ref);
		int re = session.selectOne("qnaBoard.getCountRef_qnaboard", map);
		session.close();
		
		return re;
	}
	
	public static int insert_qnaBoard(QnaBoardVo qnaboard){
		SqlSession session = factory.openSession();
		int re = session.insert("qnaBoard.insert_qnaBoard", qnaboard);
		session.commit();
		session.close();
		return re;
	}
	public static int update_qnaBoard(QnaBoardVo qnaboard) {
		SqlSession session = factory.openSession();
		int re = session.update("qnaBoard.update_qnaBoard", qnaboard);
		session.commit();
		session.close();
		return re;
	}
	public static int updateParents_qnaBoard(int board_id) {
		SqlSession session = factory.openSession();
		int re = session.update("qnaBoard.updateParents_qnaBoard", board_id);
		session.commit();
		session.close();
		return re;
	}
	public static int delete_qnaBoard(int board_id) {
		SqlSession session = factory.openSession();
		int re= session.insert("qnaBoard.delete_qnaBoard", board_id);
		session.commit();
		session.close();
		return re;
	}
	public static int hidden_qnaBoard(int board_id) {
		SqlSession session = factory.openSession();
		int re= session.update("qnaBoard.hidden_qnaBoard", board_id);
		session.commit();
		session.close();
		return re;
	}
}
