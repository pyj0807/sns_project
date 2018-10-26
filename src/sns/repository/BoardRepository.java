package sns.repository;

import java.util.Comparator;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class BoardRepository {
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
	
	// 작성자 아이디로 글 찾기
	public List<Map> findWriter(String writer) {
		Criteria c = 	Criteria.where("writer").in(writer);
		List<Map> list =  template.find(new Query(c), Map.class, "board");
	     list.sort(new Comparator<Map>() {
	          @Override
	          public int compare(Map o1, Map o2) {
	             long n1 = (long)o1.get("time"); //time숫자가 클수록 최근
	             long n2 = (long)o2.get("time");   
	             if(n1>n2) {//2번째>1번째 
	                return -1; //-1내림
	             }else if(n1<n2){
	                return 1; //1오름
	             }else {
	                return 0;
	             }
	          }
	       });
		return list;
	}


}


