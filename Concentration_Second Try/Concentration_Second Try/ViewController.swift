//
//  ViewController.swift
//  Concentration_Second Try
//
//  Created by Jiahe Wang on 2019-03-16.
//  Copyright © 2019 Jiahe Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (self.cardButtons.count + 1) / 2)
    
    var flipCount = 0{
        didSet{
            FlipCountLable.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var FlipCountLable: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        print("card touch detacted!")
        if let cardNumber = cardButtons.index(of:sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("Card is not in the cardButtons list!")
        }
    }
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.lightGray
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.black
            }
        }
    }
    
    var emojiChoices = ["🏀","🏓","⚽️","🎱","🏈","🏐","🏸","🥏"]
    
    var emoji = [Int:String]()
    
    
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count>0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    

}

