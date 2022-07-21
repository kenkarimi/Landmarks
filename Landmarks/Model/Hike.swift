//
//  Hike.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 05/06/2022.
//

import Foundation
import SwiftUI

struct Hike: Codable, Hashable, Identifiable { //Adding Codable conformation makes it easier to move data between this structure and the data file.
    //We add Identifiable conformance since each trail in the hikeData.json file has a unique id property that conforms it to this protocol. This way, we now don't have to use the .id property in order to specify each element dynamically.
    var id: Int
    var name: String
    var distance: Double
    var difficulty: Int
    
    static var formatter = LengthFormatter()
    
    var distanceText: String { //Computed property.
        Hike.formatter
            .string(fromValue: distance, unit: .kilometer)
    }
    
    var observations: [Observation]
    struct Observation: Codable, Hashable { //This seems to be how data is gotten from an object in swift. Hashable and Codable again used to map out distanceFromStart, elevation, pace and heartrate.
        var distanceFromStart: Double
        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>
    }
}
