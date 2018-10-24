package sns.repository;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Repository
public class JoinDao {
	
	@Autowired
	SqlSessionTemplate template;
	
	
	public int addAccount(Map map) {
		return template.insert("account.addAccount",map);
	}
}
