//
//  BaseViewController.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import UIKit

// MARK: - BaseViewController
class BaseViewController: UIViewController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Methods
    private func configure() {
        self.view.backgroundColor = UIColor.DS.Background.primary
    }
    
    // MARK: - @OBJC METHODS
    @objc func baseEndEditing() {
        self.view.endEditing(true)
    }
}
