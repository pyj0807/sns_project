package sns.repository;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.google.gson.Gson;

@Repository
public class FollowRepository {
	@Autowired
	SqlSessionTemplate sqltemplate;

	// 팔로잉 테이블에 추가
	public int insertFollowing(Map map) {
		return sqltemplate.insert("follow.insertFollowing", map);
	}

	// 팔로워 테이블에 추가
	public int insertFollower(Map map) {
		return sqltemplate.insert("follow.insertFollower", map);
	}

	// 한 사람의 팔로잉 리스트 가져오기
	public List<String> getFollowingList(String id) {
		return sqltemplate.selectList("follow.getFollowingList", id);
	}

	// 한 사람의 팔로워 리스트 가져오기
	public List<String> getFollowerList(String id) {
		return sqltemplate.selectList("follow.getFollowerList", id);
	}

	// 한 사람의 팔로잉 수 가져오기 
	public int getFollowingCnt(String id) {
		return sqltemplate.selectOne("follow.getFollowingCnt", id);
	}

	// 한 사람의 팔로워 수 가져오기 
	public int getFollowerCnt(String id) {
		return sqltemplate.selectOne("follow.getFollowerCnt", id);
	}

	// 팔로잉 취소 했을때 삭제하기
	public int delFollowing(Map map) {
		return sqltemplate.delete("follow.delFollowing", map);
	}

	// 팔로워 삭제하기, 위 식과 함께함
	public int delFollower(Map map) {
		return sqltemplate.delete("follow.delFollower", map);
	}

	// 이사람이 내가 팔로우 한 사람인지 체크하는 식
	public Map CheckFollowing(Map map) {
		return sqltemplate.selectOne("follow.CheckFollowing", map);
	}
	
	// 모든 유저 정보 Map 형으로 뽑아오기
	public List<Map> getAllUserInfo(){
		return sqltemplate.selectList("account.getAllUserInfo");
	}

	// 프로필 사진 업데이트
	public int changePic(Map map){
		return sqltemplate.update("account.changePic", map);
	}
	
	

}