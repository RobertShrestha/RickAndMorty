//
//  CharactersViewModelProtocol.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation
import RxCocoa
import RxSwift
protocol CharactersViewModelProtocol {
    var characters: BehaviorRelay<[CharacterModel]>{get set}
    var fetchMoreDatas: PublishSubject<Void>{ get set }
}
