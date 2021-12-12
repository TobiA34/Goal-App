//
//  ListTableViewCell.swift
//  ListApp
//
//  Created by tobi adegoroye on 12/03/2021.
//

import UIKit

protocol ListTableViewCellDelegate: AnyObject {
    func didComplete(goal: Goal, at indexPath: IndexPath)
}
 
class ListTableViewCell: UITableViewCell {
    
    static let cellID = "ListTableViewCell"
    private weak var delegate: ListTableViewCellDelegate?
    private var goal: Goal?
    private var indexPath: IndexPath?
    
    
    lazy var categoryLbl: UIButton = {
        let category1 = UIButton()
        category1.setTitle("category1", for: .normal)
        category1.setTitleColor(.black, for: .normal)
        category1.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        category1.backgroundColor = .clear
        category1.layer.borderWidth = 1
        category1.layer.cornerRadius = 15
        category1.translatesAutoresizingMaskIntoConstraints = false
        category1.layer.borderColor = UIColor.black.cgColor
        return category1
    }()
 
    lazy var categoryIcon: UIButton = {
        let icon = UIButton()
        icon.setImage(UIImage(systemName: "dollarsign.circle"), for: .normal)
        icon.backgroundColor = .black
        icon.tintColor = .white
        icon.layer.borderWidth = 1
        icon.layer.cornerRadius = 9
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.layer.borderColor = UIColor.black.cgColor
        return icon
    }()
    
    lazy var calendarIcon: UIButton = {
        let icon = UIButton()
        icon.setImage(UIImage(systemName: "calendar"), for: .normal)
        icon.backgroundColor = .black
        icon.tintColor = .white
        icon.layer.borderWidth = 1
        icon.layer.cornerRadius = 9
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.layer.borderColor = UIColor.black.cgColor
        return icon
    }()
    
    lazy var timeIcon: UIButton = {
        let timeIcon = UIButton()
        timeIcon.setImage(UIImage(systemName: "clock"), for: .normal)
        timeIcon.backgroundColor = .black
        timeIcon.tintColor = .white
        timeIcon.layer.borderWidth = 1
        timeIcon.layer.cornerRadius = 9
        timeIcon.translatesAutoresizingMaskIntoConstraints = false
        timeIcon.layer.borderColor = UIColor.black.cgColor
        return timeIcon
    }()
    
    
    lazy var card: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 8
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.black.cgColor
        card.backgroundColor = .cyan
        return card
    }()

    lazy var calendarStackView: UIStackView = {
        let categoryStackView = UIStackView()
        categoryStackView.axis = .horizontal
        categoryStackView.distribution = .equalSpacing
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryStackView.spacing = 3
        categoryStackView.alignment = .fill
         
        return categoryStackView
    }()
    lazy var timeStackView: UIStackView = {
        let timeStackView = UIStackView()
        timeStackView.axis = .horizontal
        timeStackView.distribution = .equalSpacing
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        timeStackView.spacing = 19
        timeStackView.alignment = .fill
 
        return timeStackView
    }()

    lazy var titleLbl: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.text = "Buy a ps5 today "
        return title
    }()
    
    
    lazy var dateLbl: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.text = "12/05/2021 "
        return title
    }()

    lazy var timeLbl: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.text = "07:30 (Remind At 07:35)"
        return title
    }()
    
    
    private var doneButton: UIButton = {
        let doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = .clear
        doneButton.layer.cornerRadius = 14.5
        doneButton.setImage(UIImage(named: "tick"), for: .normal)
        doneButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = UIColor.black.cgColor
        return doneButton
    }()
    
    private func setDoneButtonImage(goal:Goal) {
        doneButton.setImage(goal.isCompleted ?   Image.greenTick :  Image.whiteTick, for: .normal)
    }
 
  
 
    func configure(goal: Goal,
                   isTap: Bool,
                   indexPath: IndexPath,
                   delegate: ListTableViewCellDelegate?){
        titleLbl.text = goal.title
 
        if  let rawCategory = goal.category,
            let category = Category(rawValue: rawCategory) {
            categoryIcon.setImage(category.icon, for: .normal)
            categoryLbl.setTitle(goal.category, for: .normal)
         }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.basic
        if let date = goal.endDate {
            dateLbl.text = dateFormatter.string(from: date)
        }
        
        let timeDateFormatter = DateFormatter()
        timeDateFormatter.dateFormat = DateFormat.time
        if let time = goal.endDate {
            let timeFormat = timeDateFormatter.string(from: time)
            timeLbl.text = "\(timeFormat) (Remind at \(timeFormat)"
        }
                
        self.delegate = delegate
        self.goal = goal
        self.indexPath = indexPath
        setDoneButtonImage(goal: goal)
        setupView()
     }
    
    @objc func done(){
        
        if let selectedGoal = goal,
           let indexPath = indexPath {
            doneButton.setImage(selectedGoal.isCompleted ?  Image.whiteTick :  Image.greenTick, for: .normal)
            delegate?.didComplete(goal: selectedGoal, at: indexPath)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text =  nil
        categoryLbl.setImage(nil, for: .normal)
        dateLbl.text = nil
        timeLbl.text = nil
        goal = nil
        indexPath = nil
        doneButton.setImage(nil, for: .normal)
    }
}

