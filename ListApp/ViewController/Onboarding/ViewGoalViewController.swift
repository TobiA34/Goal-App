//
//  ViewController3.swift
//  PageViewControllerExample
//
//  Created by tobi adegoroye on 13/11/2021.
//

import UIKit

class ViewGoalViewController: UIViewController {

    
    lazy var title1: UILabel = {
        let labelInst = UILabel()
        labelInst.translatesAutoresizingMaskIntoConstraints = false
        labelInst.text = PageEnum.page3.title
        labelInst.textColor = UIColor(named: "cellText")
        labelInst.font = UIFont.boldSystemFont(ofSize: 40.0)
         return labelInst
    }()
    
    lazy var pageDescription: UILabel = {
        let pageDescription = UILabel()
        pageDescription.translatesAutoresizingMaskIntoConstraints = false
        pageDescription.text = PageEnum.page3.description
        pageDescription.textColor = UIColor(named: "cellText")
        pageDescription.font = UIFont.boldSystemFont(ofSize: 16.0)
        pageDescription.numberOfLines = 0
        return pageDescription
    }()
    
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = PageEnum.page3.image
         return imageView
    }()
    
    lazy var completeBtn: UIButton = {
        let completeBtn = UIButton()
        completeBtn.translatesAutoresizingMaskIntoConstraints = false
        completeBtn.setTitle("Complete", for: .normal)
        completeBtn.setTitleColor(.white, for: .normal)
        completeBtn.backgroundColor = .brown
        return completeBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func complete(){
        let tabBarVc = TabBarViewController()
        tabBarVc.modalPresentationStyle = .fullScreen
        present(tabBarVc, animated: true, completion: nil)
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        view.addSubview(title1)
        view.addSubview(pageDescription)
        view.addSubview(imageView)
        view.addSubview(completeBtn)

        completeBtn.addTarget(self, action: #selector(complete), for: .touchUpInside)
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
            
            self.completeBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -90),
            
            self.completeBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 120),
            self.completeBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -120),
             self.completeBtn.heightAnchor.constraint(equalToConstant: 30),
            self.completeBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
        ])
    }


}
