//
//  NotificationViewModel.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import UIKit

class NotificationViewModel {
    
    static let shared = NotificationViewModel()
    
    private init() { }
    
    let formViewController = FormViewController(sharedDBInstance: DatabaseManager.shared)
    
    func scheduleNotification(note: NoteForm) {
        
        let yourFireDate = note.endDate
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey:
                                                                    note.title , arguments: nil)
        content.body = note.description
        
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: yourFireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter
            .current()
            .add(request, withCompletionHandler:{  error in
                if error != nil {
                    //handle error
                    DispatchQueue.main.async {
                        self.formViewController.show(title: "Failed", message: "\(String(describing: error?.localizedDescription))", buttonTitle: "Ok")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.formViewController.show(title: "Success", message: "Successfully created", buttonTitle: "Ok")
                    }
                }
            })
    }
}
