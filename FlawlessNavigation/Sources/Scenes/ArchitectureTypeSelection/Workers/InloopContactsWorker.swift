//  Copyright © 2018 Inloop. All rights reserved.

import UIKit

enum Result<T: Any> {
    case success(T)
    case failure(Error)
}

typealias ContactsResolveClosure = (_ contacts: Result<[InloopContact]>) -> ()

final class InloopContactsWorker {
    private let contactsLocation = "https://inloop-contacts.appspot.com/_ah/api/contactendpoint/v1/contact"
    private let decoder = JSONDecoder()
    private lazy var session = URLSession.shared
    private var task: URLSessionDataTask?

    func getContacts(_ completion: @escaping ContactsResolveClosure) {
        guard let url = URL(string: contactsLocation) else { return }
        let request = URLRequest(url: url)
        task = session.dataTask(with: request) { [weak self] (data, _, error) in
            self?.performOnMain {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            guard let `self` = self, let data = data else {
                completion(
                    .failure(
                        NSError(
                            domain: "Contacts worker",
                            code: -1,
                            userInfo: nil
                        )
                    )
                )
                return
            }
            self.performOnMain {
                self.processContacts(from: data, completion: completion)
            }
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        task?.resume()
    }

    func cancelNetworkCall() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        task?.cancel()
    }

    private func processContacts(from data: Data, completion: @escaping ContactsResolveClosure) {
        do {
            let contacts = try self.decoder.decode(InloopContactsWrapper.self, from: data)
            completion(.success(contacts.items))
        } catch {
            completion(.failure(error))
        }
    }

    private func performOnMain(_ closure: @escaping () -> ()) {
        DispatchQueue.main.async {
            closure()
        }
    }
}
