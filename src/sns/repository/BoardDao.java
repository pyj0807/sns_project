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
		//1.update(배열에삭제)
		Update u = new Update().pull("liker", liker);
		//2.UpdateResult
		UpdateResult rst = template.updateMulti(query, u, "board");
		return rst.getModifiedCount();
	}
	//board테이블에서  파라미터로 Hashcode 뽑기 
	public List<Map> getBoardHash(String[] hashtag){
		Query query = new Query(Criteria.where("hashcode").in(hashtag));
		List<Map> list = template.find(query, Map.class, "board");
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
	
	//reply 달기
	public void addBoardReply(Map param) {
		template.insert(param,"board_reply");
	}
	//reply 조회
	public List<Map> getBoardReply(int no) {
		Criteria c = Criteria.where("id").in(no);
		List<Map> list = template.find(new Query(c), Map.class,"board_reply");
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
	//reply 삭제
	public void deleteBoardReply(String key) {
		Query query = new Query(Criteria.where("key").in(key));
		template.remove(query,"board_reply");
	} 
	//board 수정
	public void updateBoard(int no,String content,String interest,List hash,String lat, String longi,String area) {
		Criteria c = Criteria.where("_id").in(no);
		//1.update(배열에추가)
		Update u = new Update().set("content", content);
		Update u2 = new Update().set("interest", interest);
		Update u3 = new Update().set("hashcode", hash);
		Update u4 = new Update().set("lat", lat);
		Update u5 = new Update().set("longi", longi);
		Update u6 = new Update().set("area", area);
		//2.UpdateResult
		UpdateResult rst = template.updateMulti(new Query(c), u, "board");
		UpdateResult rst2 = template.updateMulti(new Query(c), u2, "board");
		UpdateResult rst3 = template.updateMulti(new Query(c), u3, "board");
		UpdateResult rst4 = template.updateMulti(new Query(c), u4, "board");
		UpdateResult rst5 = template.updateMulti(new Query(c), u5, "board");
		UpdateResult rst6 = template.updateMulti(new Query(c), u6, "board");
	}
	//board 삭제
	public void deleteBoard(int no) {
		//1.board 테이블삭제
		Query query = new Query(Criteria.where("_id").in(no));
		//2.board_reply 테이블삭제
		Query query2 = new Query(Criteria.where("id").in(no));
		//3.like 테이블삭제
		Query query3 = new Query(Criteria.where("roomId").in(no));
		
		template.remove(query,"board");
		template.remove(query2,"board_reply");
		template.remove(query3,"like");
	}
	
	//지도 조회(정렬)
	public List<Map> searchMap(String loc){
		//조건
		Criteria c = Criteria.where("area").in(loc);
		//출력
		List<Map> list = template.find(new Query(c),Map.class,"board");
		//정렬
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
