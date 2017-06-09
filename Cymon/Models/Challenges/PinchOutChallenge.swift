//
//  PinchOutChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 4/23/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

//TODO rename image styles
import UIKit

class PinchOutChallenge:Challenge {
  
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "pinchOut"
    self.gestureInstruction = "Pinch inwards to zoom out"
    self.challengeImage = "pinch-in.png"
  }
  
  override func handler(_ sender:UIGestureRecognizer, challengeImage:UIImageView, onSuccess:() -> Void, onFail:(_ challengeImage:UIImageView) -> Void) {
    let s = sender as! UIPinchGestureRecognizer
    
    if (s.state == .began) && (Float(s.scale) < 1.0)  {
      let multiplier:Float = 5.0
      let transformScale = Float(s.scale) / multiplier
      challengeImage.transform = challengeImage.transform.scaledBy(x: CGFloat(transformScale), y: CGFloat(transformScale))
      s.scale = 1
    }
    
    //reset initial scaling
    if s.state == .cancelled || s.state == .ended {
      challengeImage.transform = CGAffineTransform(scaleX: CGFloat(1.0), y: CGFloat(1.0))
    }
    
    if s.state == .ended && Float(s.scale) < 0.8  {
      onSuccess()
    } else if sender.state == .ended {
      onFail(challengeImage)
    }
  }
}
