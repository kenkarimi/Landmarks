//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 12/05/2022.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData //Adopting observable object model to my view. The modelData property gets its value automatically, as long as the environmentObject(_:) modifier has been applied to a parent.
    @State private var showFavoritesOnly = false //State is a value, or a set of values, that can change over time, and that affects a view’s behavior, content, or layout. You use a property with the @State attribute to add state to a view.
    
    //Because you use state properties to hold information that’s specific to a view and its subviews, you always create state as private.
    
    //NB://Eact time you change the state, you have to resume the automatic preview because it's automatically paused on each state change.
    
    var filteredLandmarks: [Landmark] { //Computed property. filter landmark.isFavorite value of each landmark.
        modelData.landmarks.filter { this_landmark in  //landmarks is an array in ModelData.Swift file
            (!showFavoritesOnly || this_landmark.isFavorite) //includes ALL records from the landmarks array as part of the filteredLandmarks array if showFavoritesOnly is false(!showFavoritesOnly). This is the default. So regardles of what this_landmark.isFavorite is(true/false), all records will be shown in the list if showFavoritesOnly is false.
            
            //However, once you toggle showFavoritesOnly state to true, then the only way that a record can be included as part of the list is if this_landmark.isFavorite is true(since it's the OR part of the equation). In other words, in this scenario, only the favorite landmarks will be filtered and shown on the list.
        }
    }
    
    var body: some View {
        NavigationView { //Embed dynamically generated list inside navigation view.
            
            List {

                //Example of non dynamic specification of list elements below.
                /*LandmarkRow(landmark: landmarks[0])
                LandmarkRow(landmark: landmarks[1])*/
                
                Toggle(isOn: $showFavoritesOnly) { //By prefixing a state variable with $, you pass a binding similar to what we do in MapView.Swift with the $region state variable. This is a reference to the underlying value. When the user toggles the button, it updates the showFavoritesOnly value to either true or false, which in turn affects the landmarks list on the user interface interface in real time.
                    Text("Favorites only")
                }
                
                //Dynamic specification of elements using a closure.
                ForEach(filteredLandmarks) { this_landmark in
                    NavigationLink { //Wrap the row inside a link that specifies the destination if clicked.
                        LandmarkDetail(landmark: this_landmark)
                    } label: {
                        //Dynamic
                        LandmarkRow(landmark: this_landmark)
                    }
                }
            }
            .navigationTitle("Landmarks") //Title of navigation bar when displaying the list.
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        //Rendering multiple previews for different device sizes. Device names can be found in the Xcode scheme menu.
        //ForEach operates on collections the same way as the list, which means you can use it anywhere you use a child view, such as in stacks, lists, groups, and more.
        ForEach([/*"iPhone SE (2nd generation)",*/ "iPhone XS Max"], id: \.self) { deviceName in
            //\.self is used as a key path identifier since the elements in our data are simple value types like strings.
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName) //Adds device name as a label for the preview.
                .environmentObject(ModelData()) //Has to be here because we're using the @EnvironmentObject modelData within the body(var body) in this case, to generate a List. We don't do this in LandmarkRow because the @EnvironmentObject modelData is not in use within the body even though the class ModelData() is in use in the preview.
        }
    }
}
