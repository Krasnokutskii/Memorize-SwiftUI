//
//  EmojiMemoryGame.swift
//  EmojiMemoryGame
//
//  Created by Ярослав on 1/27/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    static let vehicles = ["🛳","✈️","🚁","🚙","🚎","🚛","🚕","🚐","🚝","🛵","🚲","🏍","🛴","🚂","🚡","🚒","🚤","⛵️","⛽️"]
    static let activity = ["💃","⚽️","🎼","🏋️‍♂️","🚴","🏂","🤺","🧘‍♀️","🎾","🏈"]
    static let flowers = ["🌹","🌸","🌺","🌷","🌻","🌼","💐","🥀"]
    
    static func createMemoryGame(numberOfPairsOfCard: Int)->MemoryGame<String>{
        let theme: MemoryGame<String>.CardTheme = .allCases.randomElement() ?? .vehicles
        var currentEmojis = [String]()
        switch theme{
        case .activity:
            currentEmojis = activity.shuffled()
        case .flowers:
            currentEmojis = flowers.shuffled()
        case .vehicles:
            currentEmojis = vehicles.shuffled()
        }
        let memoryGame = MemoryGame(theme: theme, numberOfPairsOfCard: numberOfPairsOfCard) { num in
            return currentEmojis[num]
        }
        return memoryGame
    }
    
    @Published private var model = createMemoryGame(numberOfPairsOfCard: 4)
    
    var cards: [MemoryGame<String>.Card]{
        return model.cards
    }
    var themeName: String{
        return model.themeName
    }
    
    var theme: MemoryGame<String>.CardTheme{
        return model.cardTheme
    }
    //MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    func newGame(){
        model = EmojiMemoryGame.createMemoryGame(numberOfPairsOfCard: Int.random(in: 2..<6))
    }
    
    

}
