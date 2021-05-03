//
//  SceneDelegate.swift
//  ListApp
//
//  Created by tobi adegoroye on 12/03/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var vc: UIViewController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
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
            
            tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
            
            vc = tabBarController
            
            window.rootViewController = vc
            
            self.window = window
            window.makeKeyAndVisible()
        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {
            // Called as the scene transitions from the foreground to the background.
            // Use this method to save data, release shared resources, and store enough scene-specific state information
            // to restore the scene back to its current state.
            
            // Save changes in the application's managed object context when the application transitions to the background.
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
}
