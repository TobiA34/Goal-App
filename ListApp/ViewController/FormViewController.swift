//
//  FormsViewController.swift
//  ListApp
//
//  Created by tobi adegoroye on 16/04/2021.
//

import UIKit
import CoreData


class FormViewController: UIViewController {

    private var noteViewModel: NoteViewModel!
    private var sharedDBInstance: DatabaseManager!
    let formViewModel = FormViewModel()
    init(sharedDBInstance: DatabaseManager) {
        self.sharedDBInstance = sharedDBInstance
        super.init(nibName: nil, bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        noteViewModel = NoteViewModel(context: context)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colour.background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FormTextTableViewCell.self, forCellReuseIdentifier: FormTextTableViewCell.cellID)
        tableView.register(FormCategoryTableViewCell.self, forCellReuseIdentifier: FormCategoryTableViewCell.cellID)
        tableView.register(FormDescriptionTableViewCell.self, forCellReuseIdentifier: FormDescriptionTableViewCell.cellID)
        tableView.register(FormEndDatePickerTableViewCell.self, forCellReuseIdentifier: FormEndDatePickerTableViewCell.cellID)
        tableView.register(FormButtonTableViewCell.self, forCellReuseIdentifier: FormButtonTableViewCell.cellID)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
        tableView.dataSource = self
    }
}

//MARK:- SETTING UP VIEW
extension FormViewController {
    func setUpView(){
        view.backgroundColor = .white
        view.addSubview(tableView)

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
}

//MARK:- TABLEVIEW DATA SOURCE
extension FormViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formViewModel.components.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = formViewModel.components[indexPath.row]

        switch item {
        case is TextComponent:
            let cell = tableView.dequeueReusableCell(withIdentifier: FormTextTableViewCell.cellID, for: indexPath) as! FormTextTableViewCell
            cell.contentView.backgroundColor = .clear
            cell.configure(item as! TextComponent, delegate: self)
            cell.selectionStyle = .none
            return cell
        case is CategoryComponent:
            let cell = tableView.dequeueReusableCell(withIdentifier: FormCategoryTableViewCell.cellID, for: indexPath) as! FormCategoryTableViewCell
            cell.contentView.backgroundColor = .clear
            cell.configure(item as! CategoryComponent, delegate: self)
            cell.selectionStyle = .none
            return cell
        case is DescriptionComponent:
            let cell = tableView.dequeueReusableCell(withIdentifier: FormDescriptionTableViewCell.cellID, for: indexPath) as! FormDescriptionTableViewCell
            cell.contentView.backgroundColor = .clear
            cell.configure(item as! DescriptionComponent, delegate: self)
            cell.selectionStyle = .none
            return cell
        case is DateComponent:
            let cell = tableView.dequeueReusableCell(withIdentifier: FormEndDatePickerTableViewCell.cellID, for: indexPath) as! FormEndDatePickerTableViewCell
            cell.contentView.backgroundColor = .clear
            cell.configure(item as! DateComponent, delegate: self)
            cell.selectionStyle = .none
            return cell
        case is ButtonComponent:
            let cell = tableView.dequeueReusableCell(withIdentifier: FormButtonTableViewCell.cellID, for: indexPath) as! FormButtonTableViewCell
            cell.contentView.backgroundColor = .clear
            cell.configure(item as! ButtonComponent, delegate: self)
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK:- FORM TEXT DELEGATE
extension FormViewController: FormTextTableViewCellDelegate {

    func didInput(_ val: String, with id: String) {
        formViewModel.set(val: val, id: id)
    }
}

//MARK:- FORM END DATE DELEGATE
extension FormViewController: FormEndDatePickerTableViewCellDelegate {
    func didSelect(_ val: Date, with id: String) {
        formViewModel.set(val: val, id: id)
    }
}

//MARK:- FORM BUTTON DELEGATE
extension FormViewController: FormButtonTableViewCellDelegate{
    func didTap(id: String) {

                if let note = formViewModel.newNote,
                    formViewModel.isValid {
                    sharedDBInstance.save(note: note)
                    NotificationViewModel
                        .shared
                        .scheduleNotification(note: note) { [weak self] res in

                            guard let self = self else { return }

                            switch res {
                            case .success:
                                break
                            case .failure(let error):
                                self.show(title: "Failed", message: error.localizedDescription, buttonTitle: "OK")
                            }

                    }
                    navigationController?.popViewController(animated: true)
                } else {
                    show(title: "Failed", message: "One of the form is not valid", buttonTitle: "OK")
                }
    }
}

//MARK:- FORM CATEGORY DELEGATE
extension FormViewController: FormCategoryTableViewCellDelegate {
    func didSelect(_ category: String, id: String) {
        formViewModel.set(val: category, id: id)
    }
}
