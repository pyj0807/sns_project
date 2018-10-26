package sns.repository;

import java.util.Comparator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.mongodb.client.result.UpdateResult;

@Repository
public class BoardDao {
	@Autowired
	MongoTemplate template;
	
	//board에 저장된 데이터 불러오기
	public List<Map> getAllBoard(){
		List<Map> list = template.findAll(Map.class,"board");
		//뽑아온 list 내림차순정렬
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
	//board에 저장된 데이터 한건 불러오기
	public Map getOneBoard(int no){
		Criteria c = Criteria.where("_id").in(no);
		return template.findOne(new Query(c), Map.class,"board");
	}
	//board_like 테이블에 게시글 좋아요한사람 추가하기 (update로 처리)
	public long addBoardLiker(double num, String liker) { //리턴해주면에러풀림
		//0.query
		Query query = new Query(Criteria.where("_id").is(num));
		//1.update(배열에추가)
		Update u = new Update().push("liker", liker);
		//2.UpdateResult
		UpdateResult rst = template.updateMulti(query, u, "board");
		return rst.getModifiedCount();
	}
	//board_like 테이블에 게시글 좋아요 취소
	public long removeBoardLiker(double num, String liker) {
		//0.query
		Query query = new Query(Criteria.where("_id").is(num));
		//1.update(배열에추가)
		Update u = new Update().pull("liker", liker);
		//2.UpdateResult
		UpdateResult rst = template.updateMulti(query, u, "board");
		return rst.getModifiedCount();
	}
	//board테이블에서  파라미터로 Hashcode 뽑기 
	public List<Map> getBoardHash(String[] hashtag){
		Query query = new Query(Criteria.where("hashcode").in(hashtag));
		return template.find(query, Map.class, "board");
	}
}
