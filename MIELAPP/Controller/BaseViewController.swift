//
//  BaseViewController.swift
//  MIELAPP
//
//  Created by Irina on 13/7/25.
//

import Foundation
import UIKit
import OpenAPIClient

class BaseViewController: UIViewController {
    let supervisorHeader = SupervisorHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(supervisorHeader)
        supervisorHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            supervisorHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            supervisorHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            supervisorHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            supervisorHeader.heightAnchor.constraint(equalToConstant: 72)
        ])
    }
}
