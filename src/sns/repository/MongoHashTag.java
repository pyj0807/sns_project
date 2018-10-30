package sns.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.VariableOperators.Map;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;


@Repository
public class MongoHashTag {
	@Autowired
	MongoTemplate template;
	
	public List<Map> allhashtag(){
		return template.find(new Query(),Map.class,"board");
	}

}
