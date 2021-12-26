//
//  CompletedGoalViewController.swift
//  ListApp
//
//  Created by tobi adegoroye on 24/03/2021.
//

import UIKit
import CoreData


class CompletedGoalViewController: UIViewController {
    
    private var goalViewModel: GoalViewModel!
    
    init(){
        super.init(nibName: nil, bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        goalViewModel = GoalViewModel(context: context)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.separatorStyle = .none
        tableview.backgroundColor =  Colour.background
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 44
        tableview.register(CompletedGoalTableViewCell.self, forCellReuseIdentifier: CompletedGoalTableViewCell.cellID)
        return tableview
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["active","completed"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(selectedTab), for: .valueChanged)
        return segmentedControl
    }()
    
    
    @objc func selectedTab(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
           case 0 :
            let vc = HomeViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.navigationItem.hidesBackButton = true
            navigationController?.pushViewController(vc, animated: true)
           case 1:
            let vc = CompletedGoalViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.navigationItem.hidesBackButton = true
            navigationController?.pushViewController(vc, animated: true)
            default:
            break
            }
        }
 
    
    @objc func add(){
        let formVC = FormViewController(sharedDBInstance: DatabaseManager.shared)
        formVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(formVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        setupView()
        
        navigationController?.navigationBar.barTintColor =  Colour.background
     }
 
    
    func setupView() {
        view.backgroundColor = Colour.lightGrey
<<<<<<< HEAD

=======
        view.addSubview(tableview)
        view.addSubview(segmentedControl)
>>>>>>> feature/newDesign
        
        NSLayoutConstraint.activate([
            
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            tableview.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        goalViewModel.goalList = goalViewModel.getAllCompletedGoal()
//         tableview.reloadData()
    }
}

extension CompletedGoalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return   goalViewModel.goalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let completedGoal = goalViewModel.goalList[indexPath.row]
        let cell = tableview.dequeueReusableCell(withIdentifier: CompletedGoalTableViewCell.cellID,for: indexPath) as? CompletedGoalTableViewCell
        cell?.configure(completedGoal: completedGoal, isTap: goalViewModel.doesExist(item: completedGoal), indexPath: indexPath, delegate: self)
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        cell?.backgroundColor = .clear
        return cell!
    }
}

extension CompletedGoalViewController: CompletedGoalTableViewCellDelegate {
    func undo(completedGoal goal: Goal, at indexPath: IndexPath) {
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 0.25) {
                self.goalViewModel.undo(false, completedGoal: goal)
                self.tableview.deleteRows(at: [indexPath], with: .automatic)
            }
    }
}



