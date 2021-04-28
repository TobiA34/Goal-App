//
//  NoteViewModel.swift
//  ListApp
//
//  Created by tobi adegoroye on 12/03/2021.
//

import UIKit
import CoreData

final class NoteViewModel {
    
    var noteList = [Note]()
 
    private var context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    
    /// This function will get all the data from the database
    /// - Returns: It will return the context that is being fetched and cast it as an array of notes and if it fails return an empty array.
    func fetchAllData() -> [Note] {
        // get everything in the entity named Review
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        return try! context.fetch(fetchRequest) as? [Note] ?? []
    }
    
    /// This function will get an item in the database by its title.
    /// - Parameter title: The goal title
    /// - Returns: It will return the context that is being fetched and cast it as an array of notes and if it fails return an empty array.
    func getItem(with title: String) -> [Note] {
        //perform a query to get an item by its name
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        return try! (context.fetch(fetchRequest) as? [Note] ?? [])
    }
    
    /// This will check if the item exists in the database
    /// - Parameter item: this is the note model
    /// - Returns: the function getItem with the title and check to see if it is empty
    func doesExist(item: Note) -> Bool {
        // This function checks to see if the item exist in the database
        return getItem(with: item.title ?? "").isEmpty == false
    }
 
    
    /// This will remove the not from the database
    /// - Parameter note: this is the model
    func remove(note:Note) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Note")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
 
    
    /// This will get all the completed notes in the database
    /// - Returns: It will return the context that is being fetched and cast it as an array of notes and if it fails return an empty array.
    func getAllCompletedNote() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
 
        fetchRequest.predicate =  NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        return try! (context.fetch(fetchRequest) as? [Note] ?? [])
    }
    
    /// This will undo the notes
    /// - Parameters:
    ///   - val: is a boolean
    ///   - completedNote: this is the model of note
    func undo(_ val: Bool, completedNote: Note) {
        
        do {
            completedNote.setValue(val, forKey: "isCompleted")
            try context.save()
            self.noteList = getAllCompletedNote()
            
        }
        catch {
            print("context save error")
        }

    }
    
    /// This will check if the note is completed
    /// - Parameters:
    ///   - val: is a boolean
    ///   - note: this is the model of note
    func complete(_ val: Bool, note: Note) {
        do {
            note.setValue(val, forKey: "isCompleted")
            try context.save()
            self.noteList = getAllUnCompletedNote()
        }
        catch {
            print("context save error")
        }
    }
 
    
    /// This will get all the un completed note
    /// - Returns: It will return the context that is being fetched and cast it as an array of notes and if it fails return an empty array.
    func getAllUnCompletedNote() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
 
        fetchRequest.predicate =  NSPredicate(format: "isCompleted == %@", false)
        return try! (context.fetch(fetchRequest) as? [Note] ?? [])
    }
    
    /// This will search for the goal using the title
    /// - Parameter searchText: This is the title the user will enter
    func fetchSearchedData(_ searchText: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Note")
         fetchRequest.predicate = NSPredicate(format: "title contains[c] '\(searchText)'")
        
        do {
            noteList = try context.fetch(fetchRequest) as! [Note]
        } catch let error {
            print("Could not fetch. \(error)")
        }
     }

}

