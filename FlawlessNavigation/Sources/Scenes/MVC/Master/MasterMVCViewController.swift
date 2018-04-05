//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

final class MasterMVCViewController: UIViewController {
    struct ViewModel {
        let contacts: [String]
        let inloopContacts: [InloopContact]
    }

    @IBOutlet private weak var tableView: UITableView!

    private let worker = InloopContactsWorker()
    private let reuseCellIdentifier = "mvc_master_cell"
    private var viewModel = ViewModel([])

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Master MVC"
        fetchData()
    }

    deinit {
        worker.cancelNetworkCall()
    }

    func fetchData() {
        worker.getContacts { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let contacts):
                self.viewModel = ViewModel(contacts)
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(with: error)
            }
        }
    }
}

extension MasterMVCViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.contacts[indexPath.row]

        return cell
    }
}

extension MasterMVCViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetail(with: viewModel.inloopContacts[indexPath.row])
    }

    private func showDetail(with contact: InloopContact) {
        guard let controller = UIStoryboard(name: "DetailMVC", bundle: nil).instantiateInitialViewController() as? DetailMVCViewController else { return }
        controller.viewModel = DetailMVCViewController.ViewModel(contact: contact)
        show(controller, sender: self)
    }
}

extension MasterMVCViewController.ViewModel {
    init(_ contacts: [InloopContact]) {
        self.contacts = contacts.map { $0.name ?? "👨‍💻" }
        inloopContacts = contacts
    }
}
