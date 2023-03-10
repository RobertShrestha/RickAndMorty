//
//  UITableView+Extension.swift
//  TingTing
//
//  Created by Aximpro Innovations GmbH on 12/29/20.
//
import UIKit
// Useful link
// https://alisoftware.github.io/swift/generics/2016/01/06/generic-tableviewcells/
//https://medium.com/over-engineering/an-easier-way-to-dequeue-cells-in-ios-5c8b8de4dfed

// MARK: - UITableview Extensions
// swiftlint:disable force_cast
let fileTypeNib = "nib"

extension NSObject {
    static func fileExists(at path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
}

extension UINib {
    static func nibExists(nibName: String) -> Bool {
        guard let path = Bundle.main.path(forResource: nibName, ofType: fileTypeNib) else {
            return false
        }
        return fileExists(at: path)
    }
}

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: Self.self) }
    static var nib: UINib? {
        if UINib.nibExists(nibName: reuseIdentifier) {
            return UINib(nibName: reuseIdentifier, bundle: nil)
        } else {
            return nil
        }
    }
}

extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: Reusable {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension UICollectionView {
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    func registerReusableSupplementaryView<T: Reusable>(elementKind: String, _: T.Type) {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(elementKind: String,
                                                                   indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier,
                                                     for: indexPath) as! T
    }
}
extension UITableView {
  func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
    return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
  }

  func scrollToTop(animated: Bool) {
    let indexPath = IndexPath(row: 0, section: 0)
    if self.hasRowAtIndexPath(indexPath: indexPath) {
      self.scrollToRow(at: indexPath, at: .top, animated: animated)
    }
  }
}
extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
    func decoded<T: Decodable>() -> T {
        do {
            let decode =  try JSONDecoder().decode(T.self, from: self)
            print(decode)
        } catch let error {
            print(error)
        }
        guard let decode =  try? JSONDecoder().decode(T.self, from: self) else {
            fatalError()
        }
        return decode
    }
}
extension Encodable {
    func toData() -> Data? {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(self)
            return encoded
        } catch let error {
            print(error)
            return nil
        }

    }
}
