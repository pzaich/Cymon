//
//  SwipeChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 6/9/17.
//  Copyright © 2017 Paul Zaich. All rights reserved.
//

import UIKit

class SwipeChallenge:Challenge {
  var initialCoord:CGFloat?
  var distanceTraveled:CGFloat = 0.0
  var minimumNumberOfTouches = 2
  var coordinate = "y"
  
  func isGestureSuccess() -> Bool {
    return false
  }
  
  override func handler(_ sender:UIGestureRecognizer, challengeImage:UIImageView, onSuccess:() -> Void, onFail:(_ challengeImage:UIImageView) -> Void) {
    let s = sender as! UIPanGestureRecognizer
    let translation = s.translation(in: s.view)
    
    if s.state == .began || s.state == .changed {
      if initialCoord == nil {
        distanceTraveled = 0.0
        self.initialCoord = challengeImage.center.y
      }
      
      var x = s.view!.center.x
      var y = s.view!.center.y
      
      if (coordinate == "y") {
        y += translation.y
        distanceTraveled += translation.y
      } else if (coordinate == "x") {
        x += translation.x
        distanceTraveled += translation.x
      }
      
      print(distanceTraveled)
      
      s.view!.center = CGPoint(x: x, y: y)
      s.setTranslation(CGPoint.zero, in: s.view)
    }
    
    if s.state == .ended, let initialYCoord = initialCoord {
      if isGestureSuccess() {
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
