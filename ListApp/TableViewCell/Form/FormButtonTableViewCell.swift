//
//  FormButtonTableViewCell.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import UIKit
class FormButtonTableViewCell: UITableViewCell {
    
 
    
    static let cellID = "FormButtonTableViewCell"

    private weak var delegate: FormButtonTableViewCellDelegate?
    private var item: ButtonComponent?
    
    let saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("save", for: .normal)
        saveButton.backgroundColor = Colour.grey
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.layer.cornerRadius = 14
        return saveButton
    }()
    
    func configure(_ item: ButtonComponent,
                   delegate: FormButtonTableViewCellDelegate) {
        self.item = item
        self.delegate = delegate
        setUpView(item: item)
    }
    
    @objc func save() {
        if let id = item?.id {
            delegate?.didTap(id: id)
        }
    }
}


   private extension FormButtonTableViewCell {
    
    

    func setUpView(item: ButtonComponent) {
        
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        contentView.addSubview(saveButton)
 
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 80),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -80),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
        ])
    }
}

