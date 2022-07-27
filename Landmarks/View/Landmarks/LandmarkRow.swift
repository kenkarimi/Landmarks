//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 10/05/2022.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark //When you add the landmark property, the preview stops working, because the View needs a landmark instance during initialization. To fix this, we modify the LandmarkRow_Previews preview provider.
    
    var body: some View {
        HStack {
            landmark.image //A computed property was used in Landmark.Swift to load the image in Image(imageName) so all we have to do here is refer to it.
                .resizable() //Allows image to be resized according the user defined width/height within the .frame below. Without this, the .frame will reduce the image view size, but the entire image itself won't fit inside the smaller width & length.
                .frame(width: 50.0, height: 50.0)
                .clipShape(Rectangle())
                .overlay {
                    Rectangle().stroke(.white, lineWidth: 4)
                        .shadow(radius: 7)
                }
            Text(landmark.name)
                .font(.title)
                .foregroundColor(.black)
                .fontWeight(.regular)
                .padding(1)
            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var landmarks = ModelData().landmarks
    
    static var previews: some View {
        Group { //If you wan't to preview more than one row, use this to group them together if not, you can choose to leave it out.
            LandmarkRow(landmark: landmarks[0]) //We add the landmark parameter to the LandmarkRow initializer, specifying the first element of the landmarks array.(The landmarks array was created in the ModelData.Swift file)
            LandmarkRow(landmark: landmarks[1])
        }
        .previewLayout(.fixed(width: 370.0, height: 70.0)) //Defines the size of the view that is shown in the preview. In this case, we size it to approximate a row in a list.
    }
}
