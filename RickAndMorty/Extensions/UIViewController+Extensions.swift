//
//  UIViewController+Extensions.swift
//  TingTing
//
//  Created by Aximpro Innovations GmbH on 12/29/20.
//
import UIKit
import MBProgressHUD
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
    private func setProgressHud() -> MBProgressHUD {
        let progressHud: MBProgressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        // progressHud.tintColor = UIColor.darkGray
        progressHud.removeFromSuperViewOnHide = true
        progressHud.mode = .indeterminate
        progressHud.animationType = .fade
        progressHud.contentColor = .lightGray
        // progressHud.label.textColor = .darkGray
        objc_setAssociatedObject(self, &Associate.hud, progressHud, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return progressHud
    }
    var progressHud: MBProgressHUD {
        if let progressHud = objc_getAssociatedObject(self, &Associate.hud) as? MBProgressHUD {
            progressHud.isUserInteractionEnabled = true
            return progressHud
        }
        return setProgressHud()
    }
    var progressHudIsShowing: Bool {
        return self.progressHud.isHidden
    }
    func showProgressHud() {
        DispatchQueue.main.async {
            self.progressHud.show(animated: false)
        }
    }
    func showProgressHud(label: String = "") {
        self.progressHud.label.text = label
        self.progressHud.show(animated: false)
    }
    func hideProgressHud() {
        DispatchQueue.main.async {
            self.progressHud.label.text = ""
            self.progressHud.completionBlock = {
                objc_setAssociatedObject(self, &Associate.hud, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            self.progressHud.hide(animated: false)
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
    /// Navigation Bar item with back button
    /// - Parameter tapped: button action tapped  closure
    func setNavigationBarBackButtonLeftItems(tapped:@escaping ( () -> Void )) {
        let sideMenu = UIButton(frame: CGRect(x: 40, y: 40, width: 25, height: 25))
        sideMenu.setImage(#imageLiteral(resourceName: "BackIcon"), for: .normal)
        sideMenu.addAction(action: tapped)
        self.view.addSubview(sideMenu)
    }

    func setNavigationBarRightItems(withTitle title: String, tapped:@escaping ( () -> Void )) {
        let sideMenu = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        sideMenu.setTitle(title, for: .normal)
        sideMenu.addAction(action: tapped)
        let sideMenuButtonItem = UIBarButtonItem(customView: sideMenu)
        self.navigationItem.rightBarButtonItems = [sideMenuButtonItem]
    }

    func setNavigationBarRightItems(tapped:@escaping ( () -> Void )) {
        let notificationButton =  UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        notificationButton.setImage(#imageLiteral(resourceName: "NotificationIcon"), for: .normal)
        notificationButton.addAction(action: tapped)
        let notificationButtonItem = UIBarButtonItem(customView: notificationButton)
        self.navigationItem.setRightBarButton(notificationButtonItem, animated: true)
    }
    func setEditBarRightItems(tapped:@escaping ( () -> Void )) {
        let notificationButton =  UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        notificationButton.setImage(#imageLiteral(resourceName: "EditIcon"), for: .normal)
        notificationButton.addAction(action: tapped)
        let notificationButtonItem = UIBarButtonItem(customView: notificationButton)
        self.navigationItem.setRightBarButton(notificationButtonItem, animated: true)
    }
    func setAddBarRightItems(tapped:@escaping ( () -> Void )) {
        let notificationButton =  UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        notificationButton.setImage(#imageLiteral(resourceName: "ChevronRightIcon"), for: .normal)
        notificationButton.addAction(action: tapped)
        let notificationButtonItem = UIBarButtonItem(customView: notificationButton)
        self.navigationItem.setRightBarButton(notificationButtonItem, animated: true)
    }
    func hideNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    /// Show alert to direct to access to setting
    /// - Parameter completionHandler: Bool if the access is given or not
    func showSettingsAlert(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        DispatchQueue.main.async {
            let message = "This app requires access to Contacts to proceed.These can be configured in Settings.".localized()
            let alert = UIAlertController(title: nil,
                                          message: message.localized(),
                                          preferredStyle: .alert)
            if
                let settings = URL(string: UIApplication.openSettingsURLString),
                UIApplication.shared.canOpenURL(settings) {
                alert.addAction(UIAlertAction(title: "Open Settings".localized(), style: .default) { _ in
                    completionHandler(false)
                    UIApplication.shared.open(settings)
                })
            }
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel) { _ in
                completionHandler(false)
            })
            self.present(alert, animated: true)
        }
    }
    /// Share diaglog
    /// - Parameters:
    ///   - linkString: string of link that need to be shared
    ///   - view: View in which the pop up will appear
    func showShareDialog(withLink linkString: String, title: String, view: UIView) {
        // Setting url
        let shareActivityItem: NSURL = NSURL(string: linkString)!
        let title = title
        // let shareActivityItem: String = linkString // NSURL(string: linkString)!
        // If you want to use an image
        let activityViewController: UIActivityViewController = UIActivityViewController(
            activityItems: [title, shareActivityItem], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        // Pre-configuring activity items
    if #available(iOS 13.0, *) {
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        activityViewController.isModalInPresentation = true
    } else {
        activityViewController.modalPresentationStyle = .fullScreen
    }
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
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
