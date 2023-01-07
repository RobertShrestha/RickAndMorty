//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation
import RxCocoa
import RxSwift

class CharactersViewModel: CharactersViewModelProtocol {
    var fetchMoreDatas = PublishSubject<Void>()

    private let service: CharactersServiceProtocol
    weak var viewType: CharacterViewProtocol?
    var characters = BehaviorRelay<[CharacterModel]>(value: [])

    var currentPage = 1
    var canLoadMorePages = true

    /// Define networkStatus for check network connection
    var networkStatus = Reach().connectionStatus()
    var disposeBag = DisposeBag()

    // MARK: - Initialization Method
    init(withService serviceProtocol: CharactersServiceProtocol) {
        self.service = serviceProtocol

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.networkStatusChanged(_:)),
                                               name: NSNotification
                                                .Name(rawValue: ReachabilityStatusChangedNotification),
                                               object: nil)
        Reach().monitorReachabilityChanges()
        Task {
            await getCharacters()
        }
        bind()
    }
    // MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    private func bind() {
        fetchMoreDatas.subscribe { [weak self] _ in
            guard let self = self else { return }
            Task {
              await self.getCharacters()
            }
        }
        .disposed(by: disposeBag)
    }
    func getCharacters() async {
        guard let url = URLBuilder()
                .setPath(paths: .character)
                .addPageCount(withPage: currentPage)
                .build() else { return }
        var resource = Resource<CharacterResponseModel>(url: url)
        resource.httpMethod = HTTPMethod.get
        do {
            let characterModel = try await self.service.getCharacters(resource: resource)
            if currentPage == 1 {
                self.characters.accept([])
            }
            self.characters.accept(characters.value + (characterModel.results ?? []))
            if characterModel.info?.count == characters.value.count {
                canLoadMorePages = false
                return
            }
            currentPage += 1
            } catch let error {
                print(error)
                self.viewType?.alert(message: error.localizedDescription)
            }

    }
}
