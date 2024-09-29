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
    public enum values: Int {
        case ace = 13;
        case king = 12;
        case queen = 11;
        case jack = 10;
        case joker = 1;
    }
    
    private var value:Int;
    private var suit:suits;
    private var isSpecial:Bool;
    private var pointValue:Int;
    
    init(suit:suits, value:Int){
        self.suit = suit;
        self.value = value;
        self.isSpecial = false;
        
        if(value < 8){
            self.pointValue = 5;
        } else if(7 < value && value < 13){
            self.pointValue = 10;
        } else if(value == 13){
            self.pointValue = 15;
        }
        else {
            self.pointValue = 0;
            print("error: value_out_of_bounds")
        }
    }
    
    init(suit: suits, value:Int, isSpecial:Bool){
        self.suit = suit;
        self.value = value;
        self.isSpecial = isSpecial;
        if (isSpecial && value == 2){
            self.pointValue = 25;
        } else if(isSpecial && value == 1){
            self.pointValue = 50;
        } else if(value < 8){
            self.pointValue = 5;
        } else if(7 < value && value < 13){
            self.pointValue = 10;
        } else if(value == 13){
            self.pointValue = 15;
        }
        else {
            self.pointValue = 0;
            print("error: value_out_of_bounds");
        }
    }
    
    func getCardValue() -> Int {
        return self.value;
    }
    
    func getCardSuit() -> suits {
        return self.suit;
    }
    
    func getCardPointValue() -> Int {
        return self.pointValue;
    }
    
    func getCardIsSpecial() -> Bool {
        return self.isSpecial;
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.getCardSuit() == rhs.getCardSuit() && lhs.getCardValue() == rhs.getCardValue()
    }
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.getCardValue() < rhs.getCardValue()
    }
    static func > (lhs: Card, rhs: Card) -> Bool {
        return lhs.getCardValue() > rhs.getCardValue()
    }
    
    
    
    
}
