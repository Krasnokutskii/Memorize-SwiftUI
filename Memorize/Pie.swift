//
//  Pie.swift
//  Pie
//
//  Created by Ярослав on 1/31/22.
//

import SwiftUI

struct Pie: Shape{
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false 
    
    
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height)/2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),//radius * cos = 10 * 0.2 = 5
            y: center.y + radius * CGFloat(sin(startAngle.radians))//radius * sin = 10 * 0.8 = 8
            )
        var path = Path()
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        path.addLine(to: center)
        
        return path
    }
    
    
}

