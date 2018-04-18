//
//  ViewController.swift
//  ResizableTableViewCell
//
//  Created by Nguyen Quoc Dat on 19/3/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let texts = ["One", "Two", "Three", "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Setting contentInset instantly causes the table bounds to shift
        self.tableView.contentInset = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ResizableCell? = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? ResizableCell
        if cell == nil {
            cell = ResizableCell()
        }
        cell!.aLabel.text = texts[indexPath.row]
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

class ResizableCell: UITableViewCell {
    @IBOutlet weak var aLabel: UILabel!
}
