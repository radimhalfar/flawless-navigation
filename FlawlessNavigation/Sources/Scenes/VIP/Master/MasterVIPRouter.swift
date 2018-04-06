//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

protocol MasterVIPRoutingLogic {
    func routeToContact(at index: Int)
}

final class MasterVIPRouter: MasterVIPRoutingLogic {
    weak var viewController: MasterVIPViewController?
    var dataStore: MasterVIPDataStore?

    func routeToContact(at index: Int) {
        guard let item = dataStore?.item(at: index),
            let controller = UIStoryboard(name: "DetailVIP", bundle: nil).instantiateInitialViewController() as? DetailVIPViewController
            else { return }
        controller.contact = item
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
