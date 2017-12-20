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
    @IBOutlet var shutterButton: UIButton!

    let screens: [String: (view: String, plural: Bool?)] = [
        "cup cakes": ("Right", true),
        "chocolate cake": ("Right", false),
        "clam chowder":  ("Wrong", false),
        "macarons": ("Right", true),
        "fried rice": ("Wrong", false),
        "ice cream": ("Right", false),
        "panna cotta": ("Wrong", false),
        "frozen yogurt": ("Wrong", false),
        "chocolate mousse": ("Right", false),
        "foie gras": ("Wrong", false),
        "apple pie": ("Right", false),
        "sushi": ("Wrong", false),
        "miso soup": ("Wrong", false),
        "red velvet cake": ("Right", false),
        "carrot cake": ("Right", false),
        "donuts": ("Donut", true),
        "cheesecake": ("Right", false),
        "beignets": ("Right", true),
        "scallops": ("Wrong", true),
        "edamame": ("Salad", true),
        "tiramisu": ("Right", false),
        "chicken curry": ("Wrong", false),
        "peking duck": ("Wrong", false),
        "cannoli": ("Wrong", false),
        "samosa": ("Wrong", false),
        "falafel": ("Wrong", false),
        "cheese plate": ("Wrong", false),
        "takoyaki": ("Wrong", false),
        "churros": ("Right", true),
        "gnocchi": ("Wrong", false),
        "tuna tartare": ("Wrong", false),
        "creme brulee": ("Right", false),
        "bread pudding": ("Wrong", false),
        "baklava": ("Right", false),
        "risotto": ("Wrong", false),
        "strawberry shortcake": ("Right", false),
        "seaweed salad": ("Salad", false),
        "ceviche": ("Salad", false),
        "lobster bisque": ("Wrong", false),
        "mussels": ("Wrong", true),
        "dumplings": ("Wrong", true),
        "breakfast burrito": ("Right", false),
        "tacos": ("Right", true),
        "pizza": ("Right", false),
        "sashimi": ("Wrong", false),
        "guacamole": ("Wrong", false),
        "hummus":  ("Vomit", false),
        "paella": ("Wrong", false),
        "ravioli": ("Wrong", false),
        "deviled eggs": ("Vomit", true),
        "fried calamari": ("Wrong", false),
        "waffles": ("Right", true),
        "onion rings": ("Wrong", true),
        "spring rolls": ("Wrong", true),
        "crab cakes": ("Vomit", true),
        "pancakes": ("Right", true),
        "beef tartare": ("Wrong", false),
        "chicken wings":  ("Wrong", true),
        "steak": ("Wrong", false),
        "omelette": ("Wrong", false),
        "french fries": ("Wrong", true),
        "ramen": ("Wrong", false),
        "fish and chips": ("Wrong", false),
        "eggs benedict": ("Wrong", false),
        "pho": ("Wrong", false),
        "nachos": ("Right", true),
        "hot dog": ("Hotdog", nil),
        "pad thai": ("Wrong", false),
        "beet salad": ("Salad", false),
        "grilled cheese sandwich": ("Wrong", nil),
        "caesar salad": ("Salad", false),
        "chicken quesadilla": ("Wrong", false),
        "garlic bread": ("Wrong", false),
        "hamburger": ("Wrong", nil),
        "lasagna": ("Wrong", false),
        "shrimp and grits": ("Wrong", false),
        "greek salad": ("Salad", false),
        "gyoza": ("Wrong", false),
        "spaghetti carbonara": ("Wrong", false),
        "macaroni and cheese": ("Wrong", false),
        "caprese salad": ("Salad", false),
        "oysters": ("Vomit", true),
        "bruschetta": ("Wrong", false),
        "french onion soup": ("Wrong", false),
        "grilled salmon": ("Wrong", false),
        "prime rib": ("Wrong", false),
        "croque madame": ("Wrong", false),
        "beef carpaccio": ("Wrong", false),
        "bibimbap": ("Wrong", false),
        "club sandwich": ("Wrong", nil),
        "hot and sour soup": ("Wrong", false),
        "filet mignon": ("Wrong", false),
        "lobster roll sandwich": ("Wrong", false),
        "escargots": ("Vomit", true),
        "french toast": ("Wrong", false),
        "spaghetti bolognese": ("Wrong", false),
        "pulled pork sandwich": ("Wrong", nil),
        "poutine": ("Wrong", false),
        "huevos rancheros": ("Wrong", false),
        "baby back ribs": ("Wrong", true),
        "pork chop": ("Wrong", nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        shutterButton.layer.cornerRadius = shutterButton.frame.height / 2
        shutterButton.layer.shadowRadius = 2
        shutterButton.layer.shadowOpacity = 0.6
        shutterButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        shutterButton.backgroundColor = UIColor(white: 1, alpha: 0.8)
    }

    override func mainResult(result: VNClassificationObservation, forImage: UIImage) {
        var screenDetails = screens[result.identifier]!

        if result.confidence <= 0.4 {
            screenDetails.view = "NotHotdog"
        }

        let navigationController = UIStoryboard(name: "Analysing", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let viewController = navigationController.viewControllers.first as! AnalysingViewController

        viewController.screenToPresent = screenDetails.view
        viewController.foodResult = result
        viewController.screenDetails = screenDetails

        present(navigationController, animated: true)
    }

    override func allResults(results: [VNClassificationObservation], forImage: UIImage) {

        for result in results {
            print("We're \(Int(result.confidence * 100))% sure that is \(result.identifier)")
            return
        }

//        for result in results {
//            print("\(result.identifier)")
//        }

    }

    @IBAction func buttonPressed(_ sender: Any) {
        detectScene()
    }
}

