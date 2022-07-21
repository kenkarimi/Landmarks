//
//  ContentView.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 05/05/2022.
//

import SwiftUI

//View's content and layout
struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

//Preview for the view.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData()) //Update the ContentView preview to add the model object to the environment, which makes the object available to any subview.
    }
}

/*To show the inspector, you can Command + Click on the text on the preview, then click Show SwiftUI Inspector on the pop up that shows up
 
 You can use this inspector to edit the modifiers of the text view*/

/*Click the plus button at the top right of xcode window to open the library from where you can drag various components e.g. text view*/
