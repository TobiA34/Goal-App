//
//  TabBarViewController.swift
//  ListApp
//
//  Created by tobi adegoroye on 14/11/2021.
//

import UIKit


class TabBarViewController: UIViewController {
    
    let tabBar = UITabBarController()

    
    /// This function sets up the tab bar
    func tab() {
        let firstVC = UINavigationController(rootViewController: HomeViewController())
        let secondVC = UINavigationController(rootViewController: CompleteGoalViewController())
        
        
        let item1 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
       let item2 = UITabBarItem(title: "Completed Goals", image: UIImage(systemName: "target"), tag: 1)
       
        
        firstVC.tabBarItem = item1
        secondVC.tabBarItem = item2
        
        tabBar.viewControllers = [firstVC,secondVC]
        self.view.addSubview(tabBar.view)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
         tab()
      }
    
}
