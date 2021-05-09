//
//  DatabaseManager.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import UIKit
import CoreData



class DatabaseManager {
    
    
    private var goalViewModel: GoalViewModel!
 
    static let shared = DatabaseManager()
    
    private init(){}
 
    
 
    func save(goal: GoalForm) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Goal", in: context)
        

        let newGoal = Goal(entity: entity!, insertInto: context)
        newGoal.title = goal.title
        newGoal.desc = goal.description
        newGoal.endDate =  goal.endDate
        newGoal.category = goal.category
        do {
            try context.save()
        } catch {
            print("context save error")
        }
    }
}

