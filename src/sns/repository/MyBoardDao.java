package sns.repository;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MyBoardDao {
	@Autowired
	MongoTemplate template;
	
	//내가가지고있는 board
	public List<Map> Myboard(){
		List<Map> list = template.findAll(Map.class,"board");
		return list;
	}
	
}
