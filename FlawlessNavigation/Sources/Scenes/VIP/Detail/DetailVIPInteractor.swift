//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

protocol DetailVIPBusinessLogic {
    func getData()
}

final class DetailVIPInteractor: DetailVIPBusinessLogic {
    var presenter: DetailVIPPresentationLogic?
    var item: InloopContact?
    
    func getData() {
        guard let contact = item else { return }
        presenter?.presentContact(contact)
    }
}
