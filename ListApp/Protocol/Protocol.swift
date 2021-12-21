//
//  Protocol.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import UIKit

protocol FormTextTableViewCellDelegate: AnyObject {
    func didInput(_ val: String, with id: String)
}

protocol FormEndDatePickerTableViewCellDelegate: AnyObject {
    func didSelect(_ val: Date, with id: String)

}

protocol FormCategoryTableViewCellDelegate: AnyObject {
    func didSelect(_ category: String, id: String)
}


protocol FormButtonTableViewCellDelegate: AnyObject {
    func didTap(id: String)
}


protocol FormColourTableViewCellDelegate: AnyObject {
    func didSelect(_ color: UIColor, with id: String)
}
