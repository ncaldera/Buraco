//
//  Deck.swift
//  Buraco fin
//
//  Created by Natalia Caldera on 9/28/24.
//

import Foundation

class Deck {
    private var cards: [Card]
    
    init(){
        cards = []
        for i in 3...13 {
            cards.append(Card(suit:Card.suits.club, value: i))
        }
        for i in 3...13 {
            cards.append(Card(suit:Card.suits.diamond, value: i))
        }
        for i in 3...13 {
            cards.append(Card(suit:Card.suits.heart, value: i))
        }
        for i in 3...13 {
            cards.append(Card(suit:Card.suits.spade, value: i))
        }
        cards.append(Card(suit: Card.suits.club, value: 2, isSpecial: true))
        cards.append(Card(suit: Card.suits.diamond, value: 2, isSpecial: true))
        cards.append(Card(suit: Card.suits.heart, value: 2, isSpecial: true))
        cards.append(Card(suit: Card.suits.spade, value: 2, isSpecial: true))
        cards.append(Card(suit: Card.suits.joker, value: Card.values.joker.rawValue, isSpecial: true))
        cards.append(Card(suit: Card.suits.joker, value: Card.values.joker.rawValue, isSpecial: true))
    }
    
    func shuffle() -> Void {
        var temp = [Card]()
        let max = cards.count
        let range = 0..<max
        for _ in range{
            let rand = Int.random(in: 0..<cards.count)
            let x = cards[rand]
            cards.remove(at: rand)
            temp.append(x)
        }
        cards = temp
    }
    func getCard(index:Int) -> Card{
        let x: Card = cards[index]
        cards.remove(at: index)
        return x
    }
    
    func getTopCard() -> Card {
        let x: Card = cards[0]
        cards.remove(at: 0)
        return x
    }
    
    func getSize() -> Int{
        return cards.count
    }
}
