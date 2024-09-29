//
//  Player.swift
//  Buraco fin
//
//  Created by Natalia Caldera on 9/28/24.
//

import Foundation

class Player {
    
    private var hand:[Card];
    private var meldsInPlay:[Card];
    private var name:String;
    private var closedMelds:[[Card]];
    private var hasBuraco:Bool;
    private var currentScore:Int;
    
    
    init(name:String, hand:[Card]){
        self.name = name
        self.hand = hand
        meldsInPlay = []
        closedMelds = []
        hasBuraco = false
        currentScore = 0
    }
    
    func getHand() -> [Card] {
        return hand
    }
    
    func setHasBuraco(bool:Bool) -> Void {
        hasBuraco = bool;
    }
    
    func getHasBuraco() -> Bool {
        return hasBuraco
    }
    
    func getCurrentScore() -> Int {
        return currentScore
    }
    
    func addToCurrentScore(score:Int) -> Void {
        currentScore += score
    }
    
    func getName() -> String {
        return name
    }
    
    func getCardInHand(index:Int) -> Card {
        return hand[index]
    }
    
    //TODO: create funcs drawCard, drawDiscardPile, discardCard, addMeld, placeMeld, insertJoker, closeMeld, placeCardInMeld, getBuraco
}
