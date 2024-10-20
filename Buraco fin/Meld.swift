//
//  Meld.swift
//  Buraco fin
//
//  Created by Natalia Caldera on 9/28/24.
//

import Foundation

class Meld: Equatable{
    
    enum ClosedTypes {
        case semi;
        case dirty;
        case clean;
        case jokers;
        case notClosed;
    }
    enum types {
        case straight;
        case sameValue;
        case jokers;
    }
    private var cards: [Card];
    private var type: types;
    private var isClosed:Bool;
    private var closedType: ClosedTypes;
    private var hasJoker: Bool;
    
    init(cards: [Card], type: types){
        self.cards = cards;
        self.type = type;
        self.isClosed = false;
        self.closedType = ClosedTypes.notClosed;
        var count:Int = 0;
        for card in cards {
            if !card.getCardIsJoker() {
                count += 1
            }
        }
        if count == 1 {
            self.hasJoker = true
        } else if count == 0 {
            self.hasJoker = false
        } else if count == cards.count {
            self.type = .jokers
            self.hasJoker = true
        }
        else {
            self.hasJoker = false
        }
    }
    
    func getCards() -> [Card] {
        return cards;
    }
    
    func getType() -> types {
        return type;
    }
    
    func getCount() -> Int {
        return cards.count;
    }
    
    func setIsClosed(bool:Bool) -> Void {
        self.isClosed = bool;
    }
    
    func getIsClosed() -> Bool {
        return self.isClosed;
    }
    
    func setClosedType(type:ClosedTypes) -> Void {
        closedType = type;
    }
    
    func getClosedType() -> ClosedTypes {
        return closedType;
    }
    
    func getClosedPV() -> Int {
        switch(closedType) {
            case .clean:
                return 500
            case .dirty:
                return 300
            case .semi:
                return 400
            case .jokers:
                return 1000
            case .notClosed:
                print("error: meld not closed")
                return 1
        }
    }
    
    func getHasJoker() -> Bool {
        return hasJoker
    }
    
    func getJokerIndex() -> Int {
        assert(hasJoker, "error: meld does not have joker")
        var jokerIndex:Int? = nil
        for i in 0..<getCount() {
            if getCards()[i].getCardIsJoker() {
                jokerIndex = i
            }
        }
        return jokerIndex!
    }
    
    func replaceJoker(card:Card) -> Card {
        assert(hasJoker, "error: meld does not have joker")
        let joker = cards[getJokerIndex()]
        cards[getJokerIndex()] = card
        return joker 
    }
    
    func setHasJoker(bool:Bool) -> Void {
        hasJoker = bool 
    }
    
    func addCard(card:Card, index:Int) -> Void {
        assert(index < cards.count, "index_out_of_bounds")
        cards.insert(card, at: index);
    }
    
    func addCards(cards:[Card], indecies:[Int]) -> Void {
        assert(indecies.max()! < cards.count, "index_out_of_bounds")
        for i in 0...cards.count {
            addCard(card:cards[i], index:indecies[i])
        }
    }
    
    static func == (lhs: Meld, rhs: Meld) -> Bool {
        if lhs.getType() == rhs.getType() {
            for card in lhs.getCards() {
                for card2 in rhs.getCards() {
                    if card == card2 {
                        return true
                    }
                }
            }
        }
        else{
            return false
        }
        return false
    }

}
