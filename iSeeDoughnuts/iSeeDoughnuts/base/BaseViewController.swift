//
//  ViewController.swift
//  iSeeDoughnuts
//
//  Created by Matthew Ryan on 14/12/2017.
//  Copyright © 2017 The Floow. All rights reserved.
//

import UIKit
import CoreML
import Vision
import AVFoundation

class BaseViewController: UIViewController, FrameExtractorDelegate  {

    var frameExtractor: FrameExtractor!
    var currentCGImage = CIImage()
    var detectedUIImage = UIImage()

    var settingImage = false

    @IBOutlet weak var previewImage: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        frameExtractor = FrameExtractor()
        frameExtractor.delegate = self
    }

    func captured(image: UIImage) {

        self.previewImage.image = image
        if let cgImage = image.cgImage {
            self.currentCGImage = CIImage(cgImage: cgImage)
        }

    }

    func detectScene() {

        guard let detectedUIImage = self.previewImage.image else {
            return;
        }

        self.detectedUIImage = detectedUIImage

        DispatchQueue.global(qos: .userInteractive).async {[unowned self] in
            guard let model = try? VNCoreMLModel(for: food().model) else {
                fatalError()
            }

            // Create a Vision request with completion handler
            let request = VNCoreMLRequest(model: model) { [unowned self] request, error in
                guard let results = request.results as? [VNClassificationObservation],
                    let mainResult = results.first else {
                        return
                }

                DispatchQueue.main.async { [unowned self] in
                    self.mainResult(result: mainResult, forImage:detectedUIImage )
                    self.allResults(results: results, forImage:detectedUIImage )
                }
            }

            let handler = VNImageRequestHandler(ciImage: self.currentCGImage)
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try handler.perform([request])
                } catch {
                    print(error)
                }
            }
        }
    }

    func mainResult(result: VNClassificationObservation, forImage: UIImage) {
        //to override for result
    }

    func allResults(results: [VNClassificationObservation], forImage: UIImage) {
        //to override for result
    }

}
