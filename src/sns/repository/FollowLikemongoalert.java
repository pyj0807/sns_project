package sns.repository;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

@Repository
public class FollowLikemongoalert {

	@Autowired
	MongoTemplate template;

	public boolean Mongofollowservice(Map map) {
		try {
			Map rst = template.insert(map, "followLike");

			return rst != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<Map> mongofollowserviceall(String id) {
		return template.find(new Query(Criteria.where("receiver").in(id)), Map.class, "followLike");
	}

	public void updatemongofollowlike(String id) {
		Update u = new Update().set("pass", "off");
		template.updateMulti(new Query(Criteria.where("receiver").in(id)), u, "followLike");
	}

}
