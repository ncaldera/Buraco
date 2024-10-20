//
//  GameRules.swift
//  Buraco
//
//  Created by Natalia Caldera on 10/19/24.
//

import Foundation
class GameRules {
    
    
    init(){
    }
    func CheckIfCanAddMeldToSpread(meld: Meld, player: Player) -> Bool{
        var currentMelds: [Meld] = player.getMeldsInPlay()
        var currentMeldType:Meld.types = meld.getType()
        
        if currentMeldType == Meld.types.sameValue {
            for m in currentMelds {
                if m.getType() == Meld.types.sameValue {
                    if m.getCards()[0].getCardRank() == meld.getCards()[0].getCardRank(){
                        return false
                    }
                }
            }
        }
        else if currentMeldType == Meld.types.straight{
            for m in currentMelds {
                if m.getType() == Meld.types.straight{
                    if m.getCards()[0].getCardSuit() == meld.getCards()[0].getCardSuit() || m.getCards()[0].getCardSuit() == meld.getCards()[1].getCardSuit() ||
                        m.getCards()[1].getCardSuit() == meld.getCards()[0].getCardSuit() || m.getCards()[1].getCardSuit() == meld.getCards()[1].getCardSuit(){
                        return false
                    }
                }
            }
        }
        else {
            for m in currentMelds {
                if m.getType() == .jokers && meld.getType() == .jokers{
                    return false
                }
            }
        }
        return true
    }
    
    
    func CheckSequence(cards: [Card]) -> Bool {
        var sortedCards = cards.sorted()

        
        for i in 0..<sortedCards.count - 1{
            if sortedCards[i].getCardSuit() != sortedCards[i+1].getCardSuit() {
                return false
            }
        }
        
        for i in 0..<sortedCards.count - 1 {
            if sortedCards[i].getCardRank() + 1 != sortedCards[i+1].getCardRank() {
                return false
            } else if sortedCards[0].getCardRank() != 1  && sortedCards[1].getCardRank() != 3{
                return false
            }
        }
        
        return true
    }
    
    
    func CheckMeldOneOfAKind(meld: [Card]) -> Bool {
        for i in 0..<meld.count - 1 {
            if meld[i].getCardRank() != meld[i+1].getCardRank() {
                return false
            }
        }
        return false
    }
    
    
    func CheckOkToPickDiscardPile(player: Player, discardPile:Deck) -> Bool {
        var bool = false
        for i in 0..<player.getHand().count - 1 {
            bool = CheckSequence(cards: [discardPile.getTopCard(), player.getHand()[i], player.getHand()[i + 1]] )
            if bool {
                return true
            }
        }
        return false
    }
    
    
    func CheckCanChooseFirstCard(players: [Player], player: Player) -> Bool {
        return (player.getName() == players[0].getName())
    }
    
    func CheckCanCloseMeld(meld: Meld) -> Bool {
        return (meld.getCount() >= 7)
    }
    
    func CheckCanPlaceCard(card: Card, player: Player) -> Bool {
        var melds: [Meld] = player.getMeldsInPlay()
        for meld in melds {
            var newMeld: [Card] = meld.getCards()
            newMeld.append(card)
            if (CheckSequence(cards: newMeld) || CheckMeldOneOfAKind(meld: newMeld)){
                return true
            }
        }
        return false
    }
    
    func CheckCanGetBuraco(player: Player) -> Bool {
        var hand: [Card] = player.getHand()

        if hand.count == 0 {
            return true
        } else if !player.getMeldsInPlay().isEmpty{
            for meld in player.getMeldsInPlay() {
                if meld.getType() == .jokers {
                    return false
                }
            }
        } else if (hand.count == 1 || hand.count == 2){
            for card in hand {
                if !card.getCardIsJoker() {
                    return false
                }
            }
            return true
        } else {
            return false
        }
        return false 
    }
    
    
    func CheckCanWin(player: Player) -> Bool {
        if((player.getClosedMelds().count > 0) && (player.getHasBuraco()) && (player.getHand().count == 0)){
            
            return true
        }
        else {
            return false
        }
        
    }
    
    func CheckCanPlayDirectly(player: Player) -> Bool {
        if player.getLastAction() == .discardCard {
            return false
        }
        else {
            return true
        }
        
    }
    
    func CountPoints(player: Player) -> Int{
        var points: Int = 0
        if (player.hasWon) {
            points = 100
            for meld in player.getClosedMelds(){
                points += meld.getClosedPV()
            }
            for meld in player.getMeldsInPlay(){
                for card in meld.getCards(){
                    points += card.getCardPointValue()
                }
            }
        }
        else if (player.getHasBuraco()){
            for meld in player.getClosedMelds(){
                points += meld.getClosedPV()
            }
            for meld in player.getMeldsInPlay(){
                for card in meld.getCards(){
                    points += card.getCardPointValue()
                }
            }
            for card in player.getHand(){
                points -= card.getCardPointValue()
            }
        }
        else {
            for meld in player.getClosedMelds(){
                points += meld.getClosedPV()
            }
            for meld in player.getMeldsInPlay(){
                for card in meld.getCards(){
                    points -= card.getCardPointValue()
                }
            }
            for card in player.getHand(){
                points -= card.getCardPointValue()
            }
        }
        
        return points;
    }
}
