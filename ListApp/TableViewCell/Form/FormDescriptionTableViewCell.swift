//
//  FormDescriptionTableViewCell.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import UIKit

class FormDescriptionTableViewCell: UITableViewCell {
    
    static let cellID = "FormDescriptionTableViewCell"

    private weak var delegate: FormTextTableViewCellDelegate?
    private var item: DescriptionComponent?
    
    let descriptionLbl: UILabel = {
        let descriptionLbl = UILabel()
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.text = "Description"
        descriptionLbl.font = descriptionLbl.font.withSize(25)

        descriptionLbl.textColor =  Colour.textColour
        return descriptionLbl
    }()
    
    let descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.backgroundColor =  Colour.grey
        descriptionTextView.textColor = .black

        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0)
        descriptionTextView.layer.cornerRadius = 19
        return descriptionTextView
    }()
    
    func configure(_ item: DescriptionComponent,
                   delegate: FormTextTableViewCellDelegate) {
        self.item = item
        self.descriptionTextView.delegate = self
        self.delegate = delegate
        setUpView(item: item)
    }
}

private extension FormDescriptionTableViewCell {
    func setUpView(item: DescriptionComponent) {
        
        contentView.addSubview(descriptionLbl)
        contentView.addSubview(descriptionTextView)

        NSLayoutConstraint.activate([
            descriptionLbl.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 30),
            descriptionLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            descriptionLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor,constant: 20),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 200)

        ])
    }
}

extension FormDescriptionTableViewCell {
     func getDescription() -> String {
        let description = descriptionTextView.text ?? ""
        return description
    }
}

extension FormDescriptionTableViewCell: UITextViewDelegate {
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if let val = textView.text,
               let id = item?.id {
                delegate?.didInput(val, with: id)
            }
        }
        
        func textViewDidChange(_ textView: UITextView){
            if let val = descriptionTextView.text,
               let id = item?.id {
                delegate?.didInput(val, with: id)
            }
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            let numberOfChars = newText.count
            return numberOfChars < 150    // 10 Limit Value
        }
        
    }

