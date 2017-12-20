//
//  AnalysingViewController.swift
//  iSeeDoughnuts
//
//  Created by Sam Rayner on 18/12/2017.
//  Copyright © 2017 The Floow. All rights reserved.
//

import UIKit
import Vision

extension Array {
    func random() -> Element {
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
}

class AnalysingViewController: UIViewController {
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!

    var screenToPresent: String!
    var foodResult: VNClassificationObservation!
    var screenDetails: (view: String, plural: Bool?)!

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
            "Our data scientists are processing your request.",
            "Your query is important to us, please wait…",
            "Hold the line, we'll be with you shortly."
        ]

        textLabel.text = messages.random()

        perform(#selector(presentScreen), with: nil, afterDelay: 3)
    }

    @objc func presentScreen() {
        let board = UIStoryboard(name: "RightWrong", bundle: nil)
        let viewController = board.instantiateViewController(withIdentifier: screenToPresent) as! RightWrongViewController

        viewController.foodResult = foodResult
        viewController.screenDetails = screenDetails

        navigationController?.pushViewController(viewController, animated: true)
    }
}
