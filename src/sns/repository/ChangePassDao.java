package sns.repository;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChangePassDao {
	
	@Autowired
	SqlSessionTemplate template;
	
	public int changePass(Map map) {
		return template.update("account.changePass");
	}
}
