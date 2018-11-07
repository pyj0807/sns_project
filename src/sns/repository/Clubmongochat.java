package sns.repository;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

@Repository
public class Clubmongochat {
	@Autowired
	MongoTemplate template;

	public boolean createroom(Map map) {
		try {
			Map rst = template.insert(map, "clubroom");
			return rst != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}

	public List<Map> getAllopenChat() {
		return template.find(new Query(), Map.class, "clubroom");
	}

	public List<Map> getopenchat(String id, String content) {

		return template.find(new Query(Criteria.where("agency").in(id).and("_id").in(content)), Map.class, "clubroom");

	}

	public boolean clubchatinsert(Map map) {
		try {
			Map rst = template.insert(map, "clubchat");
			return rst != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public void clubagency(String content, String id) {
		Update u = new Update().push("agency", id);
		template.updateMulti(new Query(Criteria.where("_id").in(content)), u, "clubroom");

	}

	public List<Map> getagencyChat(String content, String id) {
		return template.find(new Query(Criteria.where("_id").in(content).andOperator(Criteria.where("agency").in(id))),
				Map.class, "clubroom");
	}

	public List<Map> getaAencyAllclub(String id) {
		return template.find(new Query(Criteria.where("agency").in(id)), Map.class, "clubroom");
	}

	public List<Map> getAllclub(String content) {
		return template.find(new Query(Criteria.where("_id").in(content)), Map.class, "clubroom");
	}

	public List<Map> clubchatingview(String contentid) {

		return template.find(new Query(Criteria.where("contentid").in(contentid)), Map.class, "clubchat");
	}

	public List<Map> clubbest(String id, String content) {

		return template.find(new Query(Criteria.where("mainid").in(id).andOperator(Criteria.where("_id").in(content))),
				Map.class, "clubroom");
	}

	public List<Map> clubmyall(String id) { // 자기가 가입한 오픈채팅방
		return template.find(new Query(Criteria.where("agency").in(id)), Map.class, "clubroom");

	}

}
