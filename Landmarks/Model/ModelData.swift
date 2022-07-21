//
//  ModelData.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 10/05/2022.
//

import Foundation
import Combine

//To allow the user to change which landmarks are their favourites, we store the landmark data in an observable object. An observable object is a custom object for your data that can be bound to a view from storage in SwiftUI’s environment. SwiftUI watches for any changes to observable objects that could affect a view, and displays the correct version of the view after a change.

//An observable object needs to publish any changes to its data, so that its subscribers can pick up the change.

final class ModelData: ObservableObject { //conforms to the ObservableObject protocol from the Combine framework.
    @Published var landmarks: [Landmark] = load("landmarkData.json") //Landmark type is defined in Landmark.Swift
    //var hikes: [Hike] = load("hikes.json") //Because you’ll never modify hike data after initially loading it, you don’t need to mark it with the @Published attribute.
    //NB: Project kind of ends here. Unsure if I want to continue with the rest.
}

//NB: On top of updating the LandmarkList preview and changing everywhere where the landmarks array is used to modelData.landmarks or ModelData().landmarks (in previews), We also update the ContentView preview to add the model object to the environment, which makes the object available to any subview.

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
