//
//  FormDatePickerTableViewCell.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import Foundation

import UIKit

class FormEndDatePickerTableViewCell: UITableViewCell {

    static let cellID = "FormEndDatePickerTableViewCell"

    private weak var delegate: FormEndDatePickerTableViewCellDelegate?
    private var item: DateComponent?
    
    
    let endDateLabel: UILabel = {
        let endDateLabel = UILabel()
        endDateLabel.text = "Choose end date"
        endDateLabel.textColor =  Colour.textColour
        endDateLabel.font = endDateLabel.font.withSize(25)
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return endDateLabel
    }()
    
    let endDatePicker: UIDatePicker = {
        let endDatePicker = UIDatePicker()
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        return endDatePicker
    }()
    
    
    func configure(_ item: DateComponent,
                   delegate: FormEndDatePickerTableViewCellDelegate) {
        self.item = item
        self.delegate = delegate
        setUpView(item: item)
    }
}

private extension FormEndDatePickerTableViewCell {
    
    func setUpView(item: DateComponent) {

        endDatePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

        contentView.addSubview(endDateLabel)
        contentView.addSubview(endDatePicker)

        NSLayoutConstraint.activate([
            
            endDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            endDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            endDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            
            endDatePicker.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 15),
            endDatePicker.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 30),
              endDatePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
            endDatePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),

        ])
    }
}


extension FormEndDatePickerTableViewCell {
     func getEndDate() -> Date {
        let date = endDatePicker.date
        return date
    }
}

 
extension FormEndDatePickerTableViewCell {
    
    @objc func dateChanged() {
        if let id = item?.id {
            delegate?.didSelect(endDatePicker.date, with: id)
        }
        print("The user selected: \(endDatePicker.date)")
    }
    
}
