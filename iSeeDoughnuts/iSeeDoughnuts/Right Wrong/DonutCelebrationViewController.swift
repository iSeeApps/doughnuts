//
//  DonutCelebrationViewController.swift
//  iSeeDoughnuts
//
//  Created by David on 18/12/2017.
//  Copyright © 2017 The Floow. All rights reserved.
//

import UIKit

class DonutCelebrationViewController: UIViewController {

    // link to the imageView in the storyboard
    @IBOutlet weak var viewSprinkles: UIImageView!

    //when the view loads into memory
    override func viewDidLoad() {
        super.viewDidLoad()

        //create and empty array
        var Sprinklesarray = [UIImage]()

        //Loop : for numbers 0 to 8
        for number in 0...8 {

            //create and image/frame with the given number
            let Sprinklesview = UIImage.init(imageLiteralResourceName: "sprinkles\(number)")

            //add the image/frame to the array
            Sprinklesarray.append(Sprinklesview)

        }

        //add the image array to the storyboard imageView
        viewSprinkles.animationImages=Sprinklesarray

    }


    //when the view is presented to the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //set the duration of the animation
        viewSprinkles.animationDuration=1

        //play the animation
        viewSprinkles.startAnimating()

    }

}
