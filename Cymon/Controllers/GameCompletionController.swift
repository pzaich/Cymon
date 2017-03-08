//
//  GameCompletionController.swift
//  Cymon
//
//  Created by Paul Zaich on 2/21/16.
//  Copyright © 2016 Paul Zaich. All rights reserved.
//

import UIKit

class GameCompletionController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    if let game = Game.currentGame {
      scoreLabel.text = "\(game.score)"
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    Game.releaseCurrent()
    super.viewDidDisappear(animated)
  }
  
  @IBOutlet weak var scoreLabel: UILabel!
}

