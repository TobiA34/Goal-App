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
    
    func fetchAllData() -> [Note] {
        // get everything in the entity named Review
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        return try! context.fetch(fetchRequest) as? [Note] ?? []
    }
    
    func getItem(with title: String) -> [Note] {
        //perform a query to get an item by its name
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        return try! (context.fetch(fetchRequest) as? [Note] ?? [])
    }
    
    func doesExist(item: Note) -> Bool {
        // This function checks to see if the item exist in the database
        return getItem(with: item.title ?? "").isEmpty == false
    }
    
    
    func remove(note:Note) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Note")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
 
    
    func getAllCompletedNote() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
 
        fetchRequest.predicate =  NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        return try! (context.fetch(fetchRequest) as? [Note] ?? [])
        
  
    }
    
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
 
    
    func getAllUnCompletedNote() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
 
        fetchRequest.predicate =  NSPredicate(format: "isCompleted == %@", false)
        return try! (context.fetch(fetchRequest) as? [Note] ?? [])
    }
    
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

