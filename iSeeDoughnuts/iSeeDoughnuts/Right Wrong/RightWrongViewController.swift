//
//  RightWrongViewController.swift
//  iSeeDoughnuts
//
//  Created by David on 18/12/2017.
//  Copyright © 2017 The Floow. All rights reserved.
//

import UIKit
import Vision

class RightWrongViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView?

    var foodResult: VNClassificationObservation!
    var screenDetails: (view: String, plural: Bool?)!

    @IBAction func dimissAnimated() {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var confidenceText = "We're \(Int(foodResult.confidence * 100))% sure"

        if screenDetails.plural == true {
            confidenceText = "\(confidenceText) those are"
        } else if screenDetails.plural == false {
            confidenceText = "\(confidenceText) that is"
        } else {
            confidenceText = "\(confidenceText) that is a"
        }

        confidenceText = "\(confidenceText) \(foodResult.identifier)"

        resultLabel.text = confidenceText

        var Sprinklesarray = [UIImage]()

        var imagePerson: String

        if restorationIdentifier == "Right" {
            imagePerson = "aldo"
        } else {
            imagePerson = "dt"
        }

        //Loop : for numbers 0 to 8
        for number in 0...8 {

            //create and image/frame with the given number
            let Sprinklesview = UIImage.init(imageLiteralResourceName: "\(imagePerson)_frame_\(8-number)")

            //add the image/frame to the array
            Sprinklesarray.append(Sprinklesview)

        }

        //add the image array to the storyboard imageView
        backgroundImageView?.animationImages=Sprinklesarray
    }
    //when the view is presented to the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //set the duration of the animation
        backgroundImageView?.animationDuration=1

        //play the animation
        backgroundImageView?.startAnimating()

    }
}
