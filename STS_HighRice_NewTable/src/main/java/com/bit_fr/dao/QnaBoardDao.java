package com.bit_fr.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.bit_fr.db.QnaBoardManager;
import com.bit_fr.vo.QnaBoardVo;

@Repository
public class QnaBoardDao {
	public List<QnaBoardVo> getAll_qnaBoard() {
		return QnaBoardManager.getAll_qnaBoard();
	}

	public List<QnaBoardVo> getDetail_qnaBoard(int board_id) {
		return QnaBoardManager.getDetail_qnaBoard(board_id);
	}

	public QnaBoardVo getOne_qnaBoard(int board_id) {
		return QnaBoardManager.getOne_qnaBoard(board_id);
	}

	public int getNextId_qnaBoard() {
		return QnaBoardManager.getNextId_qnaBoard();
	}
	
	public int getCountRef_qnaboard(int b_ref) {
		return QnaBoardManager.getCountRef_qnaboard(b_ref);
	}

	public int insert_qnaBoard(QnaBoardVo qnaboard) {
		return QnaBoardManager.insert_qnaBoard(qnaboard);
	}

	public int update_qnaBoard(QnaBoardVo qnaboard) {
		return QnaBoardManager.update_qnaBoard(qnaboard);
	}

	public int updateParents_qnaBoard(int board_id) {
		return QnaBoardManager.updateParents_qnaBoard(board_id);
	}

	public int delete_qnaBoard(int board_id) {
		return QnaBoardManager.delete_qnaBoard(board_id);
	}

	public int hidden_qnaBoard(int board_id) {
		return QnaBoardManager.hidden_qnaBoard(board_id);
	}
}
