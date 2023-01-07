//
//  BaseViewType.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import UIKit
protocol BaseViewType {
    func alert(message: String?)
    func popVC()
    func dismiss(completion: (() -> Void)?)
    func presentActivity(activityVC: UIActivityViewController)
}
