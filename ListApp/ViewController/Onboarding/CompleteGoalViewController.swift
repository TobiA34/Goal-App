//
//  ViewController2.swift
//  PageViewControllerExample
//
//  Created by tobi adegoroye on 13/11/2021.
//

import UIKit

class CompleteGoalViewController: UIViewController {
    
    lazy var card: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 19
        card.backgroundColor = .white
        return card
    }()
    
    
    lazy var title1: UILabel = {
        let labelInst = UILabel()
        labelInst.translatesAutoresizingMaskIntoConstraints = false
        labelInst.text = PageEnum.page2.title
        labelInst.textColor = UIColor(named: "cellText")
        labelInst.font = UIFont.boldSystemFont(ofSize: 40.0)
         return labelInst
    }()
    
    lazy var pageDescription: UILabel = {
        let pageDescription = UILabel()
        pageDescription.translatesAutoresizingMaskIntoConstraints = false
        pageDescription.text = PageEnum.page2.description
        pageDescription.textColor = UIColor(named: "cellText")

        pageDescription.font = UIFont.boldSystemFont(ofSize: 16.0)
        pageDescription.numberOfLines = 0
        return pageDescription
    }()
    
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = PageEnum.page2.image
         return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        view.addSubview(title1)
        view.addSubview(pageDescription)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50),
            
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50),
            
            
            title1.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 60),
            title1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            title1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            
            
            pageDescription.topAnchor.constraint(equalTo: title1.bottomAnchor,constant: 16),
            pageDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            pageDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -60),
        ])
    }


}
