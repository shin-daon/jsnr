package semi.project.jsnr.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import semi.project.jsnr.board.model.vo.Board;
import semi.project.jsnr.common.model.vo.PageInfo;
import semi.project.jsnr.jibsa.model.vo.Jibsa;
import semi.project.jsnr.jibsa.model.vo.JibsaProfile;

@Repository
public class BoardDAO {

	public int getListCount(SqlSessionTemplate sqlSession, int i) {
		return sqlSession.selectOne("boardMapper.getListCount", i);
	}

	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi, int i) {
		int offset = (pi.getCurrentPage() -1 ) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", i, rowBounds);
	}

	public int getJibsaListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.getJibsaListCount");
	}

	public ArrayList<JibsaProfile> getSelectJibsaProfileList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.getSelectJibsaProfileList", pi, rowBounds);
	}

	public Jibsa getJibsaInfo(SqlSessionTemplate sqlSession, int mId) {
		return sqlSession.selectOne("boardMapper.getJibsaInfo", mId);
	}

	public JibsaProfile getJibsaProfile(SqlSessionTemplate sqlSession, int mId) {
		return sqlSession.selectOne("boardMapper.getJibsaProfile", mId);
	}
}

