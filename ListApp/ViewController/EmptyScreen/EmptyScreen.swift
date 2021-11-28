//
//  EmptyScreen.swift
//  ListApp
//
//  Created by tobi adegoroye on 28/11/2021.
//

import UIKit

class EmptyScreen: UIView {
    
    lazy var goalImageView: UIImageView = {
        let goalImageView = UIImageView()
        goalImageView.translatesAutoresizingMaskIntoConstraints = false
        goalImageView.image = UIImage(named: "todoImage")
        goalImageView.tintColor = .white
        goalImageView.setImageColor(color: UIColor(named: "image")!)
        goalImageView.contentMode = .scaleAspectFit
         return goalImageView
        
    }()
    

    lazy var goalLabel: UILabel = {
        let goalLabel = UILabel()
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        goalLabel.text = "Sorry you have no life goals. Please press the + button to create some life goals."
        goalLabel.textAlignment = .center
        goalLabel.numberOfLines = 0
        goalLabel.font = UIFont.systemFont(ofSize: 20)
        return goalLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomView() {
        self.backgroundColor = Colour.background
        self.addSubview(goalImageView)
        self.addSubview(goalLabel)
        

        NSLayoutConstraint.activate([
            goalImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 40),
            goalImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            goalImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            goalImageView.heightAnchor.constraint(equalToConstant: 200),

            goalLabel.topAnchor.constraint(equalTo: goalImageView.bottomAnchor,constant: 50),
            goalLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: 90),
            goalLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: -90),
             

        ])
    }
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
