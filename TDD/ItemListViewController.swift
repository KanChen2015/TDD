//
//  ItemListViewController.swift
//  TDD
//
//  Created by Kan Chen on 7/6/16.
//  Copyright © 2016 drchrono. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var dataProvider: (UITableViewDataSource & UITableViewDelegate)?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }
}
