//
//  SwipeUpChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 5/1/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//
import UIKit

class SwipeUpChallenge:Challenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "swipeUp"
    self.gestureInstruction = "Swipe up!"
    self.challengeImage = "swipe-up.png"
  }
  
  var initialYCoord:CGFloat?
  var distanceTraveled:CGFloat = 0.0
  
  override func handler(_ sender:UIGestureRecognizer, challengeImage:UIImageView, onSuccess:() -> Void, onFail:(_ challengeImage:UIImageView) -> Void) {
    let s = sender as! UIPanGestureRecognizer
    let translation = s.translation(in: s.view)
    
    if s.state == .began || s.state == .changed {
      if initialYCoord == nil {
        distanceTraveled = 0.0
        self.initialYCoord = challengeImage.center.y
      }
    
      distanceTraveled += translation.y
      
      s.view!.center = CGPoint(x: s.view!.center.x, y: s.view!.center.y + translation.y)
      s.setTranslation(CGPoint.zero, in: s.view)
    }
    
    if s.state == .ended, let initialYCoord = initialYCoord {
      if distanceTraveled < -250 {
        UIView.animate(withDuration: 0.15, animations: {
          challengeImage.transform = CGAffineTransform(translationX: 0, y: -256)
          challengeImage.transform = CGAffineTransform.identity
        })
        onSuccess()
      } else {
        s.view!.center = CGPoint(x: s.view!.center.x, y: initialYCoord)
        onFail(challengeImage)
      }
      distanceTraveled = 0.0
    }
  }
}
