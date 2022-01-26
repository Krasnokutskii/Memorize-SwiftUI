//
//  ContentView.swift
//  Memorize
//
//  Created by Ярослав on 1/26/22.
//

import SwiftUI

let vehicles = ["🛳","✈️","🚁","🚙","🚎","🚛","🚕","🚐","🚝","🛵","🚲","🏍","🛴","🚂","🚡","🚒","🚤","⛵️","⛽️"]
let activity = ["💃","⚽️","🎼","🏋️‍♂️","🚴","🏂","🤺","🧘‍♀️","🎾","🏈"]
let flowers = ["🌹","🌸","🌺","🌷","🌻","🌼","💐","🥀"]

struct ContentView: View {
    
   
    
    @State var emojis = vehicles

    @State var emojiCount = 6
    
    var body: some View {
        VStack{
            Text("Memorize").font(.largeTitle)
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum:50, maximum: 200))]){
                    ForEach(emojis.shuffled()[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).font(.largeTitle).aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .padding()
            }
            Spacer()
            HStack{
                vehicleThemeButton
                Spacer()
                activityThemeButton
                Spacer()
                flowersThemeButton
            }.padding()
            
            //            HStack{
            //                add
            //                Spacer()
            //                remove
            //            }
            //            .font(.largeTitle)
            //            .padding(.horizontal)
            
        }
    }
    
    var vehicleThemeButton: some View{
        Button {
            emojis = vehicles
        } label: {
            VStack{
                Image(systemName: "car").font(.largeTitle)
                Text("Vehicle")
            }
        }

    }
    var activityThemeButton: some View{
        Button {
            emojis = activity
        } label: {
            VStack{
                Image(systemName: "figure.walk").font(.largeTitle)
                Text("Activity")
            }
            
        }

    }
    var flowersThemeButton: some View{
        Button {
            emojis = flowers
        } label: {
            VStack{
                Image(systemName: "leaf.fill").font(.largeTitle)
                Text("Flowers")
            }
            
        }

    }
    
    var add: some View{
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
    var remove: some View{
        Button {
            if emojiCount > 1{
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }

    }
}

struct CardView: View {
  
    @State var isFaceUp = true
    var content: String
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 15)
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3).foregroundColor(.red)
                Text(content)
            }else{
                shape.fill().foregroundColor(.red)
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
