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
    
    init(cards: [Card], type: types){
        self.cards = cards;
        self.type = type;
        self.isClosed = false;
        self.closedType = ClosedTypes.notClosed;
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
    
    func addCard(card:Card, index:Int) -> Void {
        cards.insert(card, at: index);
    }
    
    func addCards(cards:[Card], indecies:[Int]) -> Void {
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
