package semi.project.jsnr.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import semi.project.jsnr.member.model.vo.Member;

@Repository
public class MemberDAO {

	public Member login(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("memberMapper.login", memberId);
	}

}