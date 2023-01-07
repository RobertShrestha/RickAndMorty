//
//  UIViewController+Extensions.swift
//  TingTing
//
//  Created by Aximpro Innovations GmbH on 12/29/20.
//
import UIKit
extension UIViewController {
    open override func awakeFromNib() {
        // swiftlint:disable line_length
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Constants.back, style: .plain, target: nil, action: nil)
    }
    func getAlert(message: String?, title: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    func alert(message: String?) {
        DispatchQueue.main.async {
            let alertController = self.getAlert(message: message, title: nil)
            alertController.addAction(title: Constants.labelOk, handler: nil)
            alertController.modalPresentationStyle = .fullScreen
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func alertWithMessageAndTitle(message: String?, title: String?) {
        DispatchQueue.main.async {
            let alertController = self.getAlert(message: message, title: title)
            alertController.addAction(title: Constants.labelOk, handler: nil)
            alertController.modalPresentationStyle = .fullScreen
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func alert(message: String?, title: String? = "", okAction: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = self.getAlert(message: message, title: title)
            alertController.addAction(title: Constants.labelOk, handler: okAction)
            alertController.modalPresentationStyle = .fullScreen
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func alertWithOkCancel(message: String?, title: String? = "", okTitle: String? = Constants.labelOk, cancelTitle: String? = Constants.cancel, cancelStyle: UIAlertAction.Style = .default, okAction: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = self.getAlert(message: message, title: title)
            alertController.addAction(title: okTitle, handler: okAction)
            alertController.addAction(title: cancelTitle, style: cancelStyle, handler: cancelAction)
            alertController.modalPresentationStyle = .fullScreen
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func setupBackButton() {
        let customBackButton = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = customBackButton
    }
    func popVC() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func dismiss(completion: (() -> Void)?) {
        self.dismiss(animated: true, completion: completion)
    }
    func presentActivity(activityVC: UIActivityViewController) {
        self.present(activityVC, animated: true, completion: nil)
    }
}
struct Associate {
    static var hud: UInt8 = 0
}
// swiftlint:disable all
extension UINavigationController {

    override open var shouldAutorotate: Bool {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.shouldAutorotate
            }
            return super.shouldAutorotate
        }
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.preferredInterfaceOrientationForPresentation
            }
            return super.preferredInterfaceOrientationForPresentation
        }
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.supportedInterfaceOrientations
            }
            return super.supportedInterfaceOrientations
        }
    }
}
extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    //Set title font and title color
    func setTitlet(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                          range: NSMakeRange(0, title.utf8.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                          range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
    
    //Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    
    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
}
extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}
extension UIAlertController {
    func addAction(title: String?, style: UIAlertAction.Style = .default, handler: (() -> Void)? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: {_ in
            handler?()
        })
        self.addAction(action)
    }
}
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
