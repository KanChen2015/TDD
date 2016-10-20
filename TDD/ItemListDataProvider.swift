//
//  ItemListDataProvider.swift
//  TDD
//
//  Created by Kan Chen on 7/6/16.
//  Copyright © 2016 drchrono. All rights reserved.
//

import UIKit
enum Section: Int {
    case toDo
    case done
}

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    var itemManager: ItemManager?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManager else { return 0 }
        guard let itemSection = Section(rawValue: section) else {
            fatalError()
        }
        let numberOfRows: Int
        switch itemSection {
        case .toDo:
            numberOfRows = itemManager.toDoCount
        case .done:
            numberOfRows = itemManager.doneCount
        }
        return numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        guard let itemManager = itemManager else { fatalError() }
        guard let section = Section(rawValue: (indexPath as NSIndexPath).section) else { fatalError() }
        let item: ToDoItem
        switch section {
        case .toDo:
            item = itemManager.itemAtIndex((indexPath as NSIndexPath).row)
        case .done:
            item = itemManager.doneItemAtIndex((indexPath as NSIndexPath).row)
        }
        cell.configCellWithItem(item)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        guard let section = Section(rawValue: (indexPath as NSIndexPath).section) else { fatalError() }
        let buttonTitle: String
        switch section {
        case .toDo:
            buttonTitle = "Check"
        case .done:
            buttonTitle = "Uncheck"
        }
        return buttonTitle
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let itemManager = itemManager else { fatalError() }
        guard let section = Section(rawValue: (indexPath as NSIndexPath).section) else { fatalError() }
        switch section {
        case .toDo:
            itemManager.checkItemAtIndex((indexPath as NSIndexPath).row)
        case .done:
            itemManager.uncheckItemAtIndex((indexPath as NSIndexPath).row)
        }
        tableView.reloadData()
    }
}
