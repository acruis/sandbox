import java.util.ArrayList;
import java.util.Arrays;

public class ModifyWhileIterating {
	public static void main(String[] args) {
		Integer[] a = {1, 2, 3, 4};
		ArrayList<Integer> b = new ArrayList<Integer>(Arrays.asList(a));
		int count = 0;
		for (int b_i : b) {
			b.add(b_i + 5); // java.util.ConcurrentModificationException
			System.out.println(b_i);
			if (b_i > 10) break;
		}
	}
}