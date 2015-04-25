//
//  TapChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 4/23/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class TapChallenge:Challenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "tap"
    self.gestureInstruction = "Tap anywhere"
  }
}