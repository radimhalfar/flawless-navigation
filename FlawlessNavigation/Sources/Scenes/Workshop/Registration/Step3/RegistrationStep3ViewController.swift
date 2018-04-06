//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

final class RegistrationStep3ViewController: UIViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    var dataHolder: RegistrationDataHolder!
}

extension RegistrationStep3ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegistrationStep3ViewController {
    @IBAction func submitPressed() {
        let controller = UIAlertController(title: "😋", message: "🤪 Fix me if you can!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "👾", style: .destructive, handler: nil))
        show(controller, sender: nil)
    }
}
