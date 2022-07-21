//
//  MapView.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 06/05/2022.
//

import SwiftUI
import MapKit //To use SwiftUI Views from other frameworks.

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    
    @State private var region = MKCoordinateRegion() //Initially empty with no coordinates //@state attribute allows you to modify the data in this variable from more than one view while at the same time managing the underlying storage and automatically updating views that depend on the value.
    
    //State is a value, or a set of values, that can change over time, and that affects a view’s behavior, content, or layout. You use a property with the @State attribute to add state to a view.
    
    //Because you use state properties to hold information that’s specific to a view and its subviews, you always create state as private.
    
    var body: some View {
        Map(coordinateRegion: $region) //By prefixing a state variable with $, you pass a binding, which is like a reference to the underlying value. When the user interacts with the map, the map updates the region value to match the part of the map that's currently visible in the user interface.
            .onAppear { //Adds an action to perform when this view appears.
                setRegion(coordinate)
            }
    }
    
    //Method that updates the region based on a coordinate value.
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
    }
}

/*For see the actual turtle rock map on the preview, click play on top of the preview to enable live preview. You can zoom in by double tapping and zoom out by clicking option twice and then tapping the pad once.*/
