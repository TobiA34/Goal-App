//
//  CompletedNoteTableViewCell.swift
//  ListApp
//
//  Created by tobi adegoroye on 24/03/2021.
//

import UIKit


protocol CompletedNoteTableViewCellDelegate: AnyObject {
    func undo(completedNote: Note, at indexPath: IndexPath)
}

class CompletedNoteTableViewCell: UITableViewCell {
    
    
    static let cellID = "CompletedNoteTableViewCell"
    private var delegate: CompletedNoteTableViewCellDelegate?
    private var completedNote: Note?
    private var indexPath: IndexPath?
    
    private let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLbl.numberOfLines = 0
        titleLbl.textColor = UIColor(named: "textColor")
        return titleLbl
    }()
    
    private let doneButton: UIButton = {
        let doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = .lightGray
        doneButton.layer.cornerRadius = 19
        
        doneButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        return doneButton
    }()
    
    private let descriptionLbl: UILabel = {
        let descriptionLbl = UILabel()
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.font = descriptionLbl.font.withSize(14)
        descriptionLbl.numberOfLines = 0
        descriptionLbl.textColor = UIColor(named: "textColor")
        return descriptionLbl
    }()
    
    
    private let card: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 19
        card.backgroundColor = UIColor(named: "card")
        return card
    }()
    
    @objc func undoNote(){
        
        if let selectedNote = completedNote,
           let indexPath = indexPath {
            doneButton.setImage(selectedNote.isCompleted ? UIImage(named: Image.whiteTick) : UIImage(named: Image.greenTick), for: .normal)
            delegate?.undo(completedNote: selectedNote, at: indexPath)
        }
    }
    
    
    func configure(completedNote: Note, isTap: Bool, indexPath: IndexPath, delegate: CompletedNoteTableViewCellDelegate?) {
        setupView()
        self.delegate = delegate
        self.completedNote = completedNote
        self.indexPath = indexPath
        titleLbl.text = completedNote.title
        descriptionLbl.text = completedNote.desc
        doneButton.setImage(completedNote.isCompleted ? UIImage(named: Image.greenTick) : UIImage(named: Image.whiteTick), for: .normal)
        
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
        card.addSubview(doneButton)
        
        doneButton.addTarget(self, action: #selector(undoNote), for: .touchUpInside)
        
        
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
