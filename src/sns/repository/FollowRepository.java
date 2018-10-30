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

	public int insertFollowing(Map map) {
		return sqltemplate.insert("follow.insertFollowing", map);
	}

	public int insertFollower(Map map) {
		return sqltemplate.insert("follow.insertFollower", map);
	}

	public List<String> getFollowingList(String id) {
		return sqltemplate.selectList("follow.getFollowingList", id);
	}

	public List<String> getFollowerList(String id) {
		return sqltemplate.selectList("follow.getFollowerList", id);
	}

	public int getFollowingCnt(String id) {
		return sqltemplate.selectOne("follow.getFollowingCnt", id);
	}

	public int getFollowerCnt(String id) {
		return sqltemplate.selectOne("follow.getFollowerCnt", id);
	}

	public int delFollowing(Map map) {
		return sqltemplate.delete("follow.delFollowing", map);
	}

	public int delFollower(Map map) {
		return sqltemplate.delete("follow.delFollower", map);
	}

	public Map CheckFollowing(Map map) {
		return sqltemplate.selectOne("follow.CheckFollowing", map);
	}
	
	public List<Map> getAllUserInfo(){
		return sqltemplate.selectList("account.getAllUserInfo");
	}
	

	

}
