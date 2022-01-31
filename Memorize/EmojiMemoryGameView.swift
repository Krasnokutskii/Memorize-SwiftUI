//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ярослав on 1/26/22.
//

import SwiftUI


struct EmojiMemoryGameView: View {

    @ObservedObject var viewModel: EmojiMemoryGame
    
    
    
    var body: some View {
        VStack{
            titleLabel
            gameBody
            Spacer()
            HStack(spacing: 10){
                newGameButton
                shuffleButton
            }
            .padding()
        }
    }
    
    
    //MARK: - View Vars
    private var titleLabel: some View{
        Text("\(viewModel.themeName)").font(.largeTitle)
    }
    
    private var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            cardView(card)
        }.transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
    }
    
    private var shuffleButton: some View{
        Button {
            withAnimation {
                viewModel.shuffle()
            }
        } label: {
            HStack{
                ZStack{
                    Text("Shuffle")
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(lineWidth: 5)
                        .foregroundColor(.blue)
                        .frame(height: 50 )
                }
            }
        }
    }
    
    private var newGameButton: some View{
        Button {
            withAnimation {
                viewModel.newGame()
            }
        } label: {
            HStack{
                ZStack{
                    Text("New Game")
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(lineWidth: 5)
                        .foregroundColor(.blue)
                        .frame(height: 50 )
                }
            }
        }
    }
    
    //MARK: - View Funcs
    @ViewBuilder
    private func cardView(_ card: EmojiMemoryGame.Card)->some View {
        if card.isMatched && !card.isFaceUp{
            Color.clear
        }else{
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        viewModel.choose(card)
                    }
                }
        }
    }

}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    
    var body: some View{
        GeometryReader{ geometry in
  
            ZStack{
                Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(350 - 90), clockwise: false)
                    .opacity(0.5)
                    .padding(5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
            .foregroundColor(.red)
        }
    }
    private func scale(thatFits size: CGSize)->CGFloat{
        min(size.height, size.width)/(DrawingConstants.fontSize/DrawingConstants.fontScale)
    }
   
}

private struct DrawingConstants{
    static let fontScale: CGFloat = 0.7
    static let fontSize: CGFloat = 32
}

//Animation




























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(viewModel: game)
    }
}
