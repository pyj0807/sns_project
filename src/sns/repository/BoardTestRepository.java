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
	
	public void insertOne(Map map) {
		Map ret = template.insert(map, "board");
		// Returns: the inserted object.
	}
	
	public int getBoardNo() {
		return sqltemplate.selectOne("board.getBoardNo");
	}
	
	
	public List<Map> findWriter(String writer) {
		Criteria c = 
			Criteria.where("writer").in(writer);
		
		return template.find(new Query(c), Map.class, "board");
	}
	
}
