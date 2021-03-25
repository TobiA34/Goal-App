//
//  CompletedNoteTableViewCell.swift
//  ListApp
//
//  Created by tobi adegoroye on 24/03/2021.
//

import UIKit
 
 
class CompletedNoteTableViewCell: UITableViewCell {
    
    
    static let cellID = "CompletedNoteTableViewCell"
 
 
    let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLbl.numberOfLines = 0
        titleLbl.textColor = UIColor(named: "textColor")
        return titleLbl
    }()
    
    let descriptionLbl: UILabel = {
        let descriptionLbl = UILabel()
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.font = descriptionLbl.font.withSize(14)
        descriptionLbl.numberOfLines = 0
        descriptionLbl.textColor = UIColor(named: "textColor")
        return descriptionLbl
    }()
 
    
    let card: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 19
        card.backgroundColor =  .white
        return card
    }()
    
 
    func configure(completedNote: Note){
        setupView()
        titleLbl.text = completedNote.title
        descriptionLbl.text = "HEHRFHBSDHBS"
     }
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text =  nil
        descriptionLbl.text =  nil
    }
    
}
    



private extension CompletedNoteTableViewCell {
    
    func setupView() {
 
        contentView.addSubview(card)
        card.addSubview(titleLbl)
        card.addSubview(descriptionLbl)

        
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
            descriptionLbl.trailingAnchor.constraint(equalTo: titleLbl.trailingAnchor),
            descriptionLbl.bottomAnchor.constraint(equalTo: card.bottomAnchor,constant: -20)
 
        ])
    }
    
}
