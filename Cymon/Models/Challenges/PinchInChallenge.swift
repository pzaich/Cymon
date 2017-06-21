//
//  PinchInChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 5/3/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//
import UIKit

class PinchInChallenge:Challenge {
  
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "pinchIn"
    self.gestureInstruction = "Pinch to zoom in"
    self.challengeImage = "pinch-out.png"
  }
  
  override func handler(_ sender:UIGestureRecognizer, challengeImage:UIImageView, onSuccess:() -> Void, onFail:(_ challengeImage:UIImageView) -> Void) {
    let s = sender as! UIPinchGestureRecognizer
    
    if s.state == .began && Float(s.scale) > 1.0 {
      let multiplier:Float = 1.5
      let transformScale = multiplier * Float(s.scale)
      
      UIView.animate(withDuration: 0.15, animations: {
        challengeImage.transform = challengeImage.transform.scaledBy(x: CGFloat(transformScale), y: CGFloat(transformScale))
      })
      
      s.scale = 1
    }
    
    //reset initial scaling
    if s.state == .cancelled || s.state == .ended {
      UIView.animate(withDuration: 0.15, animations: {
        challengeImage.transform = CGAffineTransform(scaleX: CGFloat(1.0), y: CGFloat(1.0))
      })
    }
    
    if sender.state == .ended && Float(s.scale) > 2.0  {
      onSuccess()
    } else if sender.state == .ended {
      onFail(challengeImage)
    }

  }
}
