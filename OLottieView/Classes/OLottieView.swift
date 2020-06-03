//
//  OLottieView.swift
//  OLottieView
//
//  Created by ONE on 2020/5/26.
//

import UIKit
import Lottie

public class OLottieView: UIView {

    private let animationView: AnimationView = {
        let animationView = AnimationView()
        animationView.loopMode = .autoReverse
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundBehavior = .pauseAndRestore
//        animationView.shouldRasterizeWhenIdle = true
        return animationView
    }()
        
    /// 动画json文件的名称
    @objc public var animationName: String = "" {
        willSet {
            animationView.animation = Animation.named(newValue)
            startLoading()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(animationView);
        animationView.frame = bounds
        addActiveObsver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
        addSubview(animationView)
        animationView.frame = bounds
        
        addActiveObsver()
    }
    
    func addActiveObsver() {
               
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) {[weak self] (noti: Notification) in
            guard self?.animationView.isHidden == false else {
                return
            }
//            self?.playLoading()
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: nil) {[weak self] (noti: Notification) in
            guard self?.animationView.isHidden == false else {
                return
            }
//            self?.pauseLoading()
//            self?.animationView.currentProgress = 0
        }
    }
    
    /// 开始loading
    @objc public func startLoading() {
        animationView.isHidden = false
        animationView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
    }
    
    func playLoading() {
        animationView.play()
    }
    
    @objc public func pauseLoading() {
        animationView.pause()
//        animationView.isHidden = true
//        animationView.reloadImages()

    }
    
    /// 结束loading
    @objc public func stopLoading() {
        animationView.stop()
        animationView.isHidden = true
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
    }
}
