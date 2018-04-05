//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

protocol MasterVIPRoutingLogic {
    func routeToContact(at index: Int)
}

final class MasterVIPRouter: MasterVIPRoutingLogic {
    weak var viewController: MasterVIPViewController?
    var dataStore: MasterVIPDataStore?

    func routeToContact(at index: Int) {
        guard let item = dataStore?.item(at: index) else { return }
        // TODO: show detail
    }
}
