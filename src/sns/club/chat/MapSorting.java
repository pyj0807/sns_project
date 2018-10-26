package sns.club.chat;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MapSorting {
	static Map sample() {
		Map map = new HashMap<>();
		map.put("no", (int)(Math.random() * 1000));
		map.put("writer",(int)(Math.random() * 1000)+"zz" );
		return map;
	}

	public static void main(String[] args) {
		List<Map> list = new ArrayList<>();
		for(int cnt=1; cnt<=15; cnt++) {
			list.add(sample());
		}
		System.out.println(list);
				
		
		list.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				int n1= (int)o1.get("no");
				int n2= (int)o2.get("no");
				
				if(n1>n2) {
					return 1;
				}else if(n1<n2) {
					return -1;
				}else {
					return 0;
				}
			}
		});
		
		System.out.println(list);
	}
}
