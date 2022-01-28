//
//  ContentView.swift
//  Memorize
//
//  Created by Ярослав on 1/26/22.
//

import SwiftUI


struct ContentView: View {

    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            Text("\(viewModel.themeName)").font(.largeTitle)
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum:100, maximum: 200))]){
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).font(.largeTitle).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
                .padding()
            }
            Spacer()
            Button {
                viewModel.newGame()
            } label: {
                HStack{
                    Spacer()
                    ZStack{
                        Text("New Game")
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(lineWidth: 5)
                            .foregroundColor(.blue)
                            .frame(height: 50 )
                    }
                    Spacer()
                }
            }

        }
    }
}

struct CardView: View {
  
    let card: MemoryGame<String>.Card
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 15)
            if card.isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3).foregroundColor(.red)
                Text(card.content)
            }else if card.isMatched{
                shape.opacity(0)
            }else{
                shape.fill().foregroundColor(.red)
            }

        }
 //               .onTapGesture {
//            card.isFaceUp = !card.isFaceUp
//        }
    }
}


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
    }
}
