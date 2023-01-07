//  
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import UIKit

class CharacterDetailsView: UIViewController {

    // OUTLETS HERE

    // VARIABLES HERE
    var viewModel = CharacterDetailsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }
    fileprivate func setupViewModel() {
    }
}
