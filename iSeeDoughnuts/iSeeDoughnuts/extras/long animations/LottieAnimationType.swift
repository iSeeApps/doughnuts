//
//  LottieAnimationType.swift
//  Pods
//
//  Created by Matthew Ryan on 20/07/2017.
//
//
#if USING_LOTTIE
import Lottie

class LottieAnimationType: AnimationPlayerFileType {
    weak var delegate: AnimationPlayerViewDelegate?

    var lottieAnimationView: LOTAnimationView?

    weak var masterView: AnimationPlayerView?
    var updateTimerSource: DispatchSourceTimer?

    var seekProgress: Float {

        get {
            guard let lottieAnimationView = lottieAnimationView else {
                return 0.0
            }
            return Float(lottieAnimationView.animationProgress)
        }
        set {
            guard let lottieAnimationView = lottieAnimationView else {
                return
            }
            var usePercentage = newValue

            if usePercentage < 0 { usePercentage = 0 }
            if usePercentage > 1 { usePercentage = 1 }

            stopProgressUpdate()

            lottieAnimationView.pause()
            lottieAnimationView.animationProgress = CGFloat(usePercentage)
        }
    }

    required init(filename: String, owner: AnimationPlayerView) {

        masterView = owner

        lottieAnimationView = LOTAnimationView(name:filename)

        guard let lottieAnimationView = lottieAnimationView else {

            #if DEBUG
                print("FLOAnimationView : Unable to Load lottie file \(filename)")
            #endif
            return
        }
        lottieAnimationView.contentMode = .scaleAspectFit
        owner.addSubview(lottieAnimationView)
        owner.setNeedsLayout()
    }

    /// Starts the animation playing.
    func play() {
        guard let lottieAnimationView = lottieAnimationView, let masterView = masterView else {
            return
        }

        lottieAnimationView.loopAnimation = masterView.shouldLoop
        seekProgress = 0
        lottieAnimationView.play { [weak self] animationFinished in
            guard let delegate = self?.delegate, let masterView = self?.masterView, animationFinished else {
                return
            }
            delegate.animationPlayerView(masterView, didFinishAnimating: true)
        }
    }

    /// Pauses the animation.
    func pause() {
        guard let lottieAnimationView = lottieAnimationView else {
            return
        }
        lottieAnimationView.pause()
    }

    /// Resumes the animation after pause.
    func resume() {
        guard let lottieAnimationView = lottieAnimationView else {
            return
        }

        lottieAnimationView.play { [weak self] animationFinished in
            guard let delegate = self?.delegate, let masterView = self?.masterView, animationFinished else {
                return
            }
            delegate.animationPlayerView(masterView, didFinishAnimating: true)
        }
    }

    /// Stops the animation returning it to the first frame.
    func stop() {
        guard let lottieAnimationView = lottieAnimationView else {
            return
        }

        lottieAnimationView.pause()
        seekProgress = 0
    }

    /// Releases the assets loaded.
    func unload() {
        stopProgressUpdate()

        guard let lottieAnimationView = lottieAnimationView else {
            return
        }
            lottieAnimationView.removeFromSuperview()
            self.lottieAnimationView = nil

    }

    func update(frame: CGRect) {
        guard let lottieAnimationView = lottieAnimationView else {
            return
        }
        lottieAnimationView.frame = frame
    }

}

#endif
