//
//  Level.swift
//  Cymon
//
//  Created by Paul Zaich on 4/14/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation
import Dollar

class Level {

  var duration:Int = 10
  var challengeScore:Int = 0
  var challengeDistribution:[String:Double] = [String:Double]()
  var totalChallenges:Int = 0
  
  //  batch create according to ratios
  // http://gamedev.stackexchange.com/questions/81986/how-to-generate-arrays-of-item-types-knowing-just-the-ratio-of-distribution
  lazy var challenges:[Challenge] = {
    
    var placeholder:[Challenge] = []
    
    // there is an assumption here that all ratios will round such that 50 objects will be created
    for (challengetype,ratio) in self.challengeDistribution {
      var noOfChallengesToCreate = Int(round((Double(self.totalChallenges) * ratio)))
      for _ in 1...noOfChallengesToCreate {
        placeholder.append(Challenge.createChallenge(self, type: challengetype))
      }
    }
    
    print("\(placeholder.count)")
  
    return $.shuffle(placeholder)
  }()
  
  class func createLevel (level:Int)-> Level
  {
    var levelInstance:Level?
      switch level {
        case 1:
          levelInstance = Level1()
      default: break
    }
    return levelInstance!
  }
}