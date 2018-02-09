//
//  ReloadedCell.swift
//  TableViewReloadPerformance
//
//  Created by Nguyen Quoc Dat on 29/1/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class ReloadedCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    
    func setLabel(value: Double) {
        contentLabel.text = String(value)
    }
}
