//
//  BadgeBackground.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 19/05/2022.
//

import SwiftUI

struct BadgeBackground: View {
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    
    var body: some View {
        GeometryReader { geometry in //Wrap the path in a GeometryReader so the badge can use the size of its containing view, which defines the size instead of hard-coding with the value 100.
            Path { path in //You use paths to combine lines, curves, and other drawing primitives to form more complex shapes like the badge’s hexagonal background.
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height: CGFloat = min(geometry.size.width, geometry.size.height)
                let xScale: CGFloat = 0.832 //Scale the shape on the x-axis using xScale
                let xOffset = (width * (1 - xScale)) / 2.0 //recenter the shape within its geometry(moves shape them the left hand edge of the screen and centers it along the x-axis).
                width *= xScale //width = width * xScale
                
                path.move( //Moves the drawing cursor within the bounds of a shape as though an imaginary pen or pencil is hovering over the area, waiting to start drawing. In other words this determines where the drawing will begin, so the segments(x,y points) in the segment array in HexagonParameters are defined with this in mind(where the drawing begins) so if you change the below points, you also have to adjust the array segments to move the hexagon along with it otherwise the drawing will be out of shape.
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment))
                )
                
                HexagonParameters.segments.forEach { segment in
                    path.addLine( //method takes a single point and draws it. Successive calls to addLine(to:) begin a line at the previous point and continue to the new point.
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )
                    
                    path.addQuadCurve( //method to draw the Bézier curves for the badge’s corners(curved part of each segment at the shape’s corners).
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            .fill(.linearGradient(
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            )) //You can also simply fill it with a color e.g. .fill(.black) but here, we replace this with a gradient.
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
