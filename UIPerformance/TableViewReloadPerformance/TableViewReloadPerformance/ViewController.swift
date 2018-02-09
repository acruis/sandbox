//
//  ViewController.swift
//  TableViewReloadPerformance
//
//  Created by Nguyen Quoc Dat on 29/1/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var values: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regenerateTable()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.regenerateTable()
        }
    }
    
    /*
     TLDR:
     - Very performant reloading
     - Scrolling pauses reloading until it's done - very nice!
     */
    func regenerateTable() {
        self.values = (0..<300).map { _ in generateRandomValue() }.sorted()
        self.tableView.reloadData()
    }
    
    func generateRandomValue() -> Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "reloadedCell", for: indexPath) as? ReloadedCell) ?? ReloadedCell()
        cell.setLabel(value: values[indexPath.row])
        return cell
    }
}

