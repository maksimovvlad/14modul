import UIKit
import RealmSwift

class ViewController2: UIViewController {
    
    let realm = try! Realm()
    var allTasks : Results<Todo>!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var todoTextField: UITextField!
    @IBAction func taskTextField(_ sender: Any) {
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        let newTask = Todo()
        newTask.taskName = todoTextField.text!
        
        try! realm.write {
            realm.add(newTask)
        }
        
        allTasks = realm.objects(Todo.self)
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        allTasks = realm.objects(Todo.self)
        self.tableView.reloadData()
    }
}

extension ViewController2: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        let tasks = allTasks[indexPath.row]
        cell.todoLabel?.text = tasks.taskName
        
        return cell
    }
}
