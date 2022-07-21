//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 12/05/2022.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData //Adopting observable object model to my view. The modelData property gets its value automatically, as long as the environmentObject(_:) modifier has been applied to a parent.
    var landmark: Landmark
    
    //compute the index of the input landmark by comparing it with the model data.
    var landmarkIndex: Int { //Computed property. We need this landmark's index within the landmarks array, so we match landmark.id value to it's first appearance within the landmarks array. Once we find a match, we return that index.
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .ignoresSafeArea(edges: .top) //Removes the small space at the top that remains even after the spacer at the bottom of this stack has been added top push the content up, allowing the map to truly extend to the top.
                .frame(height: 250)
            CircleImage(image: landmark.image)
                .offset(y: -130) //layers the image view halfway on top of the map.
                .padding(.bottom, -130) //Takes away the padding left behind after the image view is layered on top of the map, thereby allowing the textviews to be directly below this image view.
            VStack(alignment: .leading) { //Vertical stack. The parameters are optional. The alignment parameter specifically aligns the components in this VStack(Text, Hstack) to the leftmost of this view.
                HStack {
                    Text(landmark.name)
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite) //the landmark index helps us locate where in the landmark data we want to bind our button to. This ensures that the button updates the isFavorite property of the right landmark in our model object.
                    //The dolar sign provides the binding, similar to @State
                    //NB: It's not the landmarkData.json file that's actually updated. It's the Landmark.Swift model object that changes.
                }
                HStack {
                    Text(landmark.park)
                    Spacer() //Spacer expands the view & makes its containing(HStack) to use its entire width and therefore also the view that contains it(VStack) to use its entire width as well.
                    Text(landmark.state)
                }
                //SwiftUI applies these two modifiers to all the components contained in the group
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("About \(landmark.name)")
                    .font(.title2)
                    .foregroundColor(.black)
                    .fontWeight(.regular)
                Text(landmark.description)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .fontWeight(.regular)
            }
            .padding() //Finally, after using the Spacer() to use the entire width, we pad the VStack with default padding to give the Landmark's name & details some space.
            //Spacer() //Pushes the content to the top of the screen as far up as it can.
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: ModelData().landmarks[0])
            .environmentObject(ModelData()) //Has to be here because we're using the @Environment variable modelData within the body(var body) in this case, to find the landmark index within the landmark array that matches the landmark passed down from the navigation link. We then use this landmark index alongside the modelData @Environment variable again to get the isFavorite value which determines where in the landmark data we bind our data to. We don't do this in LandmarkRow because the @EnvironmentObject modelData is not in use within the body even though the class ModelData() is in use in the preview.
    }
}

/*To show the inspector, you can Command + Click on the text on the preview, then click Show SwiftUI Inspector on the pop up that shows up
 
 You can use this inspector to edit the modifiers of the text view*/

/*Click the plus button at the top right of xcode window to open the library from where you can drag various components e.g. text view*/
