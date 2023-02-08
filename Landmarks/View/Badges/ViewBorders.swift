//
//  ViewBorders.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 07/02/2023.
//

import SwiftUI

//Anything declared here is part of top level code.

//Method: 1
struct RoundedCorners: View {
    var color: Color
    var tl: CGFloat
    var tr: CGFloat
    var bl: CGFloat
    var br: CGFloat
    
    var body: some View {
        GeometryReader { geometry in //Gives us the view's(Rectangle's) size and coordinates
            Path { path in //You use paths to combine lines, curves, and other drawing primitives to form more complex shapes
                
                let w = geometry.size.width //15 points
                let h = geometry.size.height //100 points
                
                //Make sure we don't exceed size of the rectangle. min(x,y) returns the lesser of two comparable values, so if x is smaller than y, we return x.
                let tl = min(min(self.tl/2, h/2), w/2) //Returns 7.5(w/2) if min(self.tl/2, h/2) larger
                let tr = min(min(self.tr/2, h/2), w/2) //Returns 0(min(self.tr/2, h/2)) since w/2(7.5) is larger
                let bl = min(min(self.bl/2, h/2), w/2) //Returns 7.5(w/2) if min(self.bl/2, h/2) larger
                let br = min(min(self.br/2, h/2), w/2) //Returns 0(min(self.br/2, h/2)) since w/2(7.5) is larger
                
                //NB: Cursor starts from the upper left hand side of the view(rectangle) at (0,0) waiting to start drawing. We can move the drawing cursor within the bounds of a shape as though an imaginary pen or pencil is hovering over the area with path.move()
                //NB: The bounds of the shape are width: 15 and height: 100 so we can not define an x coordinate higher than 15 or a y coordinate higher than 100. If we do, the line draws and then comes back within the bounds.
                //NB: In Swiftui's path.addArc(), the standard cartasian system where clockwise is moving from positive y to positive x(like a clock) is "flipped". So in Swiftui, counterclockwise is actually clockwise. So in path.addArc(), when we specify "clockwise: false" we move positionally from -90(top) to 0(trailing) to 90(bottom) to 180(leading) to 270(top) again like a clock moves.
                path.move(to: CGPoint(x: w / 2.0, y: 0)) //Move cursor from (0,0) rightward to (15/2, 0) which is (7.5, 0). Cursor still yet to start drawing.
                path.addLine(to: CGPoint(x: w, y: 0)) //Draw a line from where the cursor currently is (7.5, 0) to (15,0) since 'w' is 15. Line won't show since you need three enclosed points in order to '.fill' color and we currently only have 2
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false) //Not drawn in this case.
                path.addLine(to: CGPoint(x: w, y: h)) //Cursor currently at (15,0). Draw line from (15,0) downward to (w, h)/(15, 100)
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false) //Not drawn in this case.
                path.addLine(to: CGPoint(x: bl, y: h)) //Cursor currently at (15, 100). Draw line from (15, 100) leftward to (bl, h)/(7.5, 100)
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false) //Draw an arc(curve) from a (7.5, 92.5) centre with a radius of 7.5
                path.addLine(to: CGPoint(x: 0, y: tl)) //Cursor currently at (7.5, 100). Draw a line from (7.5, 100) to (0,tl)/(0, 7.5)
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false) //Draw an arc(curve) from a (7.5, 7.5) centre with a radius of 7.5
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}

//Method: 2
extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return width
                case .leading, .trailing: return rect.height
                }
            }
            path.addRect(CGRect(x: x, y: y, width: w, height: h))
        }
        return path
    }
}

