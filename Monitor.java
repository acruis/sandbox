import java.util.ArrayList;
import java.util.List;

public class Monitor {

	public static List<String> synchedList = new ArrayList<>();

	public static void main(String[] args) {
		/*try {
			Runnable one = () -> enterMonitorAndWait("One");
			Runnable two = () -> enterMonitorAndWait("Two");
			Thread tOne = new Thread(one);
			Thread tTwo = new Thread(two);
			Thread tThree = new Thread(two);
			tOne.start();
			Thread.sleep(500);
			tTwo.start();
			tThree.start();
		} catch (Exception e) {
			// Do nothing
		}*/

		try {
			Runnable one = () -> enterSynchedListAndWait("One");
			Runnable two = () -> enterSynchedListAndWait("Two");
			Runnable lift = () -> liftSynchedList("Lift");
			Thread tOne = new Thread(one);
			Thread tTwo = new Thread(two);
			Thread tLift = new Thread(lift);
			//Thread tThree = new Thread(two);
			tOne.start();
			tTwo.start();
			Thread.sleep(500);
			tLift.start();
			//tTwo.start();
			//tThree.start();
		} catch (Exception e) {
			// Do nothing
		}
	}

	public static synchronized void enterMonitorAndWait(String boop) {
		try {
			System.out.println(boop);
			Thread.sleep(2000);
			System.out.println("done" + boop);
		} catch (Exception e) {
			// Do nothing
		}
	}

	public static void enterSynchedListAndWait(String boop) {
		synchronized(synchedList) {
			try {
				System.out.println("beginning wait on " + boop);
				synchedList.wait();
				System.out.println(boop);
				Thread.sleep(2000);
			} catch (Exception e) {
				// Do nothing.
			}
			System.out.println("done" + boop);
		}
	}

	public static void liftSynchedList(String boop) {
		synchronized(synchedList) {
			try {
				synchedList.notifyAll(); // One and Two will follow
				// synchedList.notify(); // Only either One or Two will follow
				System.out.println("Just notified" + boop);
				Thread.sleep(2000);
				System.out.println("Notified after 2s" + boop);
			} catch (Exception e) {
				// Do nothing.
			}
		}
	}
}