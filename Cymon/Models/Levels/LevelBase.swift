//
//  LevelBase.swift
//  Cymon
//
//  Created by Paul Zaich on 2/20/16.
//  Copyright © 2016 Paul Zaich. All rights reserved.
//

import Foundation
import Dollar

class LevelBase {
  
  //  batch create according to ratios
  // http://gamedev.stackexchange.com/questions/81986/how-to-generate-arrays-of-item-types-knowing-just-the-ratio-of-distribution
  
  func buildChallenges (totalChallenges: Int, distribution: [String:Double]) -> [Challenge] {
    var placeholder:[Challenge] = []
    
    for (challengetype,ratio) in distribution {
      let noOfChallengesToCreate = Int(round((Double(totalChallenges) * ratio)))
      for _ in 1...noOfChallengesToCreate {
        placeholder.append(Challenge.createChallenge(self, type: challengetype))
      }
    }
      
    return $.shuffle(placeholder)
  }
    
}