//
//  FormTextTableViewCell.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import UIKit

class FormCategoryTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let cellID = "FormCategoryTableViewCell"
    private var categorysName = Category.allCases
    private var selectedCategory: Category?
    
    private weak var delegate: FormCategoryTableViewCellDelegate?
    private var item: CategoryComponent?
//
    let categoryLabel:UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.text = "Choose category"
        categoryLabel.font = categoryLabel.font.withSize(25)
        categoryLabel.textColor = Colour.textColour
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoryLabel
    }()
    
    
    
    let categoryTextField: UITextField = {
        let categoryTextField = UITextField()
        categoryTextField.backgroundColor = .systemGray6
        categoryTextField.placeholder = "[pick a category]"
        categoryTextField.textColor =  UIColor(named: "cellText")

        categoryTextField.font = categoryTextField.font?.withSize(20)
        categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        return categoryTextField
    }()
    
    
    func configure(_ item: CategoryComponent,
                   delegate: FormCategoryTableViewCellDelegate) {
        self.item = item
        self.delegate = delegate
        setUpView(item: item)
    }
}


extension FormCategoryTableViewCell {
     func getCategory() -> String {
        let category = categoryTextField.text ?? ""
        return category
    }
}

private extension FormCategoryTableViewCell {
    
    func setUpView(item: CategoryComponent) {
        
        createToolBar()
        createCategoryPicker()
        categoryTextField.delegate = self

        contentView.addSubview(categoryLabel)
        contentView.addSubview(categoryTextField)

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            
            categoryTextField.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 15),
            categoryTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            categoryTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            categoryTextField.heightAnchor.constraint(equalToConstant: 50),
            
            categoryTextField.widthAnchor.constraint(equalToConstant: 350),
            categoryTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
        ])
    }
}

private extension FormCategoryTableViewCell {
    
    private func createCategoryPicker(){
        
        let categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        
        categoryTextField.inputView = categoryPicker
    }
    
    private func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        categoryTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(){
        contentView.endEditing(true)
    }
}

extension FormCategoryTableViewCell: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorysName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorysName[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categorysName[row]
        categoryTextField.text = selectedCategory?.rawValue
        if let item = item,
           let category = selectedCategory?.rawValue {
            delegate?.didSelect(category, id: item.id)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
        
    }
}
 
