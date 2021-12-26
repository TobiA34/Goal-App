//
//  ListTableViewCell.swift
//  ListApp
//
//  Created by tobi adegoroye on 12/03/2021.
//

import UIKit

protocol ListTableViewCellDelegate: AnyObject {
    func didComplete(goal: Goal, at indexPath: IndexPath)
    func didDelete(goal: Goal, at indexPath: IndexPath)

}


 
class ListTableViewCell: UITableViewCell {
    
    static let cellID = "ListTableViewCell"
    private weak var delegate: ListTableViewCellDelegate?
    private var goal: Goal?
    private var indexPath: IndexPath?
    
 
//
//    lazy var card: UIView = {
//        let card = UIView()
//        card.translatesAutoresizingMaskIntoConstraints = false
//        card.layer.cornerRadius = 8
//        card.backgroundColor = .white
//        return card
//    }()
//    lazy var titleLbl: UILabel = {
//        let title = UILabel()
//        title.translatesAutoresizingMaskIntoConstraints = false
//        title.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
//        title.textColor =  UIColor.hexStringToUIColor(hex: "#2F3542")
//        return title
//    }()
//    lazy var descLbl: UILabel = {
//        let descLbl = UILabel()
//        descLbl.translatesAutoresizingMaskIntoConstraints = false
//        descLbl.font = UIFont.systemFont(ofSize: 15, weight: .light)
//        descLbl.textColor = UIColor.hexStringToUIColor(hex: "#2F3542")
//
//        descLbl.text = "Buy a ps5"
//        descLbl.lineBreakMode = .byWordWrapping
//        descLbl.numberOfLines = 0
//        return descLbl
//    }()
//    lazy var dateLbl: UILabel = {
//        let descLbl = UILabel()
//        descLbl.translatesAutoresizingMaskIntoConstraints = false
//        descLbl.font = UIFont.boldSystemFont(ofSize: 15)
//        descLbl.text = "25/12/2021, 12:00"
//
//        return descLbl
//    }()
//    lazy var categoryLbl: UILabel = {
//        let categoryLbl = UILabel()
//        categoryLbl.translatesAutoresizingMaskIntoConstraints = false
//        categoryLbl.font = UIFont.boldSystemFont(ofSize: 20)
//        categoryLbl.text = "Buy a ps5 today "
//        return categoryLbl
//    }()
//    lazy var bellIcon: UIImageView = {
//        let bellIcon = UIImageView()
//        bellIcon.translatesAutoresizingMaskIntoConstraints = false
//        bellIcon.image = UIImage(systemName: "bell.fill")
//        bellIcon.tintColor = Colour.primaryColour
//        return bellIcon
//    }()
//    lazy var stackVw: UIStackView = {
//        let stackVw = UIStackView()
//        stackVw.translatesAutoresizingMaskIntoConstraints = false
//        stackVw.distribution = .fillEqually
//        stackVw.axis = .vertical
//        stackVw.spacing = 10.0
//        return stackVw
//    }()
//    lazy var categoryBtn: UIButton = {
//        let categoryBtn = UIButton()
//        categoryBtn.translatesAutoresizingMaskIntoConstraints = false
//        categoryBtn.backgroundColor = UIColor.hexStringToUIColor(hex: "#FF4757")
//        categoryBtn.layer.cornerRadius = 18
//        categoryBtn.setTitleColor(.white, for: .normal)
//        return categoryBtn
//    }()
//    lazy var doneButton: UIButton = {
//        let doneButton = UIButton()
//        doneButton.translatesAutoresizingMaskIntoConstraints = false
//        doneButton.backgroundColor = .clear
//         return doneButton
//    }()
//    let menuBtn: UIButton = {
//        let menuBtn = UIButton()
//        menuBtn.translatesAutoresizingMaskIntoConstraints = false
//        menuBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
//        return menuBtn
//    }()
//
    
