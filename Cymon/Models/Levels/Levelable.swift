//
//  LevelProtocol.swift
//  Cymon
//
//  Created by Paul Zaich on 2/20/16.
//  Copyright © 2016 Paul Zaich. All rights reserved.
//

import Foundation

protocol Levelable {
  static var levelDuration: Int { get set }
  static var challenges: [Challenge] { get }
//  static var challengeScore: Int { get }
//  static var totalChallenges: Int { get }
//  static var challengeDistribution: [String:Double] { get set }
}