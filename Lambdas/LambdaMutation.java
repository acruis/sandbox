import java.util.stream.Collectors;
import java.util.List;
import java.util.Arrays;

public class LambdaMutation {
	public static void main(String[] args) {
		double denom = 10.0;
		DoubleHolder[] holders = {new DoubleHolder(0.0), new DoubleHolder(1.0), new DoubleHolder(2.0), new DoubleHolder(3.0)};
		List<DoubleHolder> holdersList = Arrays.asList(holders);

		// /= works.
		holdersList.forEach(holder -> holder.value /= denom);
		holdersList.forEach(holder -> System.out.println(holder.value));
	}
}

class DoubleHolder {
	public double value;

	public DoubleHolder(double value) {
		this.value = value;
	}
}