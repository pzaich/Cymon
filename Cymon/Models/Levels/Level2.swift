//
//  Level2.swift
//  Cymon
//
//  Created by Paul Zaich on 4/24/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

protocol Levelable {
  var duration:Int { get } //= 10
  var challengeScore:Int { get }//= 0
  var challengeDistribution:[String:Double] { get }//[String:Double]()
  var totalChallenges:Int { get }
}

class Level2:Levelable {
  
  var duration:Int = 10
  var challengeScore:Int = 0
  var challengeDistribution:[String:Double] = [String:Double]()
  var totalChallenges:Int = 0
  
  override var duration:Int = 10
  
  override init() {
    super.init()
    self.duration = 10
    self.challengeScore = 11
    self.totalChallenges = 15
    self.challengeDistribution = [
      "tap": 0.5,
      "pinchOut": 0.25,
      "pinchIn": 0.25
    ]
  }
}
