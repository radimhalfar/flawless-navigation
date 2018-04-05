//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

protocol MasterVIPPresentationLogic {
    func presentContacts(_ contacts: [InloopContact])
    func presentError(_ error: Error)
}

final class MasterVIPPresenter: MasterVIPPresentationLogic {
  weak var viewController: MasterVIPDisplayLogic?

    func presentContacts(_ contacts: [InloopContact]) {
        let contactNames = contacts.map { $0.name ?? "👤" }
        let model = MasterVIP.ViewModel(contactNames: contactNames)
        viewController?.display(viewModel: model)
    }

    func presentError(_ error: Error) {
        viewController?.display(error: error)
    }
}
