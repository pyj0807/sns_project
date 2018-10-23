package sns.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JoinDao {
	
	@Autowired
	SqlSessionTemplate template;
	
	public String addJoin() {
		return template.selectOne("testjoin.addJoin");
	
		
	}
}
