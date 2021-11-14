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
    let goalAction = Action.GoalAction.rawValue
    var vc : UIViewController?

    
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
            
            let launchedBefore = UserDefaults.standard.bool(forKey: "hasLaunched")
            
           if launchedBefore {
                vc = tabBarController
           } else{
               vc = PageViewController()
           }
            UserDefaults.standard.set(true, forKey: "hasLaunched")
            
            window.rootViewController = vc
            self.window = window
            window.makeKeyAndVisible()
            self.navigation = tabBarController.viewControllers?.first as? UINavigationController
            
            if let shortcutItem = connectionOptions.shortcutItem {
                // Save it off for later when we become active.
                deepLink(shortcutItem: shortcutItem, actionName: goalAction)
            }
        }
    }
    
    func deepLink(shortcutItem: UIApplicationShortcutItem,actionName: String) {
        switch shortcutItem.type {
        case actionName:
            print("is working")
            navigation?.pushViewController(FormViewController(sharedDBInstance: DatabaseManager.shared), animated: false)

            break
        default:
            break
        }
        
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print(shortcutItem.type)
        deepLink(shortcutItem: shortcutItem, actionName: goalAction)
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}


