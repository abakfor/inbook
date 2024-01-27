//
//  File.swift
//  Ertakchi
//
//

import UIKit

extension Notification.Name {
    static let languageDidChange = Notification.Name("LanguageDidChange")
}

open class BaseViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: .languageDidChange, object: nil)
    }

    @objc func languageDidChange() { }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .languageDidChange, object: nil)
    }
}
