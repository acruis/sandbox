/*
 Legend:
 
 P: occurs on private thread
 M: occurs on main thread
 PAW: private context calls performAndWait (blocks caller's thread until the block finishes executing in the private queue)
 MAW: main context calls performAndWait (blocks caller's thread until the block finishes executing in the main queue)
 */

import CoreData

let mC = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
let pC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

/*
 P -> PAW -> MAW
 M -> PAW
 
 Locks at (2) and (3)
 */
func deadlockStyle1() {
    print("0")
    pC.perform {
        print("1")
        pC.performAndWait {
            print("2")
            mC.performAndWait {
                print("Deep inside") // Never called
            }
        }
    }
    print("3")
    pC.performAndWait {
        print("4") // Never called
    }
}

/*
 P -> MAW
 M -> PAW
 
 Locks at (1) and (2)
 */
func deadlockStyle2() {
    print("0")
    pC.perform {
        print("1")
        mC.performAndWait {
            print("Deep inside") // Never called
        }
    }
    print("2")
    pC.performAndWait {
        print("3") // Never called
    }
}
