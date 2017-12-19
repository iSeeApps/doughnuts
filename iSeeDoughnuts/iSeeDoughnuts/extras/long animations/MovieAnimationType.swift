//
//  MovieAnimationType.swift
//  FLOKit
//
//  Created by Matthew Ryan on 29/11/2017.
//

import UIKit
import AVKit

class MovieAnimationType: AnimationPlayerFileType {

    weak var delegate: AnimationPlayerViewDelegate?

    var mp4Player: AVPlayer?
    var avLayer: AVPlayerLayer?

    weak var masterView: AnimationPlayerView?
    var updateTimerSource: DispatchSourceTimer?

    var seekProgress: Float {

        get {
            guard let mp4Player = mp4Player, let duration = mp4Player.currentItem?.asset.duration,
                CMTimeGetSeconds(duration) > 0 else {
                return 0.0
            }
            let durationF = CMTimeGetSeconds(duration)
            let time = CMTimeGetSeconds(mp4Player.currentTime())
            return  Float(time / durationF)
        }
        set {
            guard let mp4Player = mp4Player, let duration = mp4Player.currentItem?.asset.duration,
                let timescale = mp4Player.currentItem?.asset.duration.timescale else {
                return
            }

            var usePercentage = Double(newValue)

            if usePercentage < 0 { usePercentage = 0 }
            if usePercentage > 1 { usePercentage = 1 }

            pause()

            mp4Player.seek(to: CMTimeMakeWithSeconds(((Double(duration.value)/Double(timescale)) * usePercentage), timescale))
        }
    }

    required init(filename: String, owner: AnimationPlayerView) {

        masterView = owner
        var videoURL: URL?

        if filename.hasPrefix("http:") || filename.hasPrefix("https:") {
            videoURL = URL(string: filename)
        } else {
            videoURL = Bundle.main.url(forResource: filename, withExtension: "mov")
            if videoURL == nil { videoURL = Bundle.main.url(forResource: filename, withExtension: "m4v") }
            if videoURL == nil { videoURL = Bundle.main.url(forResource: filename, withExtension: "mp4") }
        }

        guard let movieURL = videoURL else {
            #if DEBUG
                print("FLOAnimationView : Unable to Load Movie file \(filename)")
            #endif
            return
        }

        mp4Player = AVPlayer(url: movieURL)
        avLayer = AVPlayerLayer()

        guard let mp4Player = mp4Player, let avLayer = avLayer else {
            #if DEBUG
                print("FLOAnimationView : Unable to Load Movie file \(filename)")
            #endif
            return
        }

        avLayer.player = mp4Player
        masterView?.layer.addSublayer(avLayer)
        masterView?.setNeedsLayout()

    }

    /// Starts the animation playing.
    func play() {
        guard let mp4Player = mp4Player else {
            return
        }

        mp4Player.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(1000)))
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: mp4Player.currentItem)
        mp4Player.play()
        startProgressUpdate()
    }

    /// Pauses the animation.
    func pause() {
        stopProgressUpdate()
        mp4Player?.pause()
    }

    /// Resumes the animation after pause.
    func resume() {
        mp4Player?.play()
        startProgressUpdate()
    }

    /// Stops the animation returning it to the first frame.
    func stop() {
        stopProgressUpdate()
        mp4Player?.pause()
        mp4Player?.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(1000)))
    }

    /// Releases the assets loaded.
    func unload() {
        guard let avLayer = avLayer else {
            return
        }
        pause()
        avLayer.removeFromSuperlayer()
        avLayer.player = nil

        self.mp4Player = nil
        self.avLayer = nil

    }

    func update(frame: CGRect) {
        guard let masterView = masterView, let avLayer = avLayer  else {
            return
        }
        avLayer.frame = masterView.bounds
    }

    @objc func playerItemDidReachEnd() {
        guard let mp4Player = mp4Player , let masterView = masterView else {
            return
        }
        NotificationCenter.default.removeObserver(self,  name:NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: mp4Player.currentItem)
        
        delegate?.animationPlayerView(masterView, didFinishAnimating: true)
        
        if masterView.shouldLoop { play() }
    }

}
