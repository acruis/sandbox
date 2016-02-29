import java.util.concurrent.Semaphore;

public class Sandbox {

	public static final Semaphore available = new Semaphore(1, true);

	public static void main(String[] args) {

		try {
			Runnable one = () -> acquireWaitReleaseWait("One");
			Runnable two = () -> justAcquire("Two");
			Runnable three = () -> justAcquire("Three");
			Thread tOne = new Thread(one);
			Thread tTwo = new Thread(two);
			Thread tThree = new Thread(three);
			tOne.start();
			Thread.sleep(500);
			tTwo.start();
			tThree.start();
		} catch (Exception e) {
			// Do nothing
		}
	}

	public static void acquireWaitReleaseWait(String boop) {
		try {
			System.out.println("Acquiring" + boop);
			available.acquire();
			System.out.println("Waiting" + boop);
			Thread.sleep(2000);
			System.out.println("Released" + boop);
			available.release();
			// acquired by one of the other two processes here, and
			// run concurrently
			System.out.println("Waiting again" + boop);
			Thread.sleep(2000);
			System.out.println("Done waiting" + boop);
		} catch (Exception e) {
			// Do nothing
		}
	}

	public static void justAcquire(String boop) {
		try {
			System.out.println("Acquiring" + boop);
			available.acquire();
			System.out.println("Acquired" + boop);
			available.release(); // So that the other thread can unblock
		} catch (Exception e) {
			// Do nothing
		}
	}
}