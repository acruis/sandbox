public class SleepingBarber {
	public static int cust = 0;
	public static final int maxSeats = 3;
	public static Object custs = new Object();
	public static Object barberM = new Object();

	public static void main(String[] args) {
		try {
			Runnable one = () -> hairCut("One");
			Runnable two = () -> hairCut("Two");
			Runnable three = () -> hairCut("Three");
			Runnable four = () -> hairCut("Four");
			Runnable five = () -> hairCut("Five");
			Runnable barber = () -> runBarber();

			Thread tOne = new Thread(one);
			Thread tTwo = new Thread(two);
			Thread tThree = new Thread(three);
			Thread tFour = new Thread(four);
			Thread tFive = new Thread(five);
			Thread tBarber = new Thread(barber);

			tBarber.start();
			Thread.sleep(2000);
			tOne.start();
			Thread.sleep(1000);
			tTwo.start();
			tThree.start();
			tFour.start();
			tFive.start();
		} catch (Exception e) {
			System.out.println("Error!");
		}
	}

	public static void runBarber() {
		try {
			synchronized(barberM) {
				if (cust == 0) {
					System.out.println("Sleeping...");
					barberM.wait();
				}
				cust--;
			}
			synchronized(custs) {
				custs.notify(); // Notifies a customer!
			}
			System.out.println("Cutting hair!");
			Thread.sleep(3000);
			runBarber();
		} catch (Exception e) {
			System.out.println("In barber." + e);
		}
	}

	public static void hairCut(String bloop) {
		try {
			synchronized(barberM) {
				if (cust < maxSeats) {
					cust++;
					barberM.notify();
				} else {
					System.out.println("Bye bye" + bloop);
					return;
				}
			}
			synchronized(custs) {
				System.out.println("Waiting..." + bloop);
				custs.wait();
				System.out.println("Getting haircut!" + bloop);
			}
		} catch (Exception e) {
			System.out.println("In haircut." + e);
		}
	}
}