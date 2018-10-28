package sns.repository;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;


@Repository
public class ClubChatMongoDeleteRepository {
	
	@Autowired
	MongoTemplate template;
	
	
	
public void roomremove(String content,String id){
		

	
	
		template.remove(new Query(Criteria.where("_id").in(content).andOperator(Criteria.where("mainid").in(id))),"clubroom");
		
		
	}

}
