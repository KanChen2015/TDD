//
//  ItemCell.swift
//  TDD
//
//  Created by Kan Chen on 7/7/16.
//  Copyright © 2016 drchrono. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCellWithItem(_ item: ToDoItem, checked: Bool = false) {
        if checked {
            let attributeString = NSAttributedString(string: item.title, attributes: [
                NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue
                ])
            titleLabel.attributedText = attributeString
            locationLabel.text = nil
            dateLabel.text = nil
        } else {
            titleLabel.text = item.title
            locationLabel.text = item.location?.name
            if let timeStamp = item.timestamp {
                let date = Date(timeIntervalSince1970: timeStamp)
                dateLabel.text = dateFormatter.string(from: date)
            }
        }
    }

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
}
