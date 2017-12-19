//
//  HotDogViewController.swift
//  iSeeDoughnuts
//
//  Created by Matthew Ryan on 18/12/2017.
//  Copyright © 2017 The Floow. All rights reserved.
//

import UIKit

class HotDogViewController: UIViewController, AnimationPlayerViewDelegate {

    @IBOutlet weak var moviePlayer: AnimationPlayerView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        moviePlayer.play()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        moviePlayer.stop()
    }



}
