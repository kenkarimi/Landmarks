//
//  Landmark.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 09/05/2022.
//

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable { //Adding Codable conformation makes it easier to move data between this structure and the data file.
    //We add Identifiable conformance since each landmark in the landmarkData.json file has a unique id property that conforms it to this protocol. This way, we now don't have to use the .id property in the closure in LandmarkList.Swift in order to specify each element dynamically. Before, the closure was "List(landmarks, id: \.id) { this_landmark in" now it is "List(landmarks) { this_landmark in"
    var id: Int //Every one of these variables are mapped out(with hashable, codable) to the ones in the landmarkData file.
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    
    private var imageName: String //Only accessible in this struct and nowhere else.
    var image: Image { //Computed property. loads an image from the asset catalog. We use this computed property to display the image in LandmarkRow.Swift since as you can see the, computed property allows us to use the Image() view to load the image outside of a regular Swift View file. Also note that the imageName string is private so it won't be accessible from LandmarkRow.Swift
        Image(imageName)
    }
    
    private var coordinates: Coordinates //Only accessible in this struct and nowhere else.
    struct Coordinates: Hashable, Codable { //This seems to be how data is gotten from an object in swift. Hashable and Codable again used to map out latitude, longitude to the ones in the coordinates in landmarkData
        var latitude: Double
        var longitude: Double
    }
    
    var locationCoordinate: CLLocationCoordinate2D { //Computed property. interacts with the MapKit framework.
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}
