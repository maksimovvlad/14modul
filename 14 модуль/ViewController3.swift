//
//  ViewController3.swift
//  14 модуль
//
//  Created by Vladislav on 08.05.2020.
//  Copyright © 2020 Vladislav. All rights reserved.
//

import UIKit
import CoreData

class ViewController3: UIViewController {
    
    let persistentContainer = NSPersistentContainer(name: "CoreData")
    
    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var todoTextField: UITextField!
    @IBAction func taskTextField(_ sender: Any) {
            
    }
        
    @IBAction func addButton(_ sender: Any) {
        addTask()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data Stack: \(error)")
            }
        }
        DispatchQueue.main.async {
             self.tableView.reloadData()
        }
    }

    func addTask() {
        persistentContainer.performBackgroundTask { context in
            let task = NSEntityDescription.insertNewObject(forEntityName: "Tasks", into: context) as? Tasks
            DispatchQueue.main.async {
                task?.taskName = self.todoTextField.text
            }
            try? context.save()
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
        }
    }
    
    func allTasks() -> [Tasks] {
        let viewContext = persistentContainer.viewContext
        let tasksFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        let tasks = try? viewContext.fetch(tasksFetch) as? [Tasks]
        return tasks ?? []
    }

}
    

    extension ViewController3: UITableViewDataSource {
       
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return allTasks().count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
            
            let todo = allTasks()[indexPath.row]
            cell.todoLabel?.text = todo.taskName
            
            return cell
        }
    }
