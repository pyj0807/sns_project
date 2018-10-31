
import java.util.*;


class Sorter implements Comparator<String> {
	
	public int compare(String a,String b) {//���Ľ����� ������ü
		//a-b�� ����� ���Ͻ�Ű�� ��.
		int s1=0 ,s2 = 0;
		for(int i =0 ; i<a.length();i++) {
			s1 +=a.charAt(i);
		}
		for(int i= 0; i<a.length(); i++) {
			s2+=b.charAt(i);
		}
		return a.charAt(1)-b.charAt(1);
	}
	
	
	
	
	
}


public class Source08_List {

	public static void main(String[] args) {
		
		
		List<String> li = new LinkedList<String>();
		
			li.add("나미");
			li.add("조로");
			li.add("상디");
			li.add("꺄르르");
			
			li.add("호루");
			li.add("호두");
			Sorter sr = new Sorter();
			li.sort(sr);//sort : ���Ľ�Ű�¸޼���
			
			
			
			
			for(Iterator<String> i = li.iterator(); i.hasNext();) {
				String n= i.next();
				System.out.println("=> "+ n);
			}
			//ListIterator��°� ������.
			ListIterator<String> ii =li.listIterator(1);//�Ǿտ�ҿ� Ŀ��������
			
			System.out.println(ii.hasNext());
			System.out.println(ii.hasPrevious());//
			
			for(ListIterator<String> i = li.listIterator(li.size()); i.hasPrevious();) {
				String n =i.previous();
				System.out.println(" => " + n);
			}
			//List�� �÷��ǿ� ���ؼ���
			
			for(int i= 0; i<li.size(); i++) {
				String s =li.get(i);
				System.out.println("=>" + s);
			}
		
			// sort�� ������. - ������ �ִ� ��ü���� ������ ����.
			// ���ı����� ��������� �Ѵ�. - �� �� ���Ǵ°� Comparator��� implements.
			
			/*
			 * 	�� List�� �÷��ǿ��� contains, indexOf�� ���ɶ� ���� ��ü���� �ƴϴ���,
			 * 		equals�� true�߸� ���ٰ� �Ǵ���.(hashCode�� ������ ����)
			 * 
			 * 	���Ϲ������� 3������ ���� ���ȴٰ� ����ߴµ�,
			 * 		ArrayList(��Vector) : �迭 �����.
			 * 		LinkedList :�迭�� �ƴ϶� �������.
			 * 
			 * 		�������� ���� �Ͼ�� �����͸� �����ؾߵɶ��� LinkedList�� ȿ���� ����,
			 * 		������ ������ �Ͼ�� �ʰ�, add,get�� �Ҳ��� ArrayList�� ȿ���� ����.
			 */
			
			
			
		
		
		
		
		
		

	}

}
