//  
//  CharacterDetailsViewModelProtocol.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol CharacterDetailsViewModelProtocol {
    var character: BehaviorRelay<CharacterModel?>{ get set }
    var bookMarkedButtonTapped: PublishSubject<Void>{get set}
    var isBookmarked: BehaviorRelay<Bool> {get set}
}
