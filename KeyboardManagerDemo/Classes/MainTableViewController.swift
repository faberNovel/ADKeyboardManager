//
//  MainTableViewController.swift
//  KeyboardManagerDemo
//
//  Created by Edouard Siegel on 25/04/2019.
//

import UIKit
import ADUtils

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
        tableView.register(cell: .class(UITableViewCell.self))
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueCell(at: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "TableView"
        case 1:
            cell.textLabel?.text = "CollectionView"
        case 2:
            cell.textLabel?.text = "ScrollView"
        case 3:
            cell.textLabel?.text = "Obj-C TableView"
        default:
            break
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let demoTableViewController = DemoTableViewController()
            navigationController?.pushViewController(demoTableViewController, animated: true)
        case 1:
            let demoCollectionViewController = DemoCollectionViewController()
            navigationController?.pushViewController(demoCollectionViewController, animated: true)
        case 2:
            let demoScrollViewController = DemoScrollViewController()
            navigationController?.pushViewController(demoScrollViewController, animated: true)
        case 3:
            let demoObjcTableViewController = DemoObjcTableViewController()
            navigationController?.pushViewController(demoObjcTableViewController, animated: true)
        default:
            break
        }
    }
}
