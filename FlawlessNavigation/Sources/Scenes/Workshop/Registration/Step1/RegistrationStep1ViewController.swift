//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

final class RegistrationStep1ViewController: UIViewController {
    public let dataHolder = RegistrationDataHolder()
    @IBOutlet weak var emailTextField: UITextField!
}

extension RegistrationStep1ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegistrationStep1ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showStep2"?:
            dataHolder.email = emailTextField.text
            let destination = segue.destination as! RegistrationStep2ViewController
            destination.dataHolder = dataHolder
        default: break
        }
    }
}
