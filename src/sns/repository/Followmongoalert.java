package sns.repository;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class Followmongoalert {

	@Autowired
	MongoTemplate template;
	
	public boolean Mongofollowservice(Map map){
		try {
		Map rst =template.insert(map,"follow");
		
		return rst!=null;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	
}
