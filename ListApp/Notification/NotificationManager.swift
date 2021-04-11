//
//  Notification.swift
//  ListApp
//
//  Created by tobi adegoroye on 11/04/2021.
//

import UIKit

class NotificationManager {
    
   static let shared = NotificationManager()
   
    private init() { }

    func getArticle(completion: @escaping (Swift.Result<Bool, Error>) -> ()) {
       UNUserNotificationCenter
           .current()
           .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                
            do {
                completion(.success(true))
                
            } catch let error {
                completion(.failure(error))
            }
           
       }
   }
    
    
}
