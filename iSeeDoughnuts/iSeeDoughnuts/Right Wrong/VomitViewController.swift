//
//  VomitViewController.swift
//  iSeeDoughnuts
//
//  Created by Paul on 18/12/2017.
//  Copyright © 2017 The Floow. All rights reserved.
//

import UIKit

class VomitViewController: UIViewController {

    // link to the imageView in the storyboard
    @IBOutlet weak var vomitAnimationView: UIImageView!

    //when the view loads into memory
    override func viewDidLoad() {
        super.viewDidLoad()

        //create and empty array
        var imageArray = [UIImage]()

        //Loop : for numbers 0 to 9
        for number in 0...9 {

            //create and image/frame with the given number
            let image = UIImage.init(imageLiteralResourceName: "vomit_0\(number)")

            //add the image/frame to the array
            imageArray.append(image)

        }//Loop : end

        //add the image array to the storyboard imageView
        vomitAnimationView.animationImages = imageArray
    }



    //when the view is presented to the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //set the duration of the animation
        vomitAnimationView.animationDuration=1

        //play the animation
        vomitAnimationView.startAnimating()

    }

}
