//  Copyright © 2018 Inloop. All rights reserved.

import Foundation

struct InloopContactsWrapper: Decodable {
    let items: [InloopContact]
}

struct InloopContact: Decodable {
    let id: String
    let name: String?
    let phoneNumber: String?
    let pictureURL: String?
}
