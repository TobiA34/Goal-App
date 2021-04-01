//
//  Category.swift
//  ListApp
//
//  Created by tobi adegoroye on 18/03/2021.
//

import Foundation

import UIKit

 
enum Category: CaseIterable {
   case personal
   case finance
   case health
}

extension Category {
   var title: String {
       switch self {
       case .personal:
           return "Personal"
       case .finance:
           return "Finance"
       case .health:
           return "Health"
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

