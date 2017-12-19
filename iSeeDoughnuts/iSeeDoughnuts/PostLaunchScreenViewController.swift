//
//  PostLaunchScreenViewController.swift
//  iSeeDoughnuts
//
//  Created by Sam Rayner on 18/12/2017.
//  Copyright © 2017 The Floow. All rights reserved.
//

import UIKit

class PostLaunchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(showCameraScreen), with: nil, afterDelay: 1)
    }

    @objc func showCameraScreen() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true)
    }
}
