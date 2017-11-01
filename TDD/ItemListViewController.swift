//
//  ItemListViewController.swift
//  TDD
//
//  Created by Kan Chen on 7/6/16.
//  Copyright © 2016 drchrono. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import DRCKit
import DRCSelectionKit

class ItemListViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self

        let drButton = DRCButtonBlue()
        let selectionPopover = SelectionPopover()
    }
}
