//
//  ListTableViewCell.swift
//  ListApp
//
//  Created by tobi adegoroye on 12/03/2021.
//

import UIKit

protocol ListTableViewCellDelegate: class {
    func didComplete(note: Note, at indexPath: IndexPath)
}
 
class ListTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let cellID = "ListTableViewCell"
    private var delegate: ListTableViewCellDelegate?
    private var note: Note?
    private var indexPath: IndexPath?
    
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
    
    let goalImage: UIImageView = {
        let goalImage = UIImageView()
        goalImage.translatesAutoresizingMaskIntoConstraints = false
        goalImage.contentMode = .scaleAspectFit
        return goalImage
    }()
    
 
    
    let doneButton: UIButton = {
        let doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = UIColor(hexString: "#C4C4C4")
        doneButton.layer.cornerRadius = 19
        doneButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

        doneButton.setImage(UIImage(named: "tick"), for: .normal)
        return doneButton
    }()
    
    let healthView: UIView = {
        let healthView = UIView ()
        healthView.translatesAutoresizingMaskIntoConstraints = false
        healthView.backgroundColor = .lightGray
        healthView.layer.cornerRadius = 16
        healthView.clipsToBounds = true
        return healthView
    }()
    
    let dateView: UIView = {
        let dateView = UIView ()
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.backgroundColor = .green
        dateView.layer.cornerRadius = 16
        dateView.clipsToBounds = true
        dateView.backgroundColor = .green

        return dateView
    }()
    
    let dateLbl: UILabel = {
        let descriptionLbl = UILabel()
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.font = descriptionLbl.font.withSize(14)
        descriptionLbl.numberOfLines = 0
        descriptionLbl.textColor = UIColor(named: "textColor")
        return descriptionLbl
    }()
    
 
    var healthImgvw: UIImageView = {
        let healthImgvw = UIImageView()
        healthImgvw.translatesAutoresizingMaskIntoConstraints = false
        healthImgvw.image = UIImage(named: "tick")
        healthImgvw.tintColor = .white
        return healthImgvw
    }()
    
    let card: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 19
        card.backgroundColor = UIColor(named: "card")
        return card
    }()
    
 
    func configure(note: Note,
                   isTap: Bool,
                   indexPath: IndexPath,
                   delegate: ListTableViewCellDelegate?){
        titleLbl.text = note.title
        descriptionLbl.text = note.desc

        switch note.category {
        case Category.finance.title:
            healthImgvw.image = Category.finance.icon
            healthView.backgroundColor = UIColor(hexString: "#5995ED")
        case Category.health.title:
            healthImgvw.image = Category.health.icon
            healthView.backgroundColor = UIColor(hexString: "#EF476F")
        case Category.personal.title:
            healthImgvw.image = Category.personal.icon
            healthView.backgroundColor = UIColor(hexString: "#F4D35E")
        case .none:
            break
        case .some(_):
            break
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        if let date = note.endDate{
            dateLbl.text = dateFormatter.string(from: date)
        }
        self.delegate = delegate
        self.note = note
        self.indexPath = indexPath
        if !note.isCompleted {
            doneButton.backgroundColor = UIColor(hexString: "#C4C4C4")
            doneButton.setImage(UIImage(named: "white-tick"), for: .normal)
        } else {
            doneButton.backgroundColor = UIColor(hexString: "#34F855")
            doneButton.setImage(UIImage(named: "green-tick"), for: .normal)
        }
     }
    
    @objc func done(){
        
        if let selectedNote = note,
           let indexPath = indexPath {
            doneButton.setImage(selectedNote.isCompleted ?  #imageLiteral(resourceName: "white-tick") : #imageLiteral(resourceName: "green-tick"), for: .normal)
            delegate?.didComplete(note: selectedNote, at: indexPath)
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text =  nil
        descriptionLbl.text =  nil
        healthImgvw.image = nil
        dateLbl.text = nil
        note = nil
        indexPath = nil
    }
}

private extension ListTableViewCell {
    
    func setupView() {
 
        contentView.addSubview(card)
        card.addSubview(dateView)
        card.addSubview(titleLbl)
        card.addSubview(descriptionLbl)
        card.addSubview(doneButton)
        dateView.addSubview(dateLbl)
        card.addSubview(healthView)
        card.addSubview(healthImgvw)
        
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            card.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 40),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -40),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
        
            healthView.topAnchor.constraint(equalTo: card.topAnchor,constant: 16),
 
            healthView.leadingAnchor.constraint(equalTo: card.leadingAnchor,constant: 16),
            healthView.trailingAnchor.constraint(equalTo: titleLbl.leadingAnchor,constant: -14),
            healthView.heightAnchor.constraint(equalToConstant: 30),
            healthView.widthAnchor.constraint(equalToConstant: 60),

            healthImgvw.centerXAnchor.constraint(equalTo: healthView.centerXAnchor),
            healthImgvw.centerYAnchor.constraint(equalTo: healthView.centerYAnchor),
            healthImgvw.heightAnchor.constraint(equalToConstant: 18),
            healthImgvw.widthAnchor.constraint(equalToConstant: 18),
            
            titleLbl.topAnchor.constraint(equalTo: card.topAnchor,constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: healthImgvw.trailingAnchor,constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: card.trailingAnchor,constant: -20),
            
            descriptionLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor,constant: 10),
            descriptionLbl.leadingAnchor.constraint(equalTo: card.leadingAnchor,constant: 60),
            descriptionLbl.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor,constant: -20),
//            descriptionLbl.bottomAnchor.constraint(equalTo: card.bottomAnchor,constant: -10),
//
    
    
            doneButton.topAnchor.constraint(equalTo: card.topAnchor,constant: 40),
             doneButton.trailingAnchor.constraint(equalTo: card.trailingAnchor,constant: -60),
            doneButton.heightAnchor.constraint(equalToConstant: 30),
            doneButton.widthAnchor.constraint(equalToConstant: 30),
            
            dateView.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor,constant: 10),
            dateView.leadingAnchor.constraint(equalTo: card.leadingAnchor,constant: 40),
            dateView.trailingAnchor.constraint(equalTo: card.trailingAnchor,constant: -100),
            dateView.bottomAnchor.constraint(equalTo: card.bottomAnchor,constant: -10),
            dateView.heightAnchor.constraint(equalToConstant: 30),
            
            dateLbl.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            dateLbl.centerYAnchor.constraint(equalTo: dateView.centerYAnchor)

        ])
    }
    
}