    private lazy var mainStack:UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.distribution = .fillProportionally
        s.spacing = 8
        s.alignment = .leading
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var notificationStack:UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.distribution = .fillProportionally
        s.spacing = 8
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var card: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 8
        card.backgroundColor = .white
        return card
    }()
    
    
    private lazy var titleLbl: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        title.text = "hello"
        title.textColor = .black
        return title
    }()
    
    private lazy var descLbl: UILabel = {
        let descLbl = UILabel()
        descLbl.translatesAutoresizingMaskIntoConstraints = false
        descLbl.font = UIFont.systemFont(ofSize: 15, weight: .light)
        descLbl.numberOfLines = 0
        descLbl.textColor = .black
        
        descLbl.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        descLbl.lineBreakMode = .byWordWrapping
        descLbl.numberOfLines = 0
        return descLbl
    }()
    
    
    lazy var bellIcon: UIImageView = {
        let bellIcon = UIImageView()
        bellIcon.translatesAutoresizingMaskIntoConstraints = false
        bellIcon.image = UIImage(systemName: "bell.fill")
        bellIcon.tintColor = Colour.primaryColour
        return bellIcon
    }()
    
    lazy var dateLbl: UILabel = {
        let descLbl = UILabel()
        descLbl.translatesAutoresizingMaskIntoConstraints = false
        descLbl.font = UIFont.boldSystemFont(ofSize: 15)
        descLbl.text = "25/12/2021, 12:00"
        
        return descLbl
    }()
    
    lazy var categoryBtn: UIButton = {
        let categoryBtn = UIButton()
        categoryBtn.translatesAutoresizingMaskIntoConstraints = false
        categoryBtn.backgroundColor = Colour.buttonColour
        categoryBtn.layer.cornerRadius = 18
        categoryBtn.setTitleColor(.white, for: .normal)
        categoryBtn.setTitle("category", for: .normal)
        return categoryBtn
    }()
    
    
    lazy var categoryLbl: UILabel = {
        let categoryLbl = UILabel()
        categoryLbl.translatesAutoresizingMaskIntoConstraints = false
        categoryLbl.font = UIFont.boldSystemFont(ofSize: 20)
        categoryLbl.text = "Buy a ps5 today "
        return categoryLbl
    }()
    
    lazy var doneButton: UIButton = {
        let doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = .clear
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "checkmark.circle.fill", withConfiguration: largeConfig)
        doneButton.setImage(largeBoldDoc, for: .normal)
        doneButton.tintColor = .blue
        return doneButton
    }()
    
    let menuBtn: UIButton = {
        let menuBtn = UIButton()
        menuBtn.translatesAutoresizingMaskIntoConstraints = false
        menuBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return menuBtn
    }()
    
    
    func setImage(colour: String){
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
               
        let largeBoldDoc = UIImage(systemName: "checkmark.circle.fill", withConfiguration: largeConfig)

        doneButton.setImage(largeBoldDoc, for: .normal)
        doneButton.tintColor = UIColor.hexStringToUIColor(hex: colour)
    }
    
 

    private func setDoneButtonImage(goal:Goal) {
        
        if goal.isCompleted {
            setImage(colour: "#2ED573")
        } else {
            setImage(colour: "#CED6E0")

        }
     }


 
    func configure(goal: Goal,
                   isTap: Bool,
                   indexPath: IndexPath,
                   delegate: ListTableViewCellDelegate?){
        titleLbl.text = goal.title
 
        if  let rawCategory = goal.category,
            let category = Category(rawValue: rawCategory) {
            categoryBtn.setTitle(category.rawValue, for: .normal)
         }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.basic
        if let date = goal.endDate {
            dateLbl.text = dateFormatter.string(from: date)
        }
        
        descLbl.text = goal.desc
                
        self.delegate = delegate
        self.goal = goal
        self.indexPath = indexPath
        setDoneButtonImage(goal: goal)
        setupView()
     }
    
    @objc func done(){

        if let selectedGoal = goal,
           let indexPath = indexPath {
              
            setDoneButtonImage(goal: goal!)
            
            delegate?.didComplete(goal: selectedGoal, at: indexPath)
        }
    }
    
     func delete() {
        if let selectedGoal = goal,
           let indexPath = indexPath {
            delegate?.didDelete(goal: selectedGoal, at: indexPath)
        }
    }
    
    @objc func createMenu(){
        let destruct = UIAction(title: "Destruct", attributes: .destructive) { _ in }
                
        let items = UIMenu(title: " ", options: .displayInline, children: [
            UIAction(title: "Delete", image: UIImage(systemName: "trash"), handler:{ _ in
                
                self.delete()
            }),
        ])
                
        menuBtn.menu = UIMenu(title: "", children: [items, destruct])
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text =  nil
        categoryLbl.text = nil
        dateLbl.text = nil
        goal = nil
        indexPath = nil
        doneButton.setImage(nil, for: .normal)
    }
}

private extension ListTableViewCell {
    
    func setupView() {
        
        menuBtn.addTarget(self, action: #selector(createMenu), for: .touchUpInside)
 
        contentView.addSubview(card)
        card.addSubview(mainStack)
        card.addSubview(doneButton)
        card.addSubview(menuBtn)
        mainStack.addArrangedSubview(titleLbl)
        mainStack.addArrangedSubview(descLbl)
        mainStack.addArrangedSubview(notificationStack)
        mainStack.addArrangedSubview(categoryBtn)
        notificationStack.addArrangedSubview(bellIcon)
        notificationStack.addArrangedSubview(dateLbl)


        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 16),
            card.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: 8),
            card.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,constant: -8),
            card.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,constant: -16),

            mainStack.topAnchor.constraint(equalTo: card.safeAreaLayoutGuide.topAnchor,constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: card.safeAreaLayoutGuide.leadingAnchor,constant: 8),
            mainStack.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor, constant: -8),
            mainStack.bottomAnchor.constraint(equalTo: card.safeAreaLayoutGuide.bottomAnchor,constant: -16),
            
 
            menuBtn.topAnchor.constraint(equalTo: card.topAnchor,constant: 24),
            menuBtn.leadingAnchor.constraint(equalTo: mainStack.safeAreaLayoutGuide.trailingAnchor,constant: 16),
            menuBtn.trailingAnchor.constraint(equalTo: card.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            
            bellIcon.heightAnchor.constraint(equalToConstant: 20),
            bellIcon.widthAnchor.constraint(equalToConstant: 20),
            
            doneButton.topAnchor.constraint(equalTo: card.safeAreaLayoutGuide.topAnchor,constant: 72),
            doneButton.leadingAnchor.constraint(equalTo: mainStack.safeAreaLayoutGuide.trailingAnchor,constant: 10),
            doneButton.trailingAnchor.constraint(equalTo: card.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            
 
            doneButton.heightAnchor.constraint(equalToConstant: 40),
            doneButton.widthAnchor.constraint(equalToConstant: 40),
            
             categoryBtn.widthAnchor.constraint(equalToConstant: 96),
        ])
    }
}
