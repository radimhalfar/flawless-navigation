//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

protocol DetailVIPDisplayLogic: class {
    func display(viewModel: DetailVIP.ViewModel)
}

final class DetailVIPViewController: UIViewController, DetailVIPDisplayLogic {
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!

    var interactor: DetailVIPBusinessLogic?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.getData()
    }

    func display(viewModel: DetailVIP.ViewModel) {
        idLabel.text = viewModel.id
        nameLabel.text = viewModel.name
    }
}

extension DetailVIPViewController {
    private func setup() {
        let viewController = self
        let interactor = DetailVIPInteractor()
        let presenter = DetailVIPPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
