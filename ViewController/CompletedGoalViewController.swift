//
//  CompletedGoalViewController.swift
//  ListApp
//
//  Created by tobi adegoroye on 24/03/2021.
//

import UIKit
import CoreData
 
class CompletedGoalViewController: UIViewController {

    
    private var noteViewModel: NoteViewModel!
  
    init(){
        super.init(nibName: nil, bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        noteViewModel = NoteViewModel(context: context)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 44
        tableview.register(CompletedNoteTableViewCell.self, forCellReuseIdentifier: CompletedNoteTableViewCell.cellID)
        return tableview
    }()
    
    @objc func add(){
        let formVC = FormViewController()
        formVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(formVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        setupView()
         navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(add))
        navigationItem.rightBarButtonItem?.tintColor = .black
        tableview.reloadData()
        requestPermission()
    }
    
    func requestPermission() -> Void {
       UNUserNotificationCenter
           .current()
           .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
               if granted == true && error == nil {
                   // We have permission!
               }
       }
   }
    
    func setupView() {
        view.backgroundColor = UIColor(hexString: "#F2F2F2")
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        noteViewModel.noteList = noteViewModel.getAllCompletedNote()
     }
    
}

extension CompletedGoalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   noteViewModel.noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let completedNote = noteViewModel.noteList[indexPath.row]
        let cell = tableview.dequeueReusableCell(withIdentifier: CompletedNoteTableViewCell.cellID,for: indexPath) as? CompletedNoteTableViewCell
        cell?.configure(completedNote: completedNote)
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        cell?.backgroundColor = .clear
        return cell!
    }
     
    }
    
    


