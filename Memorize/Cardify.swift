//
//  Cardify.swift
//  Cardify
//
//  Created by Ярослав on 1/31/22.
//

import SwiftUI

struct Cardify: AnimatableModifier{
    
    var rotation: Double
    var animatableData: Double{
        get{ rotation}
        set{ rotation = newValue}
    }
    
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content)->some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            if rotation < 90{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            }else{
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1.0 : 0.0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    
}

private struct DrawingConstants{
    static let cornerRadius: CGFloat = 15
    static let lineWidth: CGFloat = 3
}

extension View{
    func cardify(isFaceUp: Bool)-> some View{
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
