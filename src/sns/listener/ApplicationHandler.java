package sns.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class ApplicationHandler implements ServletContextListener{
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		//서버실행시 작동
		ServletContext svc = sce.getServletContext();
		svc.setRequestCharacterEncoding("UTF-8");
		System.out.println("SNS Project server start!");
	}
}
