//
//  Category.swift
//  ListApp
//
//  Created by tobi adegoroye on 18/03/2021.
//

import Foundation

import UIKit

 
enum Category: String, CaseIterable {
   case personal = "Personal"
   case finance = "Finance"
   case health = "Health"
}

extension Category {

    var colour: UIColor? {
        switch self {
        case .personal:
           return Colour.yellow
        case .finance:
            return Colour.blue
        case .health:
            return Colour.pink
        }
    }
   
   var icon: UIImage? {
       switch self {
       case .personal:
           return UIImage(systemName: "pencil")
       case .finance:
           return UIImage(systemName: "dollarsign.circle")
       case .health:
           return UIImage(systemName: "heart.fill")
        }
   }
   
}

