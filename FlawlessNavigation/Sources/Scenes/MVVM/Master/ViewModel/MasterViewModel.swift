//  Copyright © 2018 Inloop. All rights reserved.

import Foundation

final class MasterViewModel {
    struct Item {
        let name: String
    }

    private var names = [Item]()
    private var contacts = [InloopContact]()
    private let worker = InloopContactsWorker()

    func getItems(completion: @escaping (Result<[Item]>) -> Void) {
        worker.getContacts { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let contacts):
                self.contacts = contacts
                self.names = contacts.map { $0.name ?? "🎉" }.map(Item.init(name:))
                completion(.success(self.names))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    var numberOfItems: Int {
        return names.count
    }

    func titleForItem(at index: Int) -> String? {
        guard index < names.count else { return nil }
        return names[index].name
    }

    func contactForItem(at index: Int) -> InloopContact? {
        guard index < contacts.count else { return nil }
        return contacts[index]
    }

    func cancelDataFetch() {
        worker.cancelNetworkCall()
    }
}
