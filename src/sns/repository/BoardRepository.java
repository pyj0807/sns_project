package sns.repository;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.google.gson.Gson;

import jdk.nashorn.internal.runtime.regexp.joni.Regex;

@Repository
public class BoardRepository {
	@Autowired
	MongoTemplate template;

	@Autowired
	SqlSessionTemplate sqltemplate;

	// 게시판에 글 하나 올리기
	public void insertOne(Map map) {
		template.insert(map, "board");
	}
	
	// 다른 회원의 정보 Map 으로 뽑아오기
	public Map getOneUserInfo(String id) {
		return sqltemplate.selectOne("account.getOneUserInfo", id);
	}

	// 게시글 고유번호 생성
	public int getBoardNo() {
		return sqltemplate.selectOne("board.getBoardNo");
	}

	// 작성자 아이디로 글 찾기 (최신순으로 정렬)
	public List<Map> findWriter(String writer) {
		Criteria c = Criteria.where("writer").in(writer);
		List<Map> list = template.find(new Query(c), Map.class, "board");
		list.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				long n1 = (long) o1.get("time"); // time숫자가 클수록 최근
				long n2 = (long) o2.get("time");
				if (n1 > n2) {// 2번째>1번째
					return -1; // -1내림
				} else if (n1 < n2) {
					return 1; // 1오름
				} else {
					return 0;
				} 
			}
		}); 
		return list;
	}
	
	// 뉴스피드 글 정렬
	public List<Map> newsfeedSort(List list){
		list.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				long n1 = (long) o1.get("time"); // time숫자가 클수록 최근
				long n2 = (long) o2.get("time");
				if (n1 > n2) {// 2번째>1번째
					return -1; // -1내림
				} else if (n1 < n2) {
					return 1; // 1오름
				} else {
					return 0;
				} 
			}
		}); 
		return list;
	}
	
	// 팔로우한 사람들의 모든 글 목록 최신순으로 리스트에 담기 (뉴스피드)
	public  List<Map> getFollowBoardCnt(List list) {
		List<Map> allList = new ArrayList<>();
		for(int i=0; i<list.size();i++) {
			List<Map> oneList = findWriter((String)list.get(i));
			for(int k=0; k<oneList.size(); k++) {
				allList.add(oneList.get(k));
			}
		}
		allList.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				long n1 = (long) o1.get("time"); // time숫자가 클수록 최근
				long n2 = (long) o2.get("time");
				if (n1 > n2) {// 2번째>1번째
					return -1; // -1내림
				} else if (n1 < n2) {
					return 1; // 1오름
				} else {
					return 0;
				} 
			}
		}); 
		return allList;
	}

	// board 테이블에서 파라미터로 Liker 뽑아서 내가 좋아요 누른 글 목록 보기
	// 가장 최근에 좋아요 누른 글이 제일 먼저 나오게 정렬
	public List<Map> getBoardLiker(String liker) {
		Query query = new Query(Criteria.where("likerId").in(liker));
		List<Map> list = template.find(query, Map.class, "like");
		// 내가 좋아요 누른 최신순으로 정렬을 먼저 한 후
		list.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				long n1 = (long) o1.get("likedTime"); // time숫자가 클수록 최근
				long n2 = (long) o2.get("likedTime");
				if (n1 > n2) {// 2번째>1번째
					return -1; // -1내림
				} else if (n1 < n2) {
					return 1; // 1오름
				} else {
					return 0;
				}
			}
		});
		// 정렬한 리스트의 방 번호를 뽑아서 jsp 에 뿌려줄 리스트에 추가
		List<Map> getList = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			Double id1 = (Double) list.get(i).get("roomId");
			Criteria c = Criteria.where("_id").in(id1.intValue());
			getList.add(template.findOne(new Query(c), Map.class, "board"));
		}
		return getList;
	}

	// 글번호 + 좋아요 한사람 + 좋아요한 시간
	public void insertLikerAndTime(Map liked) {
		template.insert(liked, "like");
	}

	// 좋아요취소하면 삭제
	public void removeLikerAndTime(String likerId, int roomId) {
		Criteria c = new Criteria().andOperator(Criteria.where("likerId").in(likerId),
				Criteria.where("roomId").in(roomId));
		template.remove(new Query(c), Map.class, "like");
	}

	// board 테이블에서 파라미터로 Theme 뽑기 (최신순으로 정렬)
	public List<Map> getBoardTheme(String theme) {
		Query query = new Query(Criteria.where("interest").in(theme));
		List<Map> list = template.find(query, Map.class, "board");
		list.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				long n1 = (long) o1.get("time"); // time숫자가 클수록 최근
				long n2 = (long) o2.get("time");
				if (n1 > n2) {// 2번째>1번째
					return -1; // -1내림
				} else if (n1 < n2) {
					return 1; // 1오름
				} else {
					return 0;
				}
			}
		});
		return list;
	}
	
	public List<Map> gethashboard(String content){
		Regex reg =new Regex(content);
		return template.find(new Query(Criteria.where("hashcode").regex(content)), Map.class,"board");
	}
	
	public List<Map> getnohashboard(String content){
		return template.find(new Query(Criteria.where("hashcode").regex("#"+content)), Map.class,"board");
	}
}
