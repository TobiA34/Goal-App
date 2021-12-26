//
//  ViewController.swift
//  ListApp
//
//  Created by tobi adegoroye on 12/03/2021.
//

import UIKit
import CoreData

 

class HomeViewController: UIViewController {
    
    private var goalViewModel: GoalViewModel!
 

    var firstLoad = true
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        goalViewModel = GoalViewModel(context: context)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let emptyview: EmptyScreen = {
        let emptyview = EmptyScreen()
        emptyview.translatesAutoresizingMaskIntoConstraints = false
        return emptyview
    }()
    
    private let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.separatorStyle = .none
        tableview.backgroundColor = Colour.background
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 44
        tableview.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.cellID)
        tableview.dragInteractionEnabled = true
        return tableview
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["active","completed"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(selectedTab), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0

        return segmentedControl
    }()
    
    @objc func selectedTab(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
           case 0 :
            goalViewModel.goalList = goalViewModel.getAllUnCompletedGoal()
            presentEmptyScreen()
            tableview.reloadData()

        case 1:
            goalViewModel.goalList = goalViewModel.getAllCompletedGoal()
            tableview.reloadData()
           default:
            break
            }
        }
 
    
    @objc func add() {
        let formVC = FormViewController(sharedDBInstance: DatabaseManager.shared)
        formVC.modalPresentationStyle = .fullScreen
//        navigationController?.pushViewController(formVC, animated: true)
        present(formVC, animated: true, completion: nil)
    }
    
    @objc func sort() {
        if tableview.isEditing {
            tableview.isEditing = false
        } else {
            tableview.isEditing = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        searchBar.delegate = self
        setupView()
         let rightBarButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(add))
        
        navigationController?.navigationBar.barTintColor =  Colour.background
        rightBarButton.tintColor = Colour.primaryColour

        self.navigationItem.rightBarButtonItem = rightBarButton
 
        navigationItem.title =  "Goals"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
//     
    
    
    func presentEmptyScreen() {
        
        if  goalViewModel.goalList.isEmpty {
            emptyview.isHidden = false
            tableview.isHidden = true
        } else{
            emptyview.isHidden = true
            tableview.isHidden = false
        }
    }
 
    func getDate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateText = dateFormatter.string(from: date)
        return dateText
    }

    func setupView() {
        createToolBar()
        view.backgroundColor = Colour.lightGrey
        view.addSubview(tableview)
        view.addSubview(searchBar)
        view.addSubview(segmentedControl)
        view.addSubview(emptyview)
 
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
 
            emptyview.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            emptyview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
 
            
            tableview.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
 
        ])
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
            goalViewModel.fetchSearchedData(searchText)
        } else {
            goalViewModel.goalList =  goalViewModel.getAllUnCompletedGoal()
         }
        tableview.reloadData()
    }
}



extension HomeViewController {
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        goalViewModel.goalList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
}
 

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return goalViewModel.goalList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let goal =  goalViewModel.goalList[indexPath.row]
        let cell = tableview.dequeueReusableCell(withIdentifier: ListTableViewCell.cellID,for: indexPath) as? ListTableViewCell
        cell?.configure(goal: goal, isTap: goalViewModel.doesExist(item: goal), indexPath: indexPath, delegate: self)
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        cell?.backgroundColor = .clear
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let goal = goalViewModel.goalList.remove(at: indexPath.row)
            tableview.deleteRows(at: [indexPath], with: .automatic)
            goalViewModel.remove(goal: goal)
            if  goalViewModel.goalList.isEmpty {
                emptyview.isHidden = false
                tableview.isHidden = true
            } else{
                emptyview.isHidden = true
                tableview.isHidden = false
            }
            
        }
    }
}

extension HomeViewController: ListTableViewCellDelegate {
    
    func didDelete(goal: Goal, at indexPath: IndexPath) {
        let goal = goalViewModel.goalList.remove(at: indexPath.row)
        tableview.deleteRows(at: [indexPath], with: .automatic)
        goalViewModel.remove(goal: goal)
    }
 
    
    func displayAlert(){
        // the alert view
        let alert = UIAlertController(title: "Goal", message: "life goal has been completed", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)

        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
          // your code with delay
          alert.dismiss(animated: true, completion: nil)
        }
        
    }
   
    
    func didComplete(goal: Goal, at indexPath: IndexPath) {
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 0.25) {
                self.goalViewModel.complete(true, goal: goal)
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                self.displayAlert()
                self.tableview.deleteRows(at: [indexPath], with: .automatic)
                
            }
        // Here we want to set the completed flag to true in db
    }
}

 
