//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import UIKit
import RxSwift
import RxCocoa
class CharacterView: UIViewController,Storyboarded, CharacterViewProtocol {
    @IBOutlet var tableView: UITableView!

    weak var coordinator: CharacterCoordinator?
    var viewModel: CharactersViewModelProtocol?
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerReusableCell(ProductTableViewCell.self)
        setupViewModel()
        // Do any additional setup after loading the view.
    }

    private func setupViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.characters
            .asObservable()
            .bind(to: self.tableView
                    .rx
                    .items(cellIdentifier: String(describing: ProductTableViewCell.self), cellType: ProductTableViewCell.self)) { _, model, cell in
                cell.setupCell(withCharacter: model)
            }.disposed(by: disposeBag)
        tableView.rx.didEndDecelerating.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.tableView.contentOffset.y
            let contentHeight = self.tableView.contentSize.height

            if offSetY > (contentHeight - self.tableView.frame.size.height - 100) {
                viewModel.fetchMoreDatas.onNext(())
            }
        }
        .disposed(by: disposeBag)
        self.tableView
            .rx
            .itemSelected
            .asObservable()
            .subscribe(onNext: { indexPath in
                guard let characterId = self.viewModel?.characters.value[safe: indexPath.row]?.id else { return }
                self.coordinator?.goToDetail(id: characterId)
            })
            .disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
