//
//  TapChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 4/23/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//
import UIKit

class TapChallenge:Challenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "tap"
    self.gestureInstruction = "Tap anywhere"
    self.challengeImage = "tap.png"
  }
  
  let challengeImageAnimation = "tap-active.png"
  
  override func handler(_ sender:UIGestureRecognizer, challengeImage:UIImageView, onSuccess:() -> Void, onFail:(_ challengeImage:UIImageView) -> Void) {
    let s = sender as! UILongPressGestureRecognizer
    
    if s.state == .ended {
      challengeImage.image = UIImage(named: self.challengeImage!)
      onSuccess()
    }
    
    if s.state == .began {
      challengeImage.image = UIImage(named: self.challengeImageAnimation)
    }
  }
}
