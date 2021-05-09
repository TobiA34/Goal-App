//
//  GoalViewModel.swift
//  ListApp
//
//  Created by tobi adegoroye on 12/03/2021.
//

import UIKit
import CoreData

final class GoalViewModel {
    
    var goalList = [Goal]()
 
 
    private var context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    
    /// This function will get all the data from the database
    /// - Returns: It will return the context that is being fetched and cast it as an array of goals and if it fails return an empty array.
    func fetchAllData() -> [Goal] {
        // get everything in the entity named Review
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        return try! context.fetch(fetchRequest) as? [Goal] ?? []
    }
    
    /// This function will get an item in the database by its title.
    /// - Parameter title: The goal title
    /// - Returns: It will return the context that is being fetched and cast it as an array of goals and if it fails return an empty array.
    func getItem(with title: String) -> [Goal] {
        //perform a query to get an item by its name
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        return try! (context.fetch(fetchRequest) as? [Goal] ?? [])
    }
    
    /// This will check if the item exists in the database
    /// - Parameter item: this is the goal model
    /// - Returns: the function getItem with the title and check to see if it is empty
    func doesExist(item: Goal) -> Bool {
        // This function checks to see if the item exist in the database
        return getItem(with: item.title ?? "").isEmpty == false
    }
 
    
    /// This will remove the not from the database
    /// - Parameter goal: this is the model
    func remove(goal: Goal) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Goal")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
 
    
    /// This will get all the completed goals in the database
    /// - Returns: It will return the context that is being fetched and cast it as an array of goals and if it fails return an empty array.
    func getAllCompletedGoal() -> [Goal] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
 
        fetchRequest.predicate =  NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        return try! (context.fetch(fetchRequest) as? [Goal] ?? [])
    }
    
    /// This will undo the goals
    /// - Parameters:
    ///   - val: is a boolean
    ///   - completedGoal: this is the model of goal
    func undo(_ val: Bool, completedGoal: Goal) {
        
        do {
            completedGoal.setValue(val, forKey: "isCompleted")
            try context.save()
            self.goalList = getAllCompletedGoal()
            
        }
        catch {
            print("context save error")
        }

    }
    
    /// This will check if the goal is completed
    /// - Parameters:
    ///   - val: is a boolean
    ///   - goal: this is the model of goal
    func complete(_ val: Bool, goal: Goal) {
        do {
            goal.setValue(val, forKey: "isCompleted")
            try context.save()
            self.goalList = getAllUnCompletedGoal()
        }
        catch {
            print("context save error")
        }
    }
 
    
    /// This will get all the un completed goal
    /// - Returns: It will return the context that is being fetched and cast it as an array of goals and if it fails return an empty array.
    func getAllUnCompletedGoal() -> [Goal] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
 
        fetchRequest.predicate =  NSPredicate(format: "isCompleted == %@", false)
        return try! (context.fetch(fetchRequest) as? [Goal] ?? [])
    }
    
    /// This will search for the goal using the title
    /// - Parameter searchText: This is the title the user will enter
    func fetchSearchedData(_ searchText: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Goal")
         fetchRequest.predicate = NSPredicate(format: "title contains[c] '\(searchText)'")
        
        do {
            goalList = try context.fetch(fetchRequest) as! [Goal]
        } catch let error {
            print("Could not fetch. \(error)")
        }
     }

}

