//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 05/05/2022.
//

import SwiftUI

@main //Attribute identifies the app's entry point
struct LandmarksApp: App { //Structures body property returns one or more scenes which in turn provide content for display.
    //Next, you update the app instance to put the model object in the environment when you run the app in the simulator or on a device.
    @StateObject private var modelData = ModelData() //We use the @StateObject attribute to initialize an observable model object for a given property only once during the life time of the app. This is true when you use the attribute in an app instance(scene), as shown here, as well as when you use it in a view. In other words, we use @StateObject because model data is an observable object.
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData) //The modelData state object initialized above is used here as a parameter.
        }
    }
}
