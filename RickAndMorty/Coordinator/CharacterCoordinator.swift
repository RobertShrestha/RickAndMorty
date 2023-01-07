//
//  CharacterCoordinator.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import UIKit
class CharacterCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    /// Initialization of coordinator
    /// - Parameter navController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    /// Start function
    func start() {
        let client = WebServices.shared
        let service = CharactersService(client: client, storageClient: nil)
        let viewModel = CharactersViewModel(withService: service)
        let viewController = CharacterView.instantiate()
        viewController.coordinator = self
        viewController.viewModel = viewModel
        viewModel.viewType = viewController
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToDetail(id: Int) {
        let client = WebServices.shared
        let storageClient = StorageClient(storage: UserDefaultStorage(characters: []))
        let service = CharacterDetailsService(client: client, storageClient: storageClient)
        let viewModel = CharacterDetailsViewModel(withCharacterDetails: service, characterId: id)
        let viewController = CharacterDetailsView.instantiate()
        viewController.coordinator = self
        viewController.viewModel = viewModel
        viewModel.viewType = viewController
        navigationController.pushViewController(viewController, animated: true)
    }

//    func goToDashboard() {
//        let coordinator = DashboardTabBarCoordinator(navigationController: navigationController)
//        coordinator.parenetCoordinator = self
//        self.childCoordinators.append(coordinator)
//        coordinator.start()
//    }
    /// remove child
    /// - Parameter child: Coordinator
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
