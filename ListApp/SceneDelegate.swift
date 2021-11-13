//
//  SceneDelegate.swift
//  ListApp
//
//  Created by tobi adegoroye on 12/03/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var navigation: UINavigationController?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            
            let window = UIWindow(windowScene: windowScene)
            let tabBarController = UITabBarController()
            
            //Set up HomeViewController
            let homeVc = HomeViewController()
            homeVc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
            homeVc.title = "Home"
            
            //Set up CompletedGoalViewController
            let completedGoalVc = CompletedGoalViewController()
            completedGoalVc.tabBarItem = UITabBarItem(title: "Completed Goals", image: UIImage(systemName: "target"), tag: 1)
            completedGoalVc.title = "Completed Goal"
            
            let controllers = [homeVc, completedGoalVc]
            
            tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)
            }
            
            window.rootViewController = tabBarController
            self.window = window
            window.makeKeyAndVisible()
            self.navigation = tabBarController.viewControllers?.first as? UINavigationController
            
            if let shortcutItem = connectionOptions.shortcutItem {
                // Save it off for later when we become active.
                if shortcutItem.type == "GoalAction" {
                    navigation?.pushViewController(FormViewController(sharedDBInstance: DatabaseManager.shared), animated: false)
                }
            }
        }
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print(shortcutItem.type)
        switch shortcutItem.type {
        case "GoalAction":
            print("is working")
            navigation?.pushViewController(FormViewController(sharedDBInstance: DatabaseManager.shared), animated: false)
            //push from a tab bar controller
            //do the same thing when an app is killed
            break
        default:
            break
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}


