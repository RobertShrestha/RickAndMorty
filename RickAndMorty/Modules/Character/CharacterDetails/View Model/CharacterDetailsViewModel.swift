//  
//  CharacterDetailsViewModel.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation

class CharacterDetailsViewModel {
    // MARK: - Variables declaration
    weak var viewType: CharacterDetailsViewProtocol?

    private let service: CharacterDetailsServiceProtocol

    private var model: [CharacterDetailsModel] = [CharacterDetailsModel]() {
        didSet {
            self.count = self.model.count
        }
    }

    /// Count your data in model
    var count: Int = 0

    // MARK: - Network checking

    /// Define networkStatus for check network connection
    var networkStatus = Reach().connectionStatus()

    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.viewType?.alert(message: Constants.noInternetConnection)
        }
    }
    // MARK: - Initialization Method
    init(withCharacterDetails serviceProtocol: CharacterDetailsServiceProtocol = CharacterDetailsService() ) {
        self.service = serviceProtocol

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.networkStatusChanged(_:)),
                                               name: NSNotification
                                                .Name(rawValue: ReachabilityStatusChangedNotification),
                                               object: nil)
        Reach().monitorReachabilityChanges()

    }

    // MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }

    // MARK: - Example Func
    func exampleBind() {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
        case .online:
            // call your service here
        default:
            break
        }
    }
}

extension CharacterDetailsViewModel {

}
