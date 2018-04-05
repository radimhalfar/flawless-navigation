//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

protocol DetailVIPPresentationLogic {
    func presentContact(_ contact: InloopContact)
}

final class DetailVIPPresenter: DetailVIPPresentationLogic {
    weak var viewController: DetailVIPDisplayLogic?

    func presentContact(_ contact: InloopContact) {
        let model = DetailVIP.ViewModel(
            id: contact.id,
            name: contact.name ?? "🤕"
        )
        viewController?.display(viewModel: model)
    }
}
