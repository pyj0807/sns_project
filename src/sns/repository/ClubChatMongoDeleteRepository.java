package sns.repository;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.CriteriaDefinition;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

@Repository
public class ClubChatMongoDeleteRepository {

	@Autowired
	MongoTemplate template;

	public void roomremove(String content, String id) { // 클럽방 없애기

		template.remove(new Query(Criteria.where("_id").in(content).andOperator(Criteria.where("mainid").in(id))),
				"clubroom");

	}

	public void roomchatremove(String content) { // 채팅없애기
		template.remove(new Query(Criteria.where("contentid").in(content)), "clubchat");
	}

	public Map rommmainid(String content) { // 방장 이름 뽑기
		return template.findOne(new Query(Criteria.where("_id").in(content)), Map.class, "clubroom");
	}

	public void removeid(String content, String id) { // 방 탈퇴
		Update u = new Update().pull("agency", id);
		template.updateFirst(new Query(Criteria.where("_id").in(content)), u, "clubroom");
	}

}
