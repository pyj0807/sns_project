package sns.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FollowRepository {
	@Autowired
	SqlSessionTemplate sqltemplate;
	
	public int insertFollowing(Map map) {
		  int r =sqltemplate.insert("follow.insertFollowing", map);
		  if(r ==1) {
			  return sqltemplate.insert("follow.insertFollowing", map);
		  }
		return -1;
	}
		
	public int insertFollower(Map map) {
		int r=sqltemplate.insert("follow.insertFollower", map);
			if(r==1) {
				return sqltemplate.insert("follow.insertFollower", map);
			}else {
				
				return -1;
			}
	}
	
	public List<String> getFollowingList(String id){
		return sqltemplate.selectList("follow.getFollowingList", id);
	}
	
	public List<String> getFollowerList(String id){
		return sqltemplate.selectList("follow.getFollowerList", id);
	}
	
	public int getFollowingCnt(String id) {
		return sqltemplate.selectOne("follow.getFollowingCnt");
	}
	
	public int getFollowerCnt(String id) {
		return sqltemplate.selectOne("follow.getFollowerCnt");
	}
	
	public int delFollowing(String id) {
		return sqltemplate.delete("follow.delFollowing", id);
	}
	
	public int delFollower(String id) {
		return sqltemplate.delete("follow.delFollower", id);
	}
	
	
}
