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
        
    func scheduleNotification(goal: GoalForm, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let yourFireDate = goal.endDate
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: goal.title , arguments: nil)
        content.body = goal.description
        
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: yourFireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter
            .current()
            .add(request, withCompletionHandler: { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            })
    }
}
