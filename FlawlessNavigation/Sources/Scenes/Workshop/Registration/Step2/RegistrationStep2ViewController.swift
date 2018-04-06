//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

final class RegistrationStep2ViewController: UIViewController {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBOutlet private weak var nameTextField: UITextField!

    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
        dataHolder?.name = nameTextField.text
        let controller = UIStoryboard(name: "RegistrationStep3", bundle: nil).instantiateInitialViewController() as! RegistrationStep3ViewController
        controller.dataHolder = dataHolder
        navigationController!.pushViewController(controller, animated: true)
    }

    var dataHolder: RegistrationDataHolder!
}

extension RegistrationStep2ViewController: UITextFieldDelegate {
    override func viewDidLoad() {
        print("View is loaded")
    }
}

