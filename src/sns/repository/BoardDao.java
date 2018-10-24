package sns.repository;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDao {
	@Autowired
	MongoTemplate template;
	
	//board에 저장된 데이터 불러오기
	public List<Map> getAllBoard(){
		List<Map> list = template.findAll(Map.class,"board");
		return list;
	}
	//board에 저장된 데이터 한건 불러오기
	public Map getOneBoard(int no){
		Criteria c = Criteria.where("_id").in(no);
		return template.findOne(new Query(c), Map.class,"board");
	}
	//board테이블에 like 건수 1씩 증가시키기
	public int addOneBoardLike(double num) {
		
		return 1;
	}
}
