//
//  SandboxCell.swift
//  TableViewSandbox
//
//  Created by Nguyen Quoc Dat on 25/10/19.
//  Copyright © 2019 acruis. All rights reserved.
//

import UIKit

class Sandbox2Cell: UITableViewCell {
    // Before iOS 6, you can only use frames to layout a view.
    // iOS 6 onwards, you get Auto Layout, but you can still use frames if you want.
    let myTextLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 100, height: 40))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(myTextLabel)
        self.backgroundColor = UIColor.blue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SandboxCell: UITableViewCell {

    private let coloredBox = makeColoredBox()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textLabel?.backgroundColor = .clear
        contentView.addSubview(coloredBox)
        contentView.sendSubviewToBack(coloredBox)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        coloredBox.frame = contentView.bounds.insetBy(dx: 4, dy: 4)
    }
}

// - MARK: Lazy initializers

extension SandboxCell {

    private static func makeColoredBox() -> UIView {
        let coloredBox: UIView = UIView(frame: .zero)
        coloredBox.backgroundColor = .green
        return coloredBox
    }

}
