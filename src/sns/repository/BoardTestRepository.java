package sns.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class BoardTestRepository {
	@Autowired
	MongoTemplate template;
	
	@Autowired
	SqlSessionTemplate sqltemplate;
	
	// 게시판에 글 하나 올리기
	public void insertOne(Map map) {
		Map ret = template.insert(map, "board");
	}
	
	// 게시글 고유번호 생성
	public int getBoardNo() {
		return sqltemplate.selectOne("board.getBoardNo");
	}
	
	// 작성자 아이디로 글 찾기 (마이페이지용)
	public List<Map> findWriter(String writer) {
		Criteria c = 
			Criteria.where("writer").in(writer);
		
		return template.find(new Query(c), Map.class, "board");
	}
	
}
