/*package models;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.Gson;


@Service
public class AlertService {
	@Autowired
	Gson gson;
	
	
	
	List<WebSocketSession> list;
	
	public AlertService() {
		list=new ArrayList<WebSocketSession>();
	}
	public int size() {
		return list.size();
	}
	
	public boolean addSocket(WebSocketSession target) {
		return list.add(target);
	}
	
	public boolean removeSocket(WebSocketSession target) {
		return list.remove(target);
		
	}
	
	public void sendAll(String txt) {
		TextMessage msg = new TextMessage(txt);
		for(int i=0;i<list.size();i++) {
			try {
				list.get(i).sendMessage(msg);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	
	public void sendAll(Map map) {
		sendAll(gson.toJson(map));
	}
	
	
	
	
	
}*/
package sns.repository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.Gson;


@Service
public class AlertService {
	public List<WebSocketSession> list;
	
	@Autowired
	Gson gson;
	
	
	public AlertService() {
		list = new ArrayList<>();
		
	}
	
	public int size() {
		return list.size();
	}
	
	public boolean addSocket(WebSocketSession target) {
		return list.add(target);
	}

	public boolean removeSocket(WebSocketSession target) {
		return list.remove(target);
	}
	
	public void sendAll(String txt) {
		TextMessage msg = new TextMessage(txt);
		for(int i=0; i<list.size(); i++) {
			try {
				list.get(i).sendMessage(msg);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	public void sendOne(String txt,String target) {
		TextMessage msg = new TextMessage(txt);
		for(int i=0; i<list.size(); i++) {
			WebSocketSession ws=list.get(i);
			String userId =(String)ws.getAttributes().get("userId");
			if(userId.equals(target)) {
				try {
					ws.sendMessage(msg);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		
		}
	}
	
	public void sendSome(String txt,String... target) {
		TextMessage msg = new TextMessage(txt);
		for(int i=0; i<list.size(); i++) {
			WebSocketSession ws=list.get(i);
			String userId =(String)ws.getAttributes().get("userId");
			
			for(int ii=0;ii<target.length;ii++) {
			if(userId.equals(target)) {
				try {
					ws.sendMessage(msg);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		
		}
		}
	}
	
	
	
	
	
	public void sendAll(Map map) {
		sendAll(gson.toJson(map));
	}
	public void sendOne(Map map,String target) {
		sendOne(gson.toJson(map),target);
	}
	
	
	public void sendSome(Map map,String...target) {
		sendSome(gson.toJson(map),target);
	}
	
	
}


