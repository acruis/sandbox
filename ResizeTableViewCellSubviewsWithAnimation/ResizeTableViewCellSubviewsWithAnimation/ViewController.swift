//
//  ViewController.swift
//  UITableViewGrouped
//
//  Created by Nguyen Quoc Dat on 25/10/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var s1r2isBig: Bool = false

    private lazy var boopButton: UIButton = {
        let boopButton = UIButton(type: .system)
        boopButton.setTitle("Boop", for: .normal)
        boopButton.addTarget(self, action: #selector(didTapBoopButton), for: .touchUpInside)
        return boopButton
    }()

    let tableView: UITableView = UITableView(frame: CGRect(x: 30, y: 30, width: 150, height: 600),
                                             style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightGray
        tableView.backgroundColor = UIColor.gray

        tableView.register(SandboxCell.self, forCellReuseIdentifier: "cell")

        tableView.dataSource = self
        tableView.delegate = self

        self.view.addSubview(tableView)

        boopButton.frame = CGRect(x: 210, y: 30, width: 150, height: 30)
        self.view.addSubview(boopButton)
    }

    @objc func didTapBoopButton() {
        guard let s1r2Cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? SandboxCell else {
            fatalError("Should be SandboxCell")
        }
        s1r2isBig.toggle()
        s1r2Cell.isBig = s1r2isBig
        triggerHeightChangeAnimation()
    }

    private func triggerHeightChangeAnimation() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section).\(indexPath.row)"
        cell.backgroundColor = .white

        if let sandboxCell = cell as? SandboxCell {
            sandboxCell.canGrow = indexPath.section == 0 && indexPath.row == 1
        }

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 || indexPath.row != 1 {
            return 44
        }

        return s1r2isBig ? 84 : 44
    }
}
