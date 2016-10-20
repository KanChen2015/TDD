//
//  InputViewController.swift
//  TDD
//
//  Created by Kan Chen on 7/7/16.
//  Copyright © 2016 drchrono. All rights reserved.
//

import UIKit
import CoreLocation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class InputViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save() {
        guard let titleString = titleTextField.text , !titleString.isEmpty else { return }
        let date: Date?
        if let dateText = dateTextField.text , !dateText.isEmpty {
            date = dateFormatter.date(from: dateText)
        } else {
            date = nil
        }
        let desc: String?
        if descTextField.text?.characters.count > 0 {
            desc = descTextField.text
        } else {
            desc = nil
        }
        if let locationName = locationTextField.text , !locationName.isEmpty {
            if let address = addressTextField.text , !address.isEmpty {
                geocoder.geocodeAddressString(address, completionHandler: {[unowned self] (placemarks, error) in
                    let placeMark = placemarks?.first
                    let item = ToDoItem(title: titleString, itemDescription: desc, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName, coordinate: placeMark?.location?.coordinate))
                    self.itemManager?.addItem(item)
                })
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()

}
