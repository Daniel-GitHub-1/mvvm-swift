//
//  BaseViewController.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import UIKit

protocol ControllerType {
    var navigationTitle: String { get }
}

extension ControllerType {
    var navigationTitle: String {
        return ""
    }
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        if let controller = self as? ControllerType {
            self.title = controller.navigationTitle
        }
    }
}
