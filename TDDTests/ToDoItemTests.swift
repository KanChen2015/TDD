//
//  ToDoItemTests.swift
//  TDD
//
//  Created by Kan Chen on 7/6/16.
//  Copyright © 2016 drchrono. All rights reserved.
//

import XCTest
@testable import TDD

class ToDoItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit_ShouldTakeTitle() {
        let item = ToDoItem(title: "Test title")
        XCTAssertNotNil(item, "item should not be nil")
    }

    func testInit_ShouldTakeTitleAndDescription() {
        _ = ToDoItem(title: "test title",
                     itemDescription: "Test Description")
    }

    func testInit_ShoudlSetTitle() {
        let item = ToDoItem(title: "Title")
        XCTAssertEqual(item.title, "Title")
    }

    func testInit_ShouldSetTitleAndDescription() {
        let item = ToDoItem(title: "Test title", itemDescription: "Test Description")
        XCTAssertEqual(item.itemDescription, "Test Description", "Init should set item description")
    }

    func testInit_ShouldSetTittleAndDescriptionAndTimeStamp() {
        let item = ToDoItem(title: "Test Title", itemDescription: "Test Description", timestamp: 0.0)
        XCTAssertEqual(0.0, item.timestamp, "Init should set timestamp")
    }

    func testInit_ShouldSetTittleAndDescriptionAndTimeStampAndLocation() {
        let location = Location(name: "Test name")
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0, location: location)
        XCTAssertEqual(location.name, item.location?.name, "Init should set location")
    }

    func testEqualItems_ShoudleBeEqual() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "First")
        XCTAssertEqual(firstItem, secondItem)
    }

    func testWhenLocationDiffers_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
                                 itemDescription: "First",
                                 timestamp: 0.0,
                                 location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "Second title",
                                  itemDescription: "Second",
                                  timestamp: 0.0,
                                  location: Location(name: "Office"))
        XCTAssertNotEqual(firstItem, secondItem)
    }

    func testWhenOneLocationIsNilAndTheOtherIsnt_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title", itemDescription: "Fist", timestamp: 0.0, location: nil)
        let secondITem = ToDoItem(title: "First title", itemDescription: "First", timestamp: 0.0, location: Location(name: "Office"))
        XCTAssertNotEqual(firstItem, secondITem)
    }

    func testWhenTimestampDiffers_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title", itemDescription: "First", timestamp: 1.0)
        let secondItem = ToDoItem(title: "First title", itemDescription: "First", timestamp: 0.0)
        XCTAssertNotEqual(firstItem, secondItem)
    }

    func testWhenDescribeDiffers_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title", itemDescription: "First")
        let secondItem = ToDoItem(title: "First title", itemDescription: "Second")
        XCTAssertNotEqual(firstItem, secondItem)
    }
    func testWhenTitleDiffers_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title")
        let secondItem = ToDoItem(title: "Second title")
        XCTAssertNotEqual(firstItem, secondItem)
    }
}
