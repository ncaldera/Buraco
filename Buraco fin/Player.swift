//
//  Player.swift
//  Buraco fin
//
//  Created by Natalia Caldera on 9/28/24.
//

import Foundation

class Player {
    
    private var hand:[Card];
    private var meldsInPlay:[Meld];
    private var name:String;
    private var closedMelds:[Meld];
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
    
    func drawCard(deck:Deck) -> Void {
        hand.append(deck.getTopCard());
        deck.removeCard(index: 0)
    }
    
    func drawDiscardPile(discardPile:Deck) -> Void{
        for i in 0...(discardPile.getSize() - 1) {
            let temp = discardPile.getTopCard()
            discardPile.removeCard(index:0)
            hand.append(temp)
        }
    }
    
    func placeMeld(meld:Meld) -> Void{
        meldsInPlay.append(meld)
    }
    
    func setJokerValue(cards:[Card], joker:Card) -> Void {
        //TODO: set joker value based on cards
            // - sequence vs card needed
        // think about if player wants to place joker on top or at bottom, maybe overload function to take in top or bottom with everything else, might also want to create one where they can insert the joker in a meld already placed
        var bool:Bool = true
        for i in 0..<cards.count - 1 {
            if cards[i].getCardValue() != cards[i+1].getCardValue() {
                bool = false
            }
        }
        if bool {
            joker.setCardValue(value: cards[0].getCardValue())
        }
        for i in 0..<cards.count - 1 {
            if cards[i].getCardValue() - cards[i + 1].getCardValue() > 1 {
                joker.setCardValue(value: cards[0].getCardValue() + 1)
            }
        }
    }
    
    func closeMeld(meld:Meld)-> Void {
        meld.setIsClosed(bool: true)
        var cards: [Card] = meld.getCards()
        var type:Meld.ClosedTypes = Meld.ClosedTypes.notClosed;
        var temp:Card;
        var countSpecial:Int = 0;
        for card in cards {
            if card.getCardIsSpecial() {
                temp = card
                countSpecial += 1
            }
        }
        if true {//search up how to check if variable exists when
            if (meld.getType() == Meld.types.sameValue) {
                type = Meld.ClosedTypes.dirty
            }
            else if (meld.getType() == Meld.types.straight){
                if (temp.getCardSuit() == cards[0].getCardSuit()) && (temp.getCardSuit() == cards[1].getCardSuit()){
                    type = Meld.ClosedTypes.semi
                } else {
                    type = Meld.ClosedTypes.dirty
                }
            } else if (countSpecial > 0){
                type = Meld.ClosedTypes.jokers
            }
        }
        
        meld.setClosedType(type: type)
        for i in 0...meldsInPlay.count - 1 {
            if meld == meldsInPlay[i] {
                meldsInPlay.remove(at: i)
            }
        }
        closedMelds.append(meld)
    }
    
    func placeCardInMeld(card:Card, meld:Meld) -> Void{
        if meld.getType() == Meld.types.sameValue{
            meld.addCard(card: card, index:meld.getCount())
        } else if (meld.getType() == Meld.types.straight){
            for i in 0..<meld.getCount() {
                if (card < meld.getCards()[i + 1]) && (card > meld.getCards()[i]) {
                    meld.addCard(card: card, index: i + 1)
                }
            }
            if card < meld.getCards()[meld.getCount() - 1]{
                meld.addCard(card: card, index: meld.getCount() - 1)
            }
        } else if (meld.getType() == Meld.types.jokers) && (card.getCardIsSpecial()){
            meld.addCard(card: card, index: 0)
        } else {
            print ("Error: meld does not have type or Card cannot be inseted")
        }
    }
    
    func placeCardsInMeld(cards:[Card], meld:Meld) -> Void{
        //use joker imput function and card function to create array of indecies to pass into addcards
    }
    
    func getBuraco(buraco:Deck) -> Void{
        for i in 0..<buraco.getSize() {
            hand.append(buraco.getCard(index: i))
        }
        for i in 0..<buraco.getSize() {
            buraco.removeCard(index: i)
        }
    }
}
