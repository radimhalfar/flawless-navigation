//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

protocol MasterVIPBusinessLogic {
    func fetchContacts()
    func cancelFetch()
}

protocol MasterVIPDataStore {
    func item(at index: Int) -> InloopContact?
}

final class MasterVIPInteractor: MasterVIPBusinessLogic {
    var presenter: MasterVIPPresentationLogic?

    private var worker = InloopContactsWorker()
    private var items = [InloopContact]()

    func fetchContacts() {
        worker.getContacts { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let contacts):
                self.items = contacts
                self.presenter?.presentContacts(contacts)
            case .failure(let error):
                self.presenter?.presentError(error)
            }
        }
    }

    func cancelFetch() {
        worker.cancelNetworkCall()
    }
}

extension MasterVIPInteractor: MasterVIPDataStore {
    func item(at index: Int) -> InloopContact? {
        guard index < items.count else { return nil }
        return items[index]
    }
}
