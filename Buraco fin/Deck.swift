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
            cards.append(Card(suit:Card.suits.club, rank: i))
        }
        for i in 3...13 {
            cards.append(Card(suit:Card.suits.diamond, rank: i))
        }
        for i in 3...13 {
            cards.append(Card(suit:Card.suits.heart, rank: i))
        }
        for i in 3...13 {
            cards.append(Card(suit:Card.suits.spade, rank: i))
        }
        cards.append(Card(suit: Card.suits.club, rank: 2, value: Card.values.joker))
        cards.append(Card(suit: Card.suits.diamond, rank: 2, value: Card.values.joker))
        cards.append(Card(suit: Card.suits.heart, rank: 2, value: Card.values.joker))
        cards.append(Card(suit: Card.suits.spade, rank: 2, value: Card.values.joker))
        cards.append(Card(suit: Card.suits.joker, rank: 0, value: Card.values.joker))
        cards.append(Card(suit: Card.suits.joker, rank: 0, value: Card.values.joker))
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
        assert(index < cards.count, "index_out_of_bounds")
        let x: Card = cards[index]
        return x
    }
    
    func getTopCard() -> Card {
        let x: Card = cards[0]
        return x
    }
    
    func getSize() -> Int{
        return cards.count
    }
    func removeCard(index:Int) -> Void {
        assert(index < cards.count, "index_out_of_bounds")
        cards.remove(at: index)
    }
    
}