private extension ListTableViewCell {
    
    func setupView() {
 
        contentView.addSubview(card)
         card.addSubview(categoryLbl)

        card.addSubview(titleLbl)
        
        card.addSubview(calendarStackView)
        calendarStackView.addSubview(calendarIcon)
        calendarStackView.addSubview(dateLbl)
        
        card.addSubview(timeStackView)
        card.addSubview(doneButton)
        card.addSubview(categoryIcon)

        calendarStackView.addSubview(timeIcon)
        calendarStackView.addSubview(timeLbl)

        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 20),
            card.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: 8),
            card.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,constant: -8),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            
            categoryLbl.topAnchor.constraint(equalTo: card.safeAreaLayoutGuide.topAnchor,constant: 10),
            categoryLbl.leadingAnchor.constraint(equalTo: card.safeAreaLayoutGuide.leadingAnchor,constant: 20),
             categoryLbl.heightAnchor.constraint(equalToConstant: 36),
            categoryLbl.widthAnchor.constraint(equalToConstant: 100),

            titleLbl.topAnchor.constraint(equalTo: categoryLbl.bottomAnchor,constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: card.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: card.safeAreaLayoutGuide.trailingAnchor,constant: -20),
 
            calendarStackView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor,constant: 20),
            calendarStackView.leadingAnchor.constraint(equalTo: card.leadingAnchor,constant: 20),
            calendarStackView.heightAnchor.constraint(equalToConstant: 20),
            calendarStackView.widthAnchor.constraint(equalToConstant: 100),

            
            calendarIcon.topAnchor.constraint(equalTo: calendarStackView.topAnchor,constant: 0),
            calendarIcon.leadingAnchor.constraint(equalTo: calendarStackView.leadingAnchor,constant: 0),
            dateLbl.topAnchor.constraint(equalTo: calendarStackView.topAnchor,constant: 0),
            dateLbl.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor,constant: 5),
            
            
            timeStackView.topAnchor.constraint(equalTo: calendarStackView.bottomAnchor,constant: 20),
            timeStackView.leadingAnchor.constraint(equalTo: card.leadingAnchor,constant: 20),
            timeStackView.bottomAnchor.constraint(equalTo: card.bottomAnchor,constant: -20),
            timeStackView.heightAnchor.constraint(equalToConstant: 20),
            timeStackView.widthAnchor.constraint(equalToConstant: 100),
            
            
            timeIcon.topAnchor.constraint(equalTo: timeStackView.topAnchor,constant: 0),
            timeIcon.leadingAnchor.constraint(equalTo: timeStackView.leadingAnchor,constant: 0),
            timeLbl.topAnchor.constraint(equalTo: timeStackView.topAnchor,constant: 0),
            timeLbl.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor,constant: 5),

            
            doneButton.leadingAnchor.constraint(equalTo: timeStackView.trailingAnchor, constant: 200),
            doneButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -30),
            doneButton.heightAnchor.constraint(equalToConstant: 24),
            doneButton.widthAnchor.constraint(equalToConstant: 24),
            
            categoryIcon.topAnchor.constraint(equalTo: card.safeAreaLayoutGuide.topAnchor,constant: 10),
            categoryIcon.leadingAnchor.constraint(equalTo: categoryLbl.trailingAnchor,constant: 200),
            categoryIcon.heightAnchor.constraint(equalToConstant: 26),
            categoryIcon.widthAnchor.constraint(equalToConstant: 26),
 

        ])
    }
}
