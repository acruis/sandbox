//
//  ViewController.swift
//  StackViewSandbox
//
//  Created by Nguyen Quoc Dat on 25/10/19.
//  Copyright © 2019 acruis. All rights reserved.
//

import UIKit

private let colors: [UIColor] = [.green, .red, .blue, .yellow, .purple, .magenta, .cyan]
private let boxCount = 8

class ViewController: UIViewController {

    private let stackView: UIStackView = makeStackView()
    private lazy var toggleMidButton: UIButton = {
        let toggleMidButton = UIButton(type: .system)
        toggleMidButton.setTitle("Toggle Mid", for: .normal)
        toggleMidButton.addTarget(self, action: #selector(didTapToggleMidButton), for: .touchUpInside)
        return toggleMidButton
    }()

    private lazy var toggleTopButton: UIButton = {
        let toggleTopButton = UIButton(type: .system)
        toggleTopButton.setTitle("Toggle Top", for: .normal)
        toggleTopButton.addTarget(self, action: #selector(didTapToggleTopButton), for: .touchUpInside)
        return toggleTopButton
    }()

    private lazy var toggleBottomButton: UIButton = {
        let toggleBottomButton = UIButton(type: .system)
        toggleBottomButton.setTitle("Toggle Bottom", for: .normal)
        toggleBottomButton.addTarget(self, action: #selector(didTapToggleBottomButton), for: .touchUpInside)
        return toggleBottomButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        // - stackView
        view.addSubview(stackView)
        // Top
        NSLayoutConstraint(item: stackView, attribute: .topMargin, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 100).isActive = true
        // Left
        NSLayoutConstraint(item: stackView, attribute: .leadingMargin, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 100).isActive = true

        // - buttons
        toggleMidButton.frame = CGRect(x: 210, y: 30, width: 150, height: 30)
        view.addSubview(toggleMidButton)
        toggleTopButton.frame = CGRect(x: 210, y: 70, width: 150, height: 30)
        view.addSubview(toggleTopButton)
        toggleBottomButton.frame = CGRect(x: 210, y: 110, width: 150, height: 30)
        view.addSubview(toggleBottomButton)
    }

}

// - MARK: Actions

extension ViewController {
    @objc func didTapToggleMidButton() {
        let viewToToggleIndex = Int.random(in: 1...(boxCount - 1))
        UIView.animate(withDuration: 0.5) { [unowned stackView] in
            stackView.arrangedSubviews[viewToToggleIndex].isHidden.toggle()
        }
    }

    @objc func didTapToggleTopButton() {
        UIView.animate(withDuration: 0.5) { [unowned stackView] in
            stackView.arrangedSubviews[0].isHidden.toggle()
        }
    }

    @objc func didTapToggleBottomButton() {
        UIView.animate(withDuration: 0.5) { [unowned stackView] in
            stackView.arrangedSubviews[boxCount].isHidden.toggle()
        }
    }
}

// - MARK: Bakers

extension ViewController {

    private static func makeStackView() -> UIStackView {
        let boxes = (0...boxCount).map { _ in makeColoredBox() }
        let stackView: UIStackView = UIStackView(arrangedSubviews: boxes)
        stackView.addBorder()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false // Necessary to get rid of UIView-Encapsulated-Layout-X constraints on the stackview
        return stackView
    }

    private static func makeColoredBox() -> UIView {
        let coloredBox = UIView(frame: .zero)
        coloredBox.backgroundColor = colors.randomElement()
        // Width
        let widthConstraint = NSLayoutConstraint(item: coloredBox, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        widthConstraint.isActive = true
        // Height
        let heightConstraint = NSLayoutConstraint(item: coloredBox, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45)
        heightConstraint.priority = .required - 1 // Allows top and bottom cells to animate properly!
        heightConstraint.isActive = true
        return coloredBox
    }

}

// Border

extension UIStackView {
    func addBorder() {
        let borderView = UIView(frame: .zero)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.black.cgColor
        addSubview(borderView)

        NSLayoutConstraint(item: borderView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: borderView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: borderView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: borderView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
    }
}

