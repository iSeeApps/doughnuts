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
        perform(#selector(showAnalysingScreen), with: nil, afterDelay: 3)
    }

    @objc func showAnalysingScreen() {
        let viewController = UIStoryboard(name: "Analysing", bundle: nil).instantiateInitialViewController()!
        present(viewController, animated: true)
    }
}
