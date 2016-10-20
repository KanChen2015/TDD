//
//  ItemManagerTests.swift
//  TDD
//
//  Created by Kan Chen on 7/6/16.
//  Copyright © 2016 drchrono. All rights reserved.
//

import XCTest
@testable import TDD

class ItemManagerTests: XCTestCase {
    var sut: ItemManager!
    override func setUp() {
        super.setUp()
        sut = ItemManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testToDoCount_Initially_ShouldBeZero() {
        XCTAssertEqual(sut.toDoCount, 0, "Initially toDo count should be 0")
    }

    func testDoneCount_Initially_ShouldBeZero() {
        XCTAssertEqual(sut.doneCount, 0, "Initially toDo count should be 0")
    }

    func testToDoCount_AfterAddingOneItem_IsOne() {
        sut.addItem(ToDoItem(title: "Test title"))
        XCTAssertEqual(sut.toDoCount, 1, "toDoCount should be 1")
    }

    func testItemAtIndex_ShouldReturnPreviousAddedItem() {
        let item = ToDoItem(title: "Item")
        sut.addItem(item)
        let returnedItem = sut.itemAtIndex(0)
        XCTAssertEqual(item.title, returnedItem.title, "should be the same item")
    }

    func testCheckingItem_ChangesCountOfToDoandOfDoneItems() {
        sut.addItem(ToDoItem(title: "First Item"))
        sut.checkItemAtIndex(0)
        XCTAssertEqual(sut.toDoCount, 0, "toDo Count should be 0")
        XCTAssertEqual(sut.doneCount, 1, "done Count should be 1 ")
    }

    func testCheckingItem_RemovesItFromTheToDoItemList() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        sut.addItem(firstItem)
        sut.addItem(secondItem)
        sut.checkItemAtIndex(0)
        XCTAssertEqual(sut.itemAtIndex(0).title, secondItem.title)
    }

    func testDoneItemAtIndex_ShouldReturnPreviouslyCheckedItem() {
        let item = ToDoItem(title: "Item")
        sut.addItem(item)
        sut.checkItemAtIndex(0)
        let returnedItem = sut.doneItemAtIndex(0)
        XCTAssertEqual(item.title, returnedItem.title, "should be the same item")
    }

    func testAddingTheSameItem_DosentIncreaseCount() {
        sut.addItem(ToDoItem(title: "First"))
        sut.addItem(ToDoItem(title: "First"))
        XCTAssertEqual(sut.toDoCount, 1)
    }
}
