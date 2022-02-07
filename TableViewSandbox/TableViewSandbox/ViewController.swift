//
//  ViewController.swift
//  UITableViewGrouped
//
//  Created by Nguyen Quoc Dat on 25/10/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var movieNames = [
        "The Shawshank Redemption (1994)",
        "The Godfather (1972)",
        "The Dark Knight (2008)",
        "The Godfather: Part II (1974)",
        "The Lord of the Rings: The Return of the King (2003)",
        "Pulp Fiction (1994)",
        "Schindler's List (1993)",
        "12 Angry Men (1957)",
        "Inception (2010)",
        "Fight Club (1999)",
    ]

    private var s1r1isBig: Bool = false

    private lazy var boopButton: UIButton = {
        let boopButton = UIButton(type: .system)
        boopButton.setTitle("Boop", for: .normal)


        boopButton.addTarget(self, action: #selector(didTapBoopButton), for: .touchUpInside)

        return boopButton
    }()

    private lazy var boop2Button: UIButton = {
        let boopButton = UIButton(type: .system)
        boopButton.setTitle("Boop 2", for: .normal)
        boopButton.addTarget(self, action: #selector(didTapBoop2Button), for: .touchUpInside)
        return boopButton
    }()

    let tableView: UITableView = UITableView(frame: CGRect(x: 30, y: 30, width: 150, height: 600),
                                             style: .grouped)
    let headerView: UIView = {
        let headerView = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        headerView.backgroundColor = .green
        headerView.text = "Table header view"
        return headerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightGray
        tableView.backgroundColor = UIColor.gray

        tableView.register(SandboxCell.self, forCellReuseIdentifier: "greenCell")
        tableView.register(Sandbox2Cell.self, forCellReuseIdentifier: "blueCell")
        tableView.clipsToBounds = false

        tableView.bounces = false

        tableView.sectionFooterHeight = 0 // (1)

        /*
         * IMPORTANT: Setting the tableHeaderView before the delegate has been set (as follows) will
         * result in an automatic 20px footer for the table that cannot be removed in any way.
         * This is specific to `UITableViewStyle.grouped`. Instead...
         */
        tableView.tableHeaderView = self.headerView

        tableView.dataSource = self
        tableView.delegate = self

        /*
         * ...set the header view here to avoid the forced 20px footer.
         *
         * Note setting `tableView.sectionFooterHeight = 0` doesn't help even if it's done BEFORE
         * setting the header view - as long as the header view is set before the delegate. So (1)
         * and (2) don't have any effect on the forced 20px footer.
         *
         * Re-setting the header view after setting the delegate, as in the next line, doesn't help
         * either.
         */
        tableView.tableHeaderView = self.headerView

        tableView.sectionFooterHeight = 0 // (2)

        self.view.addSubview(tableView)

        boopButton.frame = CGRect(x: 210, y: 30, width: 150, height: 30)
        self.view.addSubview(boopButton)

        boop2Button.frame = CGRect(x: 210, y: 90, width: 150, height: 30)
        view.addSubview(boop2Button)
    }

    @objc func didTapBoopButton() {
//        s1r1isBig.toggle()
        triggerHeightChangeAnimation()
//        triggerScrollAnimation()
    }

    @objc func didTapBoop2Button() {
//        tableView.reloadData()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2.0) { [weak self] in
            self?.triggerHeightChangeAnimation()
        }
    }

    @objc private func triggerHeightChangeAnimation() {
        s1r1isBig.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    private func triggerScrollAnimation() {
        let fiftyDown = CGPoint(x: tableView.contentOffset.x, y: tableView.contentOffset.y + 50)
        tableView.setContentOffset(fiftyDown, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 10 : 5
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = indexPath.row % 2 == 0 ? "blueCell" : "greenCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if indexPath.row % 2 == 0 {
            let blueCell = cell as! Sandbox2Cell
            blueCell.myTextLabel.text = "Haha"
        }
        cell.textLabel?.text = "\(indexPath.section).\(movieNames[indexPath.row])"
        cell.backgroundColor = .white
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    /*
     * If both methods
     *  - titleForFooterInSection
     *  - viewForFooterInSection
     * are not implemented, all sections are forced to have 17.33px footers, as well as a forced
     * additional 20px on the bottom of the table for an empty bottom space of 37.33px at the bottom
     * of the table view.
     */

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header title" // No effect given `heightForHeaderInSection` is implemented.
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Footer title" // No effect given `heightForFooterInSection` is implemented.
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Height of `headerLabel` is forced to 30 due to `heightForHeaderInSection`.
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
        headerLabel.text = "Section \(section)"
        headerLabel.backgroundColor = .yellow
        return headerLabel
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Have to implement this for `heightForFooterInSection` to take effect.
        return nil
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 || indexPath.row != 1 {
            return 44
        }

        return s1r1isBig ? 84 : 44
    }

    // MARK: UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(#function + "\(scrollView.contentOffset.y)" + " \(maxTableViewContentOffset)" + " \(tableView.contentSize.height)")
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print(#function + "\(scrollView.contentOffset.y)" + "\(maxTableViewContentOffset)")
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(#function + "\(scrollView.contentOffset.y)" + "\(maxTableViewContentOffset)")
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print(#function + "\(scrollView.contentOffset.y)" + "\(maxTableViewContentOffset)")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(#function + "\(scrollView.contentOffset.y)" + "\(maxTableViewContentOffset)")
    }

    private var maxTableViewContentOffset: CGFloat {
        return max(0, tableView.contentSize.height - (tableViewHeight - tableView.contentInset.top - tableView.contentInset.bottom))
    }

    private var tableViewHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return tableView.frame.inset(by: tableView.safeAreaInsets).height
        } else {
            return tableView.bounds.height
        }
    }
}
