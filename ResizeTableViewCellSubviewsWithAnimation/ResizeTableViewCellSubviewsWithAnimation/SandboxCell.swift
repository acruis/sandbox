//
//  SandboxCell.swift
//  TableViewSandbox
//
//  Created by Nguyen Quoc Dat on 25/10/19.
//  Copyright © 2019 acruis. All rights reserved.
//

import UIKit

class SandboxCell: UITableViewCell {

    private let bubble = makeBubble()
    var isBig: Bool = false
    var canGrow: Bool = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textLabel?.backgroundColor = .clear
        addSubview(bubble)
        sendSubviewToBack(bubble)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let targetFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: isBig ? 84 : 44)
//        bubble.frame = bounds // (1) Right
        bubble.frame = targetFrame // (2) Wrong

        if canGrow {
            print("bounds:\(bounds) targetFrame:\(targetFrame)")
        }
    }
}

// - MARK: Lazy initializers

extension SandboxCell {

    private static func makeBubble() -> UIView {
        let bubble: UIView = UIView(frame: .zero)
        bubble.backgroundColor = UIColor(red: 0.3375, green: 0.7372, blue: 0.6510, alpha: 1)
        bubble.layer.cornerRadius = 15
        return bubble
    }

}
