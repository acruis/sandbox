//
//  ViewController.swift
//  ConcurrentQueues
//
//  Created by Nguyen Quoc Dat on 23/7/21.
//

import UIKit

class ViewController: UIViewController {

    private let serialQueue = DispatchQueue(label: "acruis.serial.queue")
    private let concurrentQueue = DispatchQueue(label: "acruis.parallel.queue", attributes: .concurrent)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        testSerialQueue()
        testConcurrentQueue()
    }

    func testSerialQueue() {
        print("Start \(Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 1000))")

        serialQueue.async {
            print("Task 1 Start \(Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 1000))")
            Thread.sleep(forTimeInterval: 3)
            print("Task 1 Done \(Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 1000))")
        }

        serialQueue.async {
            print("Task 2 Start \(Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 1000))")
            Thread.sleep(forTimeInterval: 1)
            print("Task 2 Done \(Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 1000))")
        }

        /*
         Start 774.1267528533936
         Task 1 Start 774.1275479793549
         Task 1 Done 777.1318969726562
         Task 2 Start 777.1319799423218
         Task 2 Done 778.1344151496887
         */
    }

    func testConcurrentQueue() {
        print("Start \(Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 1000))")

        concurrentQueue.async {
            print("Task 1 Start \(Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 1000))")
            Thread.sleep(forTimeInterval: 3)
            print("Task 1 Done \(Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 1000))")
        }

        concurrentQueue.async {
            print("Task 2 Start \(Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 1000))")
            Thread.sleep(forTimeInterval: 1)
            print("Task 2 Done \(Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 1000))")
        }

        /*
         Start 833.1631729602814
         Task 1 Start 833.1633520126343
         Task 2 Start 833.1633830070496
         Task 2 Done 834.1683809757233
         Task 1 Done 836.16459608078
         */
    }

}

