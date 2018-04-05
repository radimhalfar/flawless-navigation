//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

protocol MasterVIPDisplayLogic: class {
    func display(viewModel: MasterVIP.ViewModel)
    func display(error: Error)
}

final class MasterVIPViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private var interactor: MasterVIPBusinessLogic?
    private var router: MasterVIPRoutingLogic?
    private var viewModel = MasterVIP.ViewModel(contactNames: [])
    private var reuseCellIdentifier = "vip_master_cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationItem.title = "Master VIP"
        interactor?.fetchContacts()
    }

    deinit {
        interactor?.cancelFetch()
    }
}

extension MasterVIPViewController: MasterVIPDisplayLogic {
    func display(viewModel: MasterVIP.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }

    func display(error: Error) {
        showAlert(with: error)
    }
}

extension MasterVIPViewController {
    fileprivate func setup() {
        let viewController = self
        let interactor = MasterVIPInteractor()
        let presenter = MasterVIPPresenter()
        let router = MasterVIPRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension MasterVIPViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.contactNames[indexPath.row]

        return cell
    }
}

extension MasterVIPViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToContact(at: indexPath.row)
    }
}
