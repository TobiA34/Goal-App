//
//  FormComponent.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import Foundation

protocol FormComponent {
    var id: String { get }
    var value: Any? { get set }
}

// Text Component
struct TextComponent: FormComponent {
    var id: String
    let placeholder: String
    let title: String
    var value: Any?

}

struct DescriptionComponent: FormComponent {
    var id: String
    let placeholder: String
    let title: String
    var value: Any?
}

struct DateComponent: FormComponent {
    var id: String
    let title: String
    var value: Any?
 }

struct CategoryComponent: FormComponent {
    var id: String
    let title: String
    var value: Any?
}

// Button Component
struct ButtonComponent: FormComponent {
    var id: String
    let title: String
    var value: Any?
}
