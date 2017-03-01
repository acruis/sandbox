import java.lang.Math;

public class FloatingPoint {
	public static void main(String[] args) {
		double a = Math.pow(2.0, 54);
		double b = 2;
		double c = -1;
		double d = -Math.pow(2.0, 54);
		System.out.println(((a+b)+c)+d);
		System.out.println(((a+b)+d)+c);
		System.out.println(((a+c)+b)+d);
		System.out.println(((a+c)+d)+b);
		System.out.println(((a+d)+b)+c);
		System.out.println(((a+d)+c)+b);
		System.out.println(((b+c)+a)+d);
		System.out.println(((b+c)+d)+a);
		System.out.println(((b+d)+a)+c);
		System.out.println(((b+d)+c)+a);
		System.out.println(((c+d)+a)+b);
		System.out.println(((c+d)+b)+a);
		System.out.println((a+b)+(c+d));
		System.out.println((a+c)+(b+d));
		System.out.println((a+d)+(b+c));
		System.out.println("---");
		System.out.println("((a+b)+d)+c = " + (((a+b)+d)+c));
		System.out.println("a+b = " + (a+b));
		System.out.println("(a+b)+d = " + ((a+b)+d));
	}
}