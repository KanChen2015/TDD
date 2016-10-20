//
//  ItemCellTests.swift
//  TDD
//
//  Created by Kan Chen on 7/7/16.
//  Copyright © 2016 drchrono. All rights reserved.
//

import XCTest
@testable import TDD

class ItemCellTests: XCTestCase {
    var tableView: UITableView!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemListVC") as! ItemListViewController
        _ = controller.view
        tableView = controller.tableView
        tableView.dataSource = FakeDataSource()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSUT_HasNameLabel() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        XCTAssertNotNil(cell.titleLabel)
    }

    func testSUT_HasLcationLabel() {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        XCTAssertNotNil(cell.locationLabel)
    }

    func testConfigWithItem_SetLabelTexts() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        cell.configCellWithItem(ToDoItem(title: "First", itemDescription: nil, timestamp: 1456150025, location: Location(name: "Home")))
        XCTAssertEqual(cell.titleLabel.text, "First")
        XCTAssertEqual(cell.locationLabel.text, "Home")
        XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
    }

    func testTitle_ForCheckedTasks_IsStrokeThrough() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        let toDoItem = ToDoItem(title: "First", itemDescription: nil, timestamp: 1456150025, location: Location(name: "Home"))
        cell.configCellWithItem(toDoItem, checked: true)
        let attributeString = NSAttributedString(string: "First", attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
        XCTAssertEqual(cell.titleLabel.attributedText, attributeString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
}

extension ItemCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
