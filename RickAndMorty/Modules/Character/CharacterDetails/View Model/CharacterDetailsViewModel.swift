//  
//  CharacterDetailsViewModel.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation
import RxSwift
import RxCocoa
class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    // MARK: - Variables declaration
    weak var viewType: CharacterDetailsViewProtocol?

    private let service: CharacterDetailsServiceProtocol

    /// Define networkStatus for check network connection
    var networkStatus = Reach().connectionStatus()
    var characterId: Int
    var character = BehaviorRelay<CharacterModel?>(value: nil)
    var disposeBag = DisposeBag()
    var bookMarkedButtonTapped = PublishSubject<Void>()
    var isBookmarked = BehaviorRelay<Bool>(value: false)

    // MARK: - Initialization Method
    init(withCharacterDetails serviceProtocol: CharacterDetailsServiceProtocol, characterId: Int ) {
        self.service = serviceProtocol
        self.characterId = characterId
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.networkStatusChanged(_:)),
                                               name: NSNotification
                                                .Name(rawValue: ReachabilityStatusChangedNotification),
                                               object: nil)
        Reach().monitorReachabilityChanges()
        Task {
            await self.getCharacter()
        }
        binding()
    }

    func binding() {
        self.bookMarkedButtonTapped.asObserver().subscribe(onNext: {
            self.bookMarkProduct()
            var value = self.isBookmarked.value
            value.toggle()
            self.isBookmarked.accept(value)
        }).disposed(by: disposeBag)
    }

    func getBookmarkInfo() {
        guard let model = self.character.value else { return }
        let bookMarked = self.service.getCharacterBookmark(model: model)
        self.isBookmarked.accept(bookMarked)
    }
    func bookMarkProduct() {
        guard let model = self.character.value else { return }
        if self.isBookmarked.value {
            self.service.removeCharacter(model: model)
        } else {
            self.service.addCharacter(model: model)
        }
    }

    // MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    func getCharacter() async {
        guard let url = URLBuilder()
                .setPath(paths: .character)
                .setIdPath(id: "\(characterId)")
                .build() else { return }
        var resource = Resource<CharacterModel>(url: url)
        resource.httpMethod = HTTPMethod.get
        do {
            let characterModel = try await self.service.getCharacter(resource: resource)
            self.character.accept(characterModel)
            getBookmarkInfo()
        } catch let error {
            print(error)
            self.viewType?.alert(message: error.localizedDescription)
        }

    }
}

extension CharacterDetailsViewModel {

}
