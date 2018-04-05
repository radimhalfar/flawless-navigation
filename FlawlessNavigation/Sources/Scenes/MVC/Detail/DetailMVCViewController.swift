//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

final class DetailMVCViewController: UIViewController {
    struct ViewModel {
        let id: String
        let name: String
    }

    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!

    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail MVC"
        displayModel()
    }

    private func displayModel() {
        idLabel.text = viewModel.id
        nameLabel.text = viewModel.name
    }
}

extension DetailMVCViewController.ViewModel {
    init(contact: InloopContact) {
        id = contact.id
        name = contact.name ?? "👨‍💻"
    }
}
