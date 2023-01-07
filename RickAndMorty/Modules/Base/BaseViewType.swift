//
//  BaseViewType.swift
//  TingTing
//
//  Created by Aximpro Innovations GmbH on 1/7/21.
//
import UIKit
protocol BaseViewType {
    func showProgressHud()
    func showProgressHud(label: String)
    func hideProgressHud()
    func alert(message: String?)
    func alert(message: String?, title: String?, okAction: (() -> Void)?)
    // swiftlint:disable line_length function_parameter_count
    func alertWithOkCancel(message: String?, title: String?, okTitle: String?, cancelTitle: String?, cancelStyle: UIAlertAction.Style, okAction: (() -> Void)?, cancelAction: (() -> Void)?)
    func popVC()
    func dismiss(completion: (() -> Void)?)
    func presentActivity(activityVC: UIActivityViewController)
    func alertWithMessageAndTitle(message: String?, title: String?)
    func showShareDialog(withLink linkString: String, title: String, view: UIView)
}
