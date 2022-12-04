//
//  InstagramManager.swift
//  ShadShopManager
//
//  Created by Kirill on 15.06.2021.
//

import UIKit
import SwiftyInsta

enum InstagramError: Error {
    case loginError
}

final class InstagramManager {
    static let shared = InstagramManager()
    
    var credential: Credentials!
    var handler = APIHandler()

    private var userTags: Dictionary<String, DynamicResponse>!
    
    private(set) var instaKey: String

    private init() {
        instaKey = ""
    }

    var isChached: Bool {

        return true
    }

    var cache: Authentication.Response? {
        guard let key = UserDefaults.standard.string(forKey: "current.account") else { return nil }
        return Authentication.Response.persisted(with: key)
    }

    func upload(image: Image) {
        handler.media.upload(photo: .init(image: image, caption: "SwiftyInsta", disableComments: false, size: .zero), completionHandler: { response in
            switch response {
            case .success(let s):
//                var tt = s
//                var gg = tt.media?.rawResponse.fbUserTags.dictionary
//                let tags = User.Tags(from: gg)
//                print(tt)
//                handler.settings.
//                s.media?.rawResponse.fbUserTags.
                DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                    self.handler.media.edit(media: s.media!.identity.identifier!, caption: "Димас лох))", tags: User.Tags(adding: [], removing: []), completionHandler: { response1 in
                        print(response1)
                    })
                })
                
                print("Great w")
            case .failure(let error):
                print("Fifi")
            }
        })
    }

//    func edit(text: String) {
//        handler.media.edit(media: "2596816355888950658", caption: "Test edit )))))", tags: User.Tags(adding: [], removing: []), completionHandler: {result in
//            switch result {
//            case .success(let success):
//                print(success)
//            case .failure(let fuck):
//                print(fuck)
//            }
//        })
//    }

    func login(completion: @escaping(Result<Authentication.Response, Error>) -> Void) {
        guard let topVC = UIApplication.shared.windows.first?.topViewController() else { return }
        let loginVC = LoginWebViewController { controller, result in
            controller.dismiss(animated: true, completion: nil)
            // deal with authentication response.
            
            guard let (response, _) = try? result.get() else { return print("Login failed.") }
            print("Login successful.")
            // persist cache safely in the keychain for logging in again in the future.
            guard let key = response.persist() else { return print("`Authentication.Response` could not be persisted.") }
            // store the `key` wherever you want, so you can access the `Authentication.Response` later.
            // `UserDefaults` is just an example.
            self.instaKey = key
            UserDefaults.standard.set(key, forKey: "current.account")
            UserDefaults.standard.synchronize()
            self.login(with: response, completion: completion)
        }
        topVC.present(loginVC, animated: true, completion: nil)
    }

    func login(with cache: Authentication.Response, completion: @escaping(Result<Authentication.Response, Error>) -> Void) {
        handler.authenticate(with: .cache(cache), completionHandler: {result in
            switch result {
            case .success(let response):
                completion(.success(response.0))
            case .failure(let error):
                print("Error")
                completion(.failure(error))
            }
        })
    }
}
