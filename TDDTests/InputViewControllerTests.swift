//
//  InputViewControllerTests.swift
//  TDD
//
//  Created by Kan Chen on 7/7/16.
//  Copyright © 2016 drchrono. All rights reserved.
//

import XCTest
@testable import TDD
import CoreLocation

class InputViewControllerTests: XCTestCase {
    var sut: InputViewController!
    var placeMark: MockPlacemark!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_HasTitleTextField() {
        XCTAssertNotNil(sut.titleTextField)
    }

    func testSave_UseGeocoderToGetCoordinateFromAddress() {
        sut.titleTextField.text = "Test Title"
        sut.dateTextField.text = "02/22/2016"
        sut.locationTextField.text = "Office"
        sut.addressTextField.text = "Infinite Loop 1, Cuppertino"
        sut.descTextField.text = "Test Desc"

        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        sut.itemManager = ItemManager()
        sut.save()
        placeMark = MockPlacemark()
        let coordinate = CLLocationCoordinate2D(latitude: 37.33, longitude: -122.22)
        placeMark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placeMark], nil)
        let item = sut.itemManager?.itemAtIndex(0)
        let testItem = ToDoItem(title: "Test Title", itemDescription: "Test Desc", timestamp: 1456128000, location: Location(name: "Office", coordinate: coordinate))
        XCTAssertEqual(item, testItem)
    }

    func test_SaveButtonHasSaveAction() {
        let saveButton: UIButton = sut.saveButton
        guard let actions = saveButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail(); return
        }
        XCTAssertTrue(actions.contains("save"))
    }

    func test_GeocoderWorksAsExpected() {
        let expectation = self.expectation(description: "Wait for geocode")
        CLGeocoder().geocodeAddressString("Infinite Loop 1, Cupertino") { (placemarks, error) in
            let placeMark = placemarks?.first
            let coordinate = placeMark?.location?.coordinate
            guard let latitude = coordinate?.latitude else {
                XCTFail()
                return
            }
            guard let longitude = coordinate?.longitude else {
                XCTFail()
                return
            }
            XCTAssertEqualWithAccuracy(latitude, 37.3316851, accuracy: 0.0001)
            XCTAssertEqualWithAccuracy(longitude, -122.0300674, accuracy: 0.0001)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}

extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        var completionHandler: CLGeocodeCompletionHandler?

        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }

    class MockPlacemark: CLPlacemark {
        var mockCoordinate: CLLocationCoordinate2D?
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else { return CLLocation() }
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
}
