//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

extension UIViewController {
    func showAlert(with error: Error) {
        let alertController = UIAlertController(title: "Error occured", message: "", preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil
            )
        )
        present(alertController, animated: true, completion: nil)
    }
}
