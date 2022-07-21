//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 17/05/2022.
//

import SwiftUI

//This is a reusable favorite button.
struct FavoriteButton: View {
    //isSet binding that indicates the button’s current state, and provide a constant value for the preview.
    //Because you use a binding, changes made inside this view propagate back to the data source.
    @Binding var isSet: Bool
    
    var body: some View {
        //Button with an action that toggles the isSet state, and that changes its appearance based on the state.
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true)) //The constant is an immutable value that acts like a default. So in LandmarkDetail where this button is shown, it'll be shown as true(star filled yellow color) by default.
    }
}
