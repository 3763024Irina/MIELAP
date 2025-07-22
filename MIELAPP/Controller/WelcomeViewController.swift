//
//  WelcomeViewController.swift
//  MIELAPP
//
//  Created by Irina on 18/7/25.
//

import Foundation
import UIKit
import AnyCodable
final class WelcomeViewController: UIViewController {
    private let logoImageView = UIImageView(image: UIImage(named: "logo"))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupLogo()
        print("WelcomeViewController открыт")

    }
    
    private func setupGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1).cgColor, // #960047
            UIColor(red: 48/255, green: 0, blue: 23/255, alpha: 1).cgColor   // #300017
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupLogo() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.alpha = 1 // opacity
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 340),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120)
        ])
        // Если понадобится поворот:
        logoImageView.transform = CGAffineTransform(rotationAngle: 0)
    }
}
