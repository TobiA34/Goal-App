//
//  FormViewModel.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import UIKit

enum FormContentIDs: String {
    case title
    case category
    case endDate
    case description
    case saveBtn
}

struct NoteForm {
      var title: String
      var category: String
      var endDate: Date
      var description: String
}

class FormViewModel {
  
    func set(val: Any, id: String) {
        if let item = components.enumerated().first(where: { $0.element.id == id }) {
            components[item.offset].value = val
        }
    }
    
    var isValid: Bool {
        let form = components.filter({ $0 is TextComponent || $0 is CategoryComponent || $0 is DateComponent || $0 is DescriptionComponent })
        return form.filter { $0.value == nil || ($0.value as? String)?.isEmpty == true }.isEmpty
    }
    
 
    var newNote: NoteForm? {
        
        guard let title = components.first(where: { $0.id ==  FormContentIDs.title.rawValue })?.value as? String,
              let category = components.first(where: { $0.id ==  FormContentIDs.category.rawValue })?.value as? String,
              let date = components.first(where: { $0.id ==  FormContentIDs.endDate.rawValue })?.value as? Date,
              let description = components.first(where: { $0.id ==  FormContentIDs.description.rawValue })?.value as? String else { return nil }

       return NoteForm(title: title,
                 category: category,
                 endDate: date,
                 description: description)
    }
    
    private(set) var components: [FormComponent] = [
        TextComponent(id: FormContentIDs.title.rawValue,
                      placeholder: "enter title", title: "Title",value: nil),
        CategoryComponent(id: FormContentIDs.category.rawValue,title: "Choose Category", value: nil),
        DateComponent(id: FormContentIDs.endDate.rawValue, title: "Enter bio", value: nil),
        DescriptionComponent(id: FormContentIDs.description.rawValue,
                             placeholder: "enter bio", title: "Bio", value: nil),
        ButtonComponent(id: FormContentIDs.description.rawValue,
                        title: "Description", value: true)
    ]
  
}
