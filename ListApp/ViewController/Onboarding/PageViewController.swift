//
//  PageViewController.swift
//  PageViewControllerExample
//
//  Created by tobi adegoroye on 13/11/2021.
//

import UIKit
import UIKit

class PageViewController: UIPageViewController {
    
    let initialPage = 0
        
    var pages: [UIViewController] = [CreateGoalViewController(),CompleteGoalViewController(),ViewGoalViewController()]
    let pageControl = UIPageControl()

        override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
                
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        setupPageViewController()
    
    }
}

extension PageViewController {
    func setupPageViewController() {
        // pageControl
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
       self.pageControl.pageIndicatorTintColor = UIColor.lightGray
       self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = initialPage
        self.view.addSubview(self.pageControl)

        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -90).isActive = true
        
        self.pageControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -160).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return self.pages.last
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
            
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return self.pages.first
            }
        }
        return nil
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    
    

    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
    // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }

}
