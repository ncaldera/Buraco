//
//  Card.swift
//  Buraco fin
//
//  Created by Natalia Caldera on 9/28/24.
//

import Foundation

class Card: Comparable {
    
    public enum suits{
        case heart;
        case spade;
        case club;
        case diamond;
        case joker; 
    }
    public enum ranks: Int {
        //default for ace should be ace1
        case ace1 = 1;
        case ace14 = 14;
        case king = 12;
        case queen = 11;
        case jack = 10;
        case joker = 0;
    }
    public enum values {
        case joker;
        case unknown;
        case rank;
    }
    
    private var rank:Int;
    private var suit:suits;
    private var pointValue:Int;
    private var value: values;
    
    init(suit:suits, rank:Int, value:values){
        assert(rank >= 0)
        
        self.suit = suit;
        self.rank = rank;
        self.value = value;
        
        if (value == .joker) {
            if (rank == 2) {
                self.pointValue = 25;
            }
            else if (rank == 0) {
                self.pointValue = 50;
            }
            else {
                self.pointValue = 20;
                print("error: value_out_of_bounds")
            }
        }
        else if(1 < rank && rank < 8){
            self.pointValue = 5;
        } else if(7 < rank && rank < 14){
            self.pointValue = 10;
        } else if(rank == 1 || rank == 14){
            self.pointValue = 15;
        }
        else {
            self.pointValue = 20;
            print("error: value_out_of_bounds")
        }
    }
    
    convenience init(suit: suits, rank:Int){
        self.init(suit: suit, rank: rank, value: .rank)
    }
    convenience init(){
        self.init(suit: .spade, rank: 20, value: .unknown)
    }
    
    func getCardRank() -> Int {
        return self.rank;
    }
    
    func getCardSuit() -> suits {
        return self.suit;
    }
    
    func getCardPointValue() -> Int {
        return self.pointValue;
    }
    
    func getCardIsJoker() -> Bool {
        return (self.value == .joker);
    }
    func setJokerRank(rank:Int) -> Void {
        self.rank = rank;
    }
    func setAceRank(rank:Int) -> Void {
        assert(rank == 1 || rank == 14, "Card_is_not_an_ace");
        self.rank = rank;
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.getCardSuit() == rhs.getCardSuit() && lhs.getCardRank() == rhs.getCardRank();
    }
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.getCardRank() < rhs.getCardRank();
    }
    static func > (lhs: Card, rhs: Card) -> Bool {
        return lhs.getCardRank() > rhs.getCardRank();
    }
    
    
    
    
}
