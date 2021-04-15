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

    func requestPermission(completion: @escaping (Result<Bool, Error>) -> ()) {
       UNUserNotificationCenter
           .current()
           .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                
            if error != nil {
                completion(.success(granted))
            } else {
                completion(.failure(error!))

            }
           
       }
        
        
   }
    
    
}
