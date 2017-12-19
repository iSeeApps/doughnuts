//
//  ViewController.swift
//  iSeeDoughnuts
//
//  Created by Matthew Ryan on 14/12/2017.
//  Copyright © 2017 The Floow. All rights reserved.
//

import UIKit
import Vision

class MainViewController: BaseViewController {

    override func mainResult(result: VNClassificationObservation, forImage: UIImage) {

        print("*********************************************** ")
        print("I'm \(Int(result.confidence * 100))% sure it's \(result.identifier) ")
        print("*********************************************** ")

    }

    override func allResults(results: [VNClassificationObservation], forImage: UIImage) {

        for result in results {
            print("\(Int(result.confidence * 100))% it's \(result.identifier) ")
        }

        for result in results {
            print("\(result.identifier)")
        }

    }

    @IBAction func buttonPressed(_ sender: Any) {
        detectScene()
    }
}

