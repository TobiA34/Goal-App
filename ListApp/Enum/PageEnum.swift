//
//  PageEnum.swift
//  PageViewControllerExample
//
//  Created by tobi adegoroye on 14/11/2021.
//

import UIKit

enum PageEnum: String {
    case page1
    case page2
    case page3
}

extension PageEnum {
    var image: UIImage? {
        switch self {
        case .page1:
            return UIImage(named: "CreateGoal")
        case .page2:
            return UIImage(named: "CompleteGoal")
        case .page3:
            return UIImage(named: "ViewGoal")
        }
    }
  
}

extension PageEnum {
    var backgroundColour: UIColor? {
        switch self {
        case .page1:
            return .white
        case .page2:
            return .white
        case .page3:
            return .white
        }
    }
  
}



extension PageEnum {
    var title: String {
        switch self {
        case .page1:
            return "Create Goal"
        case .page2:
            return "Complete Goal"
        case .page3:
            return "View Goal"
        }
    }
  
}

extension PageEnum {
    var description: String {
        switch self {
        case .page1:
            return "On this page you can create your life goals.You can set the title, choose a category for your life goal and set a date when you want the life goal to be completed."
        case .page2:
            return "Once you have clicked the tick button on the life goal screen, you can see a list of completed goals on this screen. "
        case .page3:
            return "On this screen you can see all the goals you have created. You can also drag and organise the goals."
        }
    }
  
}
