//
//  LevelInterludeController.swift
//  Cymon
//
//  Created by Paul Zaich on 3/1/17.
//  Copyright © 2017 Paul Zaich. All rights reserved.
//

import UIKit

class LevelInterludeController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    if let game = Game.currentGame {
      mainLabel.text = "Well done. On to Level \(game.nextLevel)"
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBOutlet weak var mainLabel: UILabel!
}
