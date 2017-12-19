//
//  AnalysingViewController.swift
//  iSeeDoughnuts
//
//  Created by Sam Rayner on 18/12/2017.
//  Copyright © 2017 The Floow. All rights reserved.
//

import UIKit

class AnalysingViewController: UIViewController {
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!

    var screenToPresent: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        var images : [UIImage] = []
        for number in 1...7 {
            let image = UIImage(named: "loading_animation_0\(number)")!
            images.append(image)
        }

        imageView.image = UIImage.animatedImage(with: images, duration: 0.8)
        imageView.layer.cornerRadius = 30

        let messages: [String] = [
            "Our data scientists are working hard right now",
            "Your query is important to us",
            "Hold the line, we'll be with you shortly"
        ]

        let randomIndex = Int(arc4random_uniform(UInt32(messages.count)))
        textLabel.text = messages[randomIndex]

        perform(#selector(presentScreen), with: nil, afterDelay: 3)
    }

    @objc func presentScreen() {
        let board = UIStoryboard(name: "RightWrong", bundle: nil)
        let viewController = board.instantiateViewController(withIdentifier: screenToPresent)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
