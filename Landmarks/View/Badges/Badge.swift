//
//  Badge.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 03/06/2022.
//

import SwiftUI

struct Badge: View {
    var badgeSymbols: some View {
        ForEach(0..<8) { index in // to rotate and display copies of the badge symbol.
            RotatedBadgeSymbol(angle: .degrees(Double(index) / Double(8))  * 360)
                
        }
        .opacity(0.5)
    }
    
    var body: some View {
        ZStack { //Lays the badge’s symbol over the badge background
            BadgeBackground()
            
            GeometryReader { geometry in //Correct the size of the badge symbol by reading the surrounding geometry and scaling the symbol.
                badgeSymbols
                    .scaleEffect(1.0 / 4.0, anchor: .top)
                    .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
            }
        }
        .scaledToFit()
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
