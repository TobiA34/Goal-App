//
//  DatabaseManager.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import UIKit
import CoreData



class DatabaseManager {
    
    
    private var noteViewModel: NoteViewModel!
 
    static let shared = DatabaseManager()
    
    private init(){}
 
    
 
    func save(note: NoteForm) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        

        let newNote = Note(entity: entity!, insertInto: context)
        newNote.title = note.title
        newNote.desc = note.description
        newNote.endDate =  note.endDate
        newNote.category = note.category
        do {
            try context.save()
        } catch {
            print("context save error")
        }
    }
}