//Method: 4
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ViewBorders: View {
    
    var body: some View {
        VStack {
            Section(header:
                        Text("Various ways of drawing borders with SwiftUI")
                .font(Font.system(size: 20))
                .foregroundColor(Color.red)
            ){
                //Method: 1
                HStack(alignment: .top) {
                    //RoundedRectangle(cornerRadius: 30) //No overlay because the shape isn't wrapping around another view/control.
                    Rectangle()
                        .fill(Color("ColorShifts"))
                        .frame(width: 15, height: 100, alignment: .leading)
                        .background(RoundedCorners(color: .red, tl: 30, tr: 0, bl: 30, br: 0))
                        //.offset(x: 0, y: 0)
                    
                    Image("motorbike_delivery")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .leading)
                    VStack(alignment: .leading) {
                        Text("Prioritized")
                            .font(Font.system(size: 17))
                            .foregroundColor(.red)
                        //.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Text("Your deliveries are delivered sequentially as entered from point B-C-D to K. Ideal if some deliveries are more time sensitive than others.")
                            .multilineTextAlignment(TextAlignment.leading) //text was already aligned to 'leading' by the VStack that wraps this component, but we also need each line of the multiline text to begin at same place.
                            .font(Font.system(size: 13))
                            .foregroundColor(.black)
                    }
                }
                //.padding()
                .border(.red, width: 1) //Simple border that can't use a corner radius.
                
                //Method: 2
                HStack(alignment: .top) {
                    Image("motorbike_delivery")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .leading)
                    VStack(alignment: .leading) {
                        Text("Prioritized")
                            .font(Font.system(size: 17))
                            .foregroundColor(.red)
                        //.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Text("Your deliveries are delivered sequentially as entered from point B-C-D to K. Ideal if some deliveries are more time sensitive than others.")
                            .multilineTextAlignment(TextAlignment.leading) //text was already aligned to 'leading' by the VStack that wraps this component, but we also need each line of the multiline text to begin at same place.
                            .font(Font.system(size: 13))
                            .foregroundColor(.black)
                    }
                }
                //.padding()
                .border(width: 1, edges: [.top, .bottom], color: .red)
                .border(width: 10, edges: [.leading], color: .red)
                .border(width: 1, edges: [.trailing], color: .red)
                
                //Method: 3
                HStack(alignment: .top) {
                    Image("motorbike_delivery")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .leading)
                    VStack(alignment: .leading) {
                        Text("Prioritized")
                            .font(Font.system(size: 17))
                            .foregroundColor(.red)
                        //.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Text("Your deliveries are delivered sequentially as entered from point B-C-D to K. Ideal if some deliveries are more time sensitive than others.")
                            .multilineTextAlignment(TextAlignment.leading) //text was already aligned to 'leading' by the VStack that wraps this component, but we also need each line of the multiline text to begin at same place.
                            .font(Font.system(size: 13))
                            .foregroundColor(.black)
                    }
                }
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(.red), alignment: .top)
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(.red), alignment: .bottom)
                .overlay(RoundedRectangle(cornerRadius: 16).frame(width: 10, height: nil, alignment: .top).foregroundColor(.red), alignment: .leading)
                .overlay(Rectangle().frame(width: 1, height: nil, alignment: .top).foregroundColor(.red), alignment: .trailing)
                
                //Method: 4
                HStack(alignment: .top) {
                    //RoundedRectangle(cornerRadius: 30) //No overlay because the shape isn't wrapping around another view/control.
                    Rectangle()
                        .fill(.red)
                        .frame(width: 15, height: 100, alignment: .leading)
                        .cornerRadius (50, corners: .topLeft)
                        .cornerRadius(0, corners: .topRight)
                        .cornerRadius(50, corners: .bottomLeft)
                        .cornerRadius(0, corners: .bottomRight)
                        //.offset(x: 0, y: 0)
                    
                    Image("motorbike_delivery")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .leading)
                    VStack(alignment: .leading) {
                        Text("Prioritized")
                            .font(Font.system(size: 17))
                            .foregroundColor(.red)
                        //.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Text("Your deliveries are delivered sequentially as entered from point B-C-D to K. Ideal if some deliveries are more time sensitive than others.")
                            .multilineTextAlignment(TextAlignment.leading) //text was already aligned to 'leading' by the VStack that wraps this component, but we also need each line of the multiline text to begin at same place.
                            .font(Font.system(size: 13))
                            .foregroundColor(.black)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.red, lineWidth: 1)
                )
            } //Section
        } //VStack
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

struct ViewBorders_Previews: PreviewProvider {
    static var previews: some View {
        ViewBorders()
    }
}
