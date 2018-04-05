//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

final class MasterMVVMViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = MasterViewModel()
    private let reuseCellIdentifier = "mvvm_master_cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Master MVVM"
        fetchData()
    }

    deinit {
        viewModel.cancelDataFetch()
    }

    func fetchData() {
        viewModel.getItems { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success:
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(with: error)
            }
        }
    }
}

extension MasterMVVMViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.titleForItem(at: indexPath.row)

        return cell
    }
}

extension MasterMVVMViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let contact = viewModel.contactForItem(at: indexPath.row) else { return }
        showDetail(with: contact)
    }

    private func showDetail(with contact: InloopContact) {
        guard let controller = UIStoryboard(name: "DetailMVVM", bundle: nil).instantiateInitialViewController() as? DetailMVVMViewController else { return }
        controller.viewModel = DetailViewModel(contact: contact)
        show(controller, sender: self)
    }
}
