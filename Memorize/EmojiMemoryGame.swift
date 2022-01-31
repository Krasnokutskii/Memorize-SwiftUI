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
    typealias Card = MemoryGame<String>.Card
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
    
    @Published private var game = createMemoryGame(numberOfPairsOfCard: 4)
    
    var cards: [Card]{
        return game.cards
    }
    var themeName: String{
        return game.themeName
    }
    
    var theme: MemoryGame<String>.CardTheme{
        return game.cardTheme
    }
    //MARK: - Intent(s)
    
    func choose(_ card: Card){
        game.choose(card)
    }
    
    func newGame(){
        game = EmojiMemoryGame.createMemoryGame(numberOfPairsOfCard: Int.random(in: 2..<8))
    }
    
    func shuffle(){
        game.shuffle()
    }
    
    

}
