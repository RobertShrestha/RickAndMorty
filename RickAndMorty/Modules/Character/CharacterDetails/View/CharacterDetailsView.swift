//  
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import UIKit
import RxSwift

class CharacterDetailsView: UIViewController, Storyboarded, CharacterDetailsViewProtocol {

    // OUTLETS HERE
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var SpeciesLabel: UILabel!

    @IBOutlet var addToBookMark: UIButton!
    // VARIABLES HERE
    var viewModel: CharacterDetailsViewModelProtocol?
    var disposeBag = DisposeBag()
    weak var coordinator: CharacterCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }
    fileprivate func setupViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.isBookmarked.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            var title = ""
            if $0 {
                title = "Remove bookmark"
            } else {
                title = "Add bookmark"
            }
            DispatchQueue.main.async {
                self.addToBookMark.setTitle(title, for: .normal)
            }

        }).disposed(by: disposeBag)
        self.addToBookMark
            .rx
            .tap
            .bind(to: viewModel.bookMarkedButtonTapped)
            .disposed(by: disposeBag)
        viewModel.character.subscribe(onNext: { [weak self] character in
            guard let self = self , let character = character else { return }
            DispatchQueue.main.async {
                self.nameLabel.text = character.name
                self.statusLabel.text = character.status?.rawValue
                self.genderLabel.text = character.gender?.rawValue
                self.SpeciesLabel.text = character.location?.name
                guard let urlString = character.image, let imageURL = URL(string: urlString) else { return }
                self.imageView.sd_setImage(with: imageURL)
            }
        }).disposed(by: disposeBag)
    }
}
