//  Copyright © 2018 Inloop. All rights reserved.

import Foundation

struct DetailViewModel {
    let id: String
    let name: String

    init(contact: InloopContact) {
        id = contact.id
        name = contact.name ?? "🎉"
    }
}
