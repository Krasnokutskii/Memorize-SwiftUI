//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Ярослав on 1/27/22.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent>where CardContent: Equatable {
    
    private(set) var cards = [Card]()
    
    private(set) var cardTheme: CardTheme
    
    var themeName: String{
        switch cardTheme{
        case .activity:
            return "Activity"
        case .flowers:
            return "Flowers"
        case .vehicles:
            return "Vehicles"
        }
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(theme: CardTheme, numberOfPairsOfCard: Int, createCardContent: (Int)->CardContent){
        for pairIndex in 0..<numberOfPairsOfCard{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2 ))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cardTheme = theme
        cards.shuffle()
       
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where:{ $0.id == card.id}),
        !cards[chosenIndex].isFaceUp,
        !cards[chosenIndex].isMatched{
            if let potentialMatchingIndex = indexOfOneAndOnlyFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchingIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchingIndex].isMatched = true
                }
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                for index in cards.indices{
                    cards[index].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("chosen card id \(cards))")
    }
    
    
    struct Card: Identifiable{
        
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
    enum CardTheme: CaseIterable{
        case activity
        case flowers
        case vehicles
    }
}
