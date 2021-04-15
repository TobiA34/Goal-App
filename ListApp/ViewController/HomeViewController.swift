//
//  ViewController.swift
//  ListApp
//
//  Created by tobi adegoroye on 12/03/2021.
//

import UIKit
import CoreData


class HomeViewController: UIViewController {
    
    private var noteViewModel: NoteViewModel!
 
    var firstLoad = true
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        noteViewModel = NoteViewModel(context: context)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.separatorStyle = .none
        tableview.backgroundColor = Colour.background
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 44
        tableview.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.cellID)
        return tableview
    }()
    
    @objc func add() {
        let formVC = FormViewController()
        formVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(formVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        searchBar.delegate = self
        setupView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(add))
        navigationController?.navigationBar.barTintColor =  Colour.background
         requestPermission()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        noteViewModel.noteList = noteViewModel.getAllUnCompletedNote()
        tableview.reloadData()
    }

    

    
    func setupView() {
        createToolBar()
        view.backgroundColor = Colour.lightGrey
        view.addSubview(tableview)
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            tableview.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

private extension HomeViewController {

    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    // We have permission!
                }
            }
    }
}


private extension HomeViewController {
    private func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        searchBar.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            noteViewModel.fetchSearchedData(searchText)
        } else {
            noteViewModel.noteList =  noteViewModel.getAllUnCompletedNote()
         }
        tableview.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noteViewModel.noteList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let note =  noteViewModel.noteList[indexPath.row]
        let cell = tableview.dequeueReusableCell(withIdentifier: ListTableViewCell.cellID,for: indexPath) as? ListTableViewCell
        cell?.configure(note: note, isTap: noteViewModel.doesExist(item: note), indexPath: indexPath, delegate: self)
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        cell?.backgroundColor = .clear
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = noteViewModel.noteList.remove(at: indexPath.row)
            tableview.deleteRows(at: [indexPath], with: .automatic)
            noteViewModel.remove(note: note)
        }
    }
}

extension HomeViewController: ListTableViewCellDelegate {
    
    func didComplete(note: Note, at indexPath: IndexPath) {
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 0.25) {
                self.noteViewModel.complete(true, note: note)
                self.tableview.deleteRows(at: [indexPath], with: .automatic)
            }
        // Here we want to set the completed flag to true in db
    }
}

