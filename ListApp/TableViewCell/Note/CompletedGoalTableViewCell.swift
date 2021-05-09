//
//  CompletedGoalTableViewCell.swift
//  ListApp
//
//  Created by tobi adegoroye on 24/03/2021.
//

import UIKit


protocol CompletedGoalTableViewCellDelegate: AnyObject {
    func undo(completedGoal: Goal, at indexPath: IndexPath)
}

class CompletedGoalTableViewCell: UITableViewCell {
    
    static let cellID = "CompletedGoalTableViewCell"
    private weak var delegate: CompletedGoalTableViewCellDelegate?
    private var completedGoal: Goal?
    private var indexPath: IndexPath?
    
    private let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLbl.numberOfLines = 0
        titleLbl.textColor = Colour.textColour
        return titleLbl
    }()
    
    private let doneButton: UIButton = {
        let doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = Colour.grey
        doneButton.layer.cornerRadius = 19
        
        doneButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        return doneButton
    }()
    
    private let descriptionLbl: UILabel = {
        let descriptionLbl = UILabel()
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.font = descriptionLbl.font.withSize(14)
        descriptionLbl.numberOfLines = 0
        descriptionLbl.textColor = Colour.textColour
        return descriptionLbl
    }()
    
    private let card: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 19
        card.backgroundColor = Colour.cardColour
        return card
    }()
    
    @objc func undoGoal() {
        if let selectedGoal = completedGoal,
           let indexPath = indexPath {
            doneButton.setImage(selectedGoal.isCompleted ?  Image.whiteTick : Image.greenTick, for: .normal)
            delegate?.undo(completedGoal: selectedGoal, at: indexPath)
        }
    }
    
    
    func configure(completedGoal: Goal, isTap: Bool, indexPath: IndexPath, delegate: CompletedGoalTableViewCellDelegate?) {
        setupView()
        self.delegate = delegate
        self.completedGoal = completedGoal
        self.indexPath = indexPath
        titleLbl.text = completedGoal.title
        descriptionLbl.text = completedGoal.desc
        doneButton.setImage(completedGoal.isCompleted ?  Image.greenTick :  Image.whiteTick, for: .normal)
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text =  nil
        descriptionLbl.text =  nil
        doneButton.setImage(nil, for: .normal)
    }
}

private extension CompletedGoalTableViewCell {
    
    func setupView() {
        contentView.addSubview(card)
        card.addSubview(titleLbl)
        card.addSubview(descriptionLbl)
        card.addSubview(doneButton)
        
        doneButton.addTarget(self, action: #selector(undoGoal), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            card.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 40),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -40),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            
            titleLbl.topAnchor.constraint(equalTo: card.topAnchor,constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: card.leadingAnchor,constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: card.trailingAnchor,constant: -20),
            
            descriptionLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor,constant: 10),
            descriptionLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            descriptionLbl.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor),
            descriptionLbl.bottomAnchor.constraint(equalTo: card.bottomAnchor,constant: -20),
            
            doneButton.topAnchor.constraint(equalTo: card.topAnchor,constant: 40),
            doneButton.leadingAnchor.constraint(equalTo: descriptionLbl.trailingAnchor,constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: card.trailingAnchor,constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 30),
            doneButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
}
