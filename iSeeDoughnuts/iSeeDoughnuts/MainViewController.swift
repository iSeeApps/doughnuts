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
    let screenNames: [String: String] = [
        "cup cakes": "Right",
        "chocolate cake": "Right",
        "clam chowder":  "Wrong",
        "macarons": "Right",
        "fried rice": "Wrong",
        "ice cream": "Right",
        "panna cotta": "Wrong",
        "frozen yogurt": "Wrong",
        "chocolate mousse": "Right",
        "foie gras": "Wrong",
        "apple pie": "Right",
        "sushi": "Wrong",
        "miso soup": "Wrong",
        "red velvet cake": "Right",
        "carrot cake": "Right",
        "donuts": "Donut",
        "cheesecake": "Right",
        "beignets": "Right",
        "scallops": "Wrong",
        "edamame": "Wrong",
        "tiramisu": "Right",
        "chicken curry": "Wrong",
        "peking duck": "Wrong",
        "cannoli": "Wrong",
        "samosa": "Wrong",
        "falafel": "Wrong",
        "cheese plate": "Wrong",
        "takoyaki": "Wrong",
        "churros": "Right",
        "gnocchi": "Wrong",
        "tuna tartare": "Wrong",
        "creme brulee": "Right",
        "bread pudding": "Wrong",
        "baklava": "Right",
        "risotto": "Wrong",
        "strawberry shortcake": "Right",
        "seaweed salad": "Vomit",
        "ceviche": "Wrong",
        "lobster bisque": "Wrong",
        "mussels": "Wrong",
        "dumplings": "Wrong",
        "breakfast burrito": "Right",
        "tacos": "Right",
        "pizza": "Right",
        "sashimi": "Wrong",
        "guacamole": "Wrong",
        "hummus":  "Vomit",
        "paella": "Wrong",
        "ravioli": "Wrong",
        "deviled eggs": "Wrong",
        "fried calamari": "Wrong",
        "waffles": "Right",
        "onion rings": "Wrong",
        "spring rolls": "Wrong",
        "crab cakes": "Vomit",
        "pancakes": "Right",
        "beef tartare": "Wrong",
        "chicken wings":  "Wrong",
        "steak": "Wrong",
        "omelette": "Wrong",
        "french fries": "Wrong",
        "ramen": "Wrong",
        "fish and chips": "Wrong",
        "eggs benedict": "Wrong",
        "pho": "Wrong",
        "nachos": "Right",
        "hot dog": "Hotdog",
        "pad thai": "Wrong",
        "beet salad": "Vomit",
        "grilled cheese sandwich": "Wrong",
        "caesar salad": "Vomit",
        "chicken quesadilla": "Wrong",
        "garlic bread": "Wrong",
        "hamburger": "Wrong",
        "lasagna": "Wrong",
        "shrimp and grits": "Wrong",
        "greek salad": "Vomit",
        "gyoza": "Wrong",
        "spaghetti carbonara": "Wrong",
        "macaroni and cheese": "Wrong",
        "caprese salad": "Vomit",
        "oysters": "Vomit",
        "bruschetta": "Wrong",
        "french onion soup": "Wrong",
        "grilled salmon": "Wrong",
        "prime rib": "Wrong",
        "croque madame": "Wrong",
        "beef carpaccio": "Wrong",
        "bibimbap": "Wrong",
        "club sandwich": "Wrong",
        "hot and sour soup": "Wrong",
        "filet mignon": "Wrong",
        "lobster roll sandwich": "Wrong",
        "escargots": "Vomit",
        "french toast": "Wrong",
        "spaghetti bolognese": "Wrong",
        "pulled pork sandwich": "Wrong",
        "poutine": "Wrong",
        "huevos rancheros": "Wrong",
        "baby back ribs": "Wrong",
        "pork chop": "Wrong"
    ]

    override func mainResult(result: VNClassificationObservation, forImage: UIImage) {
        var screenName = screenNames[result.identifier]!


        if result.confidence <= 0.5 {
            screenName = "NotHotdog"
        }


        let navigationController = UIStoryboard(name: "Analysing", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let viewController = navigationController.viewControllers.first as! AnalysingViewController

        viewController.screenToPresent = screenName

        present(navigationController, animated: true)
    }

    override func allResults(results: [VNClassificationObservation], forImage: UIImage) {

        for result in results {
            print("\(Int(result.confidence * 100))% it's \(result.identifier) ")
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

