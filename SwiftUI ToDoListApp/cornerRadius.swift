//
//  cornerRadius.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/08.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

struct CornerRadius: Shape {
    
    var topRight: CGFloat = 0.0
    var topLelt: CGFloat = 0.0
    var bottomRight: CGFloat = 0.0
    var bottomLeft: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.size.width
        let height = rect.size.height
        let topRight = min(min(self.topRight, height / 2), width / 2)
        let topRelt = min(min(self.topLelt, height / 2), width / 2)
        let bottomRight = min(min(self.bottomRight, height / 2), width / 2)
        let bottomReft = min(min(self.bottomLeft, height / 2), width / 2)
        
        path.move(to: CGPoint(x: width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: width - topRight, y: 0))
        path.addArc(center: CGPoint(x: width - topRight, y: topRight), radius: topRight, startAngle: Angle(degrees: -90), endAngle:  Angle(degrees: 0), clockwise: false)
        
        path.addLine(to: CGPoint(x: width, y: height - bottomRight))
        path.addArc(center: CGPoint(x: width - bottomRight, y: height - bottomRight), radius: bottomRight, startAngle: Angle(degrees: 0), endAngle:  Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bottomLeft, y: height))
        path.addArc(center: CGPoint(x: bottomLeft, y: height - bottomLeft), radius: bottomLeft, startAngle: Angle(degrees: 90), endAngle:  Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: topRelt))
        path.addArc(center: CGPoint(x: topLelt, y: topLelt), radius: topLelt, startAngle: Angle(degrees: 180), endAngle:  Angle(degrees: 270), clockwise: false)
        path.closeSubpath()


        return path

    }
}

struct cornerRadius_Previews: PreviewProvider {
    static var previews: some View {
        CornerRadius(topRight: 30, topLelt: 30, bottomRight: 30, bottomLeft: 30).stroke().padding()
    }
}
