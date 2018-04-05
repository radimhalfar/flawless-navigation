//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

final class DetailMVVMViewController: UIViewController {
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!

    var viewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail MVVM"
        displayModel()
    }

    private func displayModel() {
        idLabel.text = viewModel.id
        nameLabel.text = viewModel.name
    }
}
