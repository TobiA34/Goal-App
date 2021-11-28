//
//  FormTextTableViewCell.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import UIKit

class FormTextTableViewCell: UITableViewCell {

    static let cellID = "FormTextTableViewCell"

    private weak var delegate: FormTextTableViewCellDelegate?
    private var item: TextComponent?
    
    let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.font = titleLbl.font.withSize(25)

        titleLbl.text = "Title"
        titleLbl.textColor = Colour.textColour
        return titleLbl
    }()
    
    let titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.textColor = .black
        titleTextField.attributedPlaceholder = NSAttributedString(string: "[Enter title]", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        titleTextField.backgroundColor = .lightGray
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        titleTextField.leftView = leftView
        titleTextField.leftViewMode = .always
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.layer.cornerRadius = 19
        return titleTextField
    }()
    
    
    func configure(_ item: TextComponent,
                   delegate: FormTextTableViewCellDelegate) {
        self.delegate = delegate
        guard let item = item as? TextComponent else { return }
        self.item = item

        setUpView(item: item)
        titleLbl.text = item.title
        titleTextField.placeholder = item.placeholder
        titleTextField.text = item.value as? String
        createToolBar()
    }
}

private extension FormTextTableViewCell {
    
    func setUpView(item: TextComponent) {
        
        titleTextField.placeholder = item.placeholder
        
        titleTextField.delegate = self
        titleTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)

        contentView.addSubview(titleLbl)
        contentView.addSubview(titleTextField)

        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
            
            titleTextField.topAnchor.constraint(equalTo: titleLbl.bottomAnchor,constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
            titleTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}

extension FormTextTableViewCell {
     func getTitle() -> String {
        let title = titleTextField.text ?? ""
        return title
    }
}

extension FormTextTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let val = textField.text,
           let id = item?.id {
            delegate?.didInput(val, with: id)
        }
    }

    @objc func textFieldDidChange(textField: UITextField){

        if let val = textField.text,
           let id = item?.id {
            delegate?.didInput(val, with: id)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return false
    }
}

extension FormTextTableViewCell {
        private func createToolBar() {
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
            
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            titleTextField.inputAccessoryView = toolBar
         }
        
        @objc func dismissKeyboard(){
            contentView.endEditing(true)
        }
    }


