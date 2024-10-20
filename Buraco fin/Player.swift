//
//  Player.swift
//  Buraco fin
//
//  Created by Natalia Caldera on 9/28/24.
//

import Foundation

class Player {
    
    enum Actions {
        case discardCard
        case drawCard
        case none
    }
    
    private var hand:[Card];
    private var meldsInPlay:[Meld];
    private var name:String;
    private var closedMelds:[Meld];
    private var hasBuraco:Bool;
    private var currentScore:Int;
    private var lastAction: Actions;
    var hasWon: Bool; 
    
    
    init(name:String, hand:[Card]){
        self.name = name
        self.hand = hand
        meldsInPlay = []
        closedMelds = []
        hasBuraco = false
        currentScore = 0
        lastAction = .none
        hasWon = false
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
    
    func getClosedMelds() -> [Meld] {
        return closedMelds
    }
    
    
    func getCardInHand(index:Int) -> Card {
        return hand[index]
    }
    
    func getLastAction() -> Actions {
        return lastAction
    }
    
    
    func discardCard(card:Card) -> Card {
        assert(hand.contains(card))
        guard var index = hand.firstIndex(of: card) else { return card }
        hand.remove(at: index)
        lastAction = .discardCard
        return card

    }
    
    func drawCard(deck:Deck) -> Void {
        hand.append(deck.getTopCard());
        deck.removeCard(index: 0)
        lastAction = .drawCard
    }
    
    func drawDiscardPile(discardPile:Deck) -> Void{
        for i in 0...(discardPile.getSize() - 1) {
            let temp = discardPile.getTopCard()
            discardPile.removeCard(index:0)
            hand.append(temp)
        }
        lastAction = .drawCard
    }
    
    func placeMeld(meld:Meld) -> Void{
        meldsInPlay.append(meld)

    }
    
    func closeMeld(meld:Meld)-> Void {
        meld.setIsClosed(bool: true);
        var cards: [Card] = meld.getCards();
        var type:Meld.ClosedTypes = Meld.ClosedTypes.notClosed;
        var temp:Card = Card();
        var countJokers:Int = 0;
        //count how many jokers are in meld
        for card in cards {
            if card.getCardIsJoker() {
                temp = card;
                countJokers += 1;
            }
        }
        //if only 1 joker, check if semi or dirty
        if (countJokers == 1) {
            if (meld.getType() == Meld.types.sameValue) {
                type = Meld.ClosedTypes.dirty;
            }
            else if (meld.getType() == Meld.types.straight){
                if (temp.getCardSuit() == cards[0].getCardSuit()) && (temp.getCardSuit() == cards[1].getCardSuit()){
                    type = Meld.ClosedTypes.semi;
                } else {
                    type = Meld.ClosedTypes.dirty;
                }
            }
            // if multiple jokers, set to meld of jokers
        } else if (countJokers > 1){
            type = Meld.ClosedTypes.jokers;
            
        }
        //set melds closed type
        meld.setClosedType(type: type);
        
        //remove meld from the ones in play
        for i in 0...meldsInPlay.count - 1 {
            if meld == meldsInPlay[i] {
                meldsInPlay.remove(at: i);
            }
        }
        //add meld to closed melds
        closedMelds.append(meld);
    }

    func placeCardInMeld(card:Card, meld:Meld) -> Void{
        //if card is an Ace
        if (card.getCardRank() == Card.ranks.ace1.rawValue || card.getCardRank() == Card.ranks.ace14.rawValue) {
            if meld.getType() == Meld.types.sameValue {
                meld.addCard(card: card, index: meld.getCount() - 1)
            } else if(meld.getType() == Meld.types.straight) {
                if (meld.getCards()[0].getCardRank() == 3 ){
                    meld.addCard(card: card, index: 0)
                } else if(meld.getCards()[meld.getCount() - 1].getCardRank() == 13){
                    meld.addCard(card: card, index: meld.getCount() - 1)
                }
            } else {
                print("error, card cannot be added to meld")
            }
        }
        //if the meld is of same value, add card to the end
        else if (meld.getType() == Meld.types.sameValue) {
            meld.addCard(card: card, index:meld.getCount() - 1)
            //if the meld is a sequence, put the card into the right spot
        } else if (meld.getType() == Meld.types.straight){
            for i in 0..<meld.getCount() {
                if (card < meld.getCards()[i + 1]) && (card > meld.getCards()[i]) {
                    meld.addCard(card: card, index: i + 1)
                }
            }
            if card < meld.getCards()[meld.getCount() - 1]{
                meld.addCard(card: card, index: meld.getCount() - 1)
            }
        } else {
            print ("Error: meld does not have type or Card cannot be inseted")
        }
        //if card is a joker
        if (card.getCardIsJoker()) {
            print("Card is joker, use other function")
        }
    }
    
    func placeJokerInMeld(joker:Card, meld:Meld, upOrDown:String) -> Void {
        if (joker.getCardIsJoker()){
            if meld.getHasJoker() && meld.getType() != .jokers{
                print("error: meld already has joker")
            } else if(meld.getType() == .sameValue) {
                meld.addCard(card:joker, index: 0)
                meld.setHasJoker(bool: true)
                joker.setJokerRank(rank: meld.getCards()[1].getCardRank())
            } else if(meld.getType() == .straight) {
                if upOrDown == "up" {
                    meld.addCard(card: joker, index: meld.getCount() - 1)
                    meld.setHasJoker(bool: true)
                    joker.setJokerRank(rank: meld.getCards()[meld.getCount() - 1].getCardRank() + 1)
                } else if upOrDown == "down" {
                    meld.addCard(card: joker, index: 0)
                    meld.setHasJoker(bool: true)
                    if meld.getCards()[1].getCardRank() == 3{
                        joker.setJokerRank(rank: 1)
                    } else {
                        joker.setJokerRank(rank: meld.getCards()[meld.getCount() - 1].getCardRank() - 1)
                    }
                    
                } else {
                    print("error: upOrDown string is wrong")
                }
            } else if(meld.getType() == .jokers) {
                meld.addCard(card: joker, index: 0)
            } else {
                print("error: meld has no type")
            }
        }
        print("error: card is not a joker use other funtion")
    }
    
    func placeCardsInMeld(cards: [Card], meld: Meld) -> Void {
        var countJokers = cards.filter { $0.getCardIsJoker() }.count
        var jokerIndex: Int? = nil
        
        // Find the first Joker index from the incoming cards
        for i in 0..<cards.count {
            if cards[i].getCardIsJoker() {
                jokerIndex = i
                break
            }
        }
        
        // Handle when there are no jokers in the new cards
        if countJokers == 0 {
            if meld.getType() == .sameValue {
                for card in cards {
                    placeCardInMeld(card: card, meld: meld)
                }
            } else if meld.getType() == .straight {
                var bool = false
                if (meld.getHasJoker()) {
                    for card in cards {
                        if card.getCardRank() == meld.getCards()[meld.getJokerIndex()].getCardRank(){
                            let joker = meld.replaceJoker(card: card)
                            var newCards = cards
                            newCards.append(joker)
                            placeCardsInMeld(cards: newCards, meld: meld)
                        }
                    }
                } else {
                    var cardsAbove = [Card]() // Cards greater than the last card in the meld
                    var cardsBelow = [Card]() // Cards smaller than the first card in the meld
                    
                    
                    // Handle placing new cards above or below the meld
                    for i in 0..<cards.count {
                        if cards[i] < meld.getCards()[0] {
                            cardsBelow.append(cards[i])
                        } else if cards[i] > meld.getCards()[meld.getCount() - 1] {
                            cardsAbove.append(cards[i])
                        }
                    }
                    
                    cardsBelow.sort()
                    cardsAbove.sort()
                    
                    for card in cardsBelow {
                        placeCardInMeld(card: card, meld: meld)
                    }
                    
                    for card in cardsAbove {
                        placeCardInMeld(card: card, meld: meld)
                    }
                }
            }
        }
        // Handle the case where there is exactly one Joker
        else if countJokers == 1, let jokerIdx = jokerIndex {
            if meld.getType() == .sameValue {
                let sortedCards = cards.sorted()
                // Place the non-joker cards first
                for card in sortedCards where !card.getCardIsJoker() {
                    placeCardInMeld(card: card, meld: meld)
                }
                // Place the Joker
                placeJokerInMeld(joker: cards[jokerIdx], meld: meld, upOrDown: "")
            } else if meld.getType() == .straight {
                var cardsAbove = [Card]() // Cards greater than the last card in the meld
                var cardsBelow = [Card]() // Cards smaller than the first card in the meld
                
                
                // Handle placing new cards above or below the meld
                for i in 0..<cards.count {
                    if i != jokerIdx {
                        if cards[i] < meld.getCards()[0] {
                            cardsBelow.append(cards[i])
                        } else if cards[i] > meld.getCards()[meld.getCount() - 1] {
                            cardsAbove.append(cards[i])
                        }
                    }
                }
                
                cardsBelow.sort()
                cardsAbove.sort()
                
                if (cardsBelow.count > 0) {
                    if (cardsBelow[cardsBelow.count - 1].getCardRank() - meld.getCards()[0].getCardRank() > 1)  {
                        placeJokerInMeld(joker: cards[jokerIdx], meld: meld, upOrDown: "down")
                        
                    } else if (meld.getCards()[0].getCardRank() == 3 && cardsBelow[cardsBelow.count - 1].getCardRank() != 1) {
                        placeCardInMeld(card: cardsBelow[cardsBelow.count - 1], meld: meld)
                        
                    }
                }
                
                for card in cardsBelow {
                    placeCardInMeld(card: card, meld: meld)
                }
                
                if (cardsAbove.count > 0) {
                    if (cardsAbove[0].getCardRank() - meld.getCards()[meld.getCount() - 1].getCardRank() > 1)  {
                        placeJokerInMeld(joker: cards[jokerIdx], meld: meld, upOrDown: "up")
                    }
                }
                
                for card in cardsAbove {
                    placeCardInMeld(card: card, meld: meld)
                }
                
            } else  if(countJokers == cards.count && meld.getType() == .jokers){
                for card in cards {
                    placeJokerInMeld(joker: card, meld: meld, upOrDown: "")
                }
            } else {
                print("error: too many jokers")
            }
        }
    }
    
    func getBuraco(buraco:Deck) -> Void{
        for i in 0..<buraco.getSize() {
            hand.append(buraco.getCard(index: i))
        }
        for i in 0..<buraco.getSize() {
            buraco.removeCard(index: i)
        }
    }
    
    func getMeldsInPlay() -> [Meld] {
        return meldsInPlay
    }
}
