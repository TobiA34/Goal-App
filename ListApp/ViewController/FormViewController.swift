//
//  FormViewController.swift
//  ListApp
//
//  Created by tobi adegoroye on 12/03/2021.
//

import UIKit
import CoreData

class FormViewController: UIViewController {
    
    private var noteViewModel: NoteViewModel!
    let imagePicker = UIImagePickerController()
 
    
    private var categorysName = Category.allCases
    private var selectedCategory: Category?
    var isHidden = false

    init() {
        super.init(nibName: nil, bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        noteViewModel = NoteViewModel(context: context)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
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
        categoryTextField.backgroundColor = Colour.lightGrey
        categoryTextField.placeholder = "[pick a category]"
        categoryTextField.textColor = .black

        categoryTextField.font = categoryTextField.font?.withSize(20)
        categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        return categoryTextField
    }()
    
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
    
    let descriptionLbl: UILabel = {
        let descriptionLbl = UILabel()
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.text = "Description"
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
    
    let card: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor =  Colour.cardColour
        card.layer.cornerRadius = 19
        return card
    }()
 
    
    
    func openGallery() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func uploadImage() {
        openGallery()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        validateForm(title: titleTextField, description: descriptionTextView, category: categoryTextField)
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        categoryTextField.resignFirstResponder()
     }
    
}

extension FormViewController {

    
    func scheduleNotification() {
        
        let yourFireDate = endDatePicker.date
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey:
                                                                    titleTextField.text ?? "", arguments: nil)
        content.body = descriptionTextView.text
 
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: yourFireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter
            .current()
            .add(request, withCompletionHandler: { error in
                if let error = error {
                    //handle error
                    DispatchQueue.main.async {
                        self.failedAlert(title: "Failed", message: "Failed to create goal", buttonTitle: "Ok", error: "\( error.localizedDescription )")
                    }
                   
                } else {
                    DispatchQueue.main.async {
                        self.successAlert(title: "Success", message: "Successfully created", buttonTitle: "Ok")
                }
            }
        })

    }
}



extension UIViewController {
    func successAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    func failedAlert(title: String, message: String, buttonTitle: String, error: String?) {
        let alert = UIAlertController(title: "Failed", message: "failed to create alert", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}
 

extension FormViewController {
 
    
    @objc func save() {
        
        if isHidden{
            validateForm(title: titleTextField, description: descriptionTextView, category: categoryTextField)
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
 
            let newNote = Note(entity: entity!, insertInto: context)
            newNote.title = titleTextField.text
            newNote.desc = descriptionTextView.text
            newNote.endDate =  endDatePicker.date
            newNote.category = categoryTextField.text
            do {
                try context.save()
                noteViewModel.noteList.append(newNote)
                self.navigationController?.popToRootViewController(animated: true)
            } catch {
                print("context save error")
            }
            scheduleNotification()

        }
    }
}


extension FormViewController {
    func setupView() {
        view.backgroundColor = UIColor(named: "background")
        createCategoryPicker()
        createToolBar()
        
        view.addSubview(card)
        card.addSubview(titleLbl)
        card.addSubview(titleTextField)
        card.addSubview(categoryLabel)
        card.addSubview(categoryTextField)
        card.addSubview(descriptionLbl)
        card.addSubview(descriptionTextView)
        card.addSubview(endDatePicker)
        card.addSubview(endDateLabel)


        NSLayoutConstraint.activate([
            
            card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            card.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            card.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            card.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            
            titleLbl.topAnchor.constraint(equalTo: card.topAnchor,constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: card.leadingAnchor,constant: 10),
            titleLbl.trailingAnchor.constraint(equalTo: card.trailingAnchor,constant: -10),
            
            titleTextField.topAnchor.constraint(equalTo: titleLbl.bottomAnchor,constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: card.leadingAnchor,constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: card.trailingAnchor,constant: -10),
            titleTextField.heightAnchor.constraint(equalToConstant: 45),
            
            categoryLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 200),
            
            
            categoryTextField.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 15),
            categoryTextField.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            categoryTextField.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -20),
            categoryTextField.heightAnchor.constraint(equalToConstant: 50),
            categoryTextField.widthAnchor.constraint(equalToConstant: 350),
            
            endDateLabel.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 20),
            endDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            endDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 200),
            
            
            endDatePicker.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 15),
            endDatePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
              endDatePicker.trailingAnchor.constraint(equalTo: card.trailingAnchor,constant: -20),
            
            
            
            descriptionLbl.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor,constant: 30),
            descriptionLbl.leadingAnchor.constraint(equalTo: card.leadingAnchor,constant: 10),
            descriptionLbl.trailingAnchor.constraint(equalTo: card.trailingAnchor,constant: -10),
            
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor,constant: 20),
            descriptionTextView.leadingAnchor.constraint(equalTo: card.leadingAnchor,constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: card.trailingAnchor,constant: -20),
            
            descriptionTextView.heightAnchor.constraint(equalToConstant: 200)
 
        ])
    }
}


private extension FormViewController {
    
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
        descriptionTextView.inputAccessoryView = toolBar
        titleTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    func validateForm(title: UITextField , description: UITextView, category: UITextField){
        
         if title.text!.isEmpty && description.text.isEmpty && category.text!.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
         } else {
//            saveButton.isHidden = false
            navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(save))
         }
    }
    
    
}

extension FormViewController: UIPickerViewDelegate,UIPickerViewDataSource {
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
    }
}

extension FormViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateForm(title: titleTextField, description: descriptionTextView, category: categoryTextField)
        
    }
}

extension FormViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        validateForm(title: titleTextField, description: descriptionTextView, category: categoryTextField)
        }
}
  
