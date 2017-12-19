//
//  AnimationPlayerView.swift
//  Pods
//
//  Created by Matthew Ryan on 10/07/2017.
//
//

import UIKit

public protocol AnimationPlayerViewDelegate: class {
    func animationPlayerView(_ animationView: AnimationPlayerView,
                             didFinishAnimating finished: Bool)

    func animationPlayerView(_ animationView: AnimationPlayerView,
                             didUpdateProgress prgress: Float)
}

extension AnimationPlayerViewDelegate {
    func animationPlayerView(_ animationView: AnimationPlayerView,
                             didFinishAnimating finished: Bool) {
        //empty implementation to make this optional
    }

    func animationPlayerView(_ animationView: AnimationPlayerView,
                             didUpdateProgress prgress: Float) {
        //empty implementation to make this optional
    }
}

protocol AnimationPlayerFileType: class {

    weak var delegate: AnimationPlayerViewDelegate? { get set }
    var seekProgress: Float { get set }
    weak var masterView: AnimationPlayerView? { get set }

    var updateTimerSource: DispatchSourceTimer? { get set }

    init(filename: String, owner: AnimationPlayerView)

    /// Starts the animation playing.
    func play()

    /// Pauses the animation.
    func pause()

    /// Resumes the animation after pause.
    func resume()

    /// Stops the animation returning it to the first frame.
    func stop()

    /// Releases the assets loaded.
    func unload()

    func startProgressUpdate()

    func stopProgressUpdate()

    func render(in rect: CGRect)

    func update(frame: CGRect)
}

extension AnimationPlayerFileType {
    func render(in rect: CGRect) {
        //empty implementation to make this optional
    }

    func update(frame: CGRect) {
        //empty implementation to make this optional
    }

    func startProgressUpdate() {
        guard let masterView = masterView, delegate != nil else {
            return
        }

        updateTimerSource = DispatchSource.makeTimerSource()

        updateTimerSource?.setEventHandler(handler: { [weak self] in
            guard let progress = self?.seekProgress, let delegate = self?.delegate, let masterView = self?.masterView else {
                return
            }

            delegate.animationPlayerView(masterView, didUpdateProgress: Float(progress))

            if progress >= 1.0, masterView.shouldLoop {
                self?.stopProgressUpdate()
            }

        })

        let intervalTime = UInt64( 1.0 / masterView.progressUpdateFrequency) * NSEC_PER_SEC
        updateTimerSource?.schedule(deadline: DispatchTime.now(),
                                    repeating: DispatchTimeInterval.nanoseconds(Int(intervalTime)),
                                    leeway: DispatchTimeInterval.nanoseconds(100))

        updateTimerSource?.resume()

    }

    /// Cancels the progress update callbacks
    func stopProgressUpdate() {
        updateTimerSource = nil
    }

}

open class AnimationPlayerView: UIView {

    // MARK: public properties

    /// Delegate to allow response to animation finished and get update to progress
    open weak var delegate: AnimationPlayerViewDelegate? {
        didSet {
            file?.delegate = delegate
        }
    }

    private var file: AnimationPlayerFileType?

    /// The file name of the animation. This will attempt to load data when set.
    @IBInspectable open var filename: String? {
        didSet {
            guard let filename = filename, !filename.isEmpty else {
                unload()
                return
            }
            setupWithFilename(filename)
        }
    }

    /// Should the animation loop or not?
    @IBInspectable open var shouldLoop: Bool = false

    /// The progress of the aniamtion (0.0f-1.0f).
    open var seekProgress: Float {
        set {
            guard let file = file else { return }

            file.seekProgress = newValue
        }
        get {
            guard let file = file else { return 0.0 }

            return file.seekProgress
        }
    }

    /// The frequency to update the delegate about the progress in Hz default is 2Hz
    open var progressUpdateFrequency: Float =  2.0 {
        didSet {
            progressUpdateFrequency = fabs(progressUpdateFrequency)
            if progressUpdateFrequency == 0.0 {
                progressUpdateFrequency = 1.0
            }

        }
    }

    // MARK: private properties
    /**
     These constants are used to specify the file format required.

      - faf: Floow animation file, consists of a .png diff file and a map (.faf) file.
      - lottie: Vector graphics animation based on Core aniamtion using a json file. http://airbnb.design/lottie/
      - mp4: Wrapper on a AVPlayer currently supports .mov .m4v and .mp4 formats.
     */
    private enum AnimationType {
        case faf, lottie, mp4
    }

    private var fileType: AnimationType = .faf

    // MARK: public functions

    /// Starts the animation playing.
    open func play() {
        file?.play()
    }

    /// Pauses the animation.
    open func pause() {
        file?.pause()
    }

    /// Resumes the animation after pause.
    open func resume() {
        file?.resume()
    }

    /// Stops the animation returning it to the first frame.
    open func stop() {
        file?.stop()
    }

    /// Releases the assets loaded.
    open func unload() {
        file?.unload()
    }

    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        file?.render(in: rect)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        file?.update(frame: bounds)
    }

    // MARK: private functions
    private func setupWithFilename(_ filename: String) {
        unload()

        #if USING_LOTTIE
            if let path = Bundle.main.path(forResource: filename, ofType:"json"), path != "" {
                fileType = .lottie
                file = LottieAnimationType(filename: filename, owner: self)
                file?.delegate = delegate
                return
            }
        #endif
        for extention in ["mov","mp4","m4v"]  {
            if let path = Bundle.main.path(forResource: filename, ofType: extention), path != "" {
                fileType = .mp4
                file = MovieAnimationType(filename: filename, owner: self)
                file?.delegate = delegate
                return
            }
        }
    }

    private func startProgressUpdate() {
        file?.startProgressUpdate()
    }

    private func stopProgressUpdate() {
        file?.stopProgressUpdate()
    }
}
