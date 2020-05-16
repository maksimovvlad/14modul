import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var familyTextField: UITextField!
    
    @IBAction func nameChanged(_ sender: Any) {
        UserDefaults1.shared.userName = nameTextField.text!
        UserDefaults1.shared.userFamily = familyTextField.text!
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField?.text = UserDefaults1.shared.userName ?? nil
        familyTextField?.text = UserDefaults1.shared.userFamily ?? nil
    }
}

