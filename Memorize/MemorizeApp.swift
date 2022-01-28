//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ярослав on 1/26/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            ContentView(viewModel: game)
        }
    }
}
