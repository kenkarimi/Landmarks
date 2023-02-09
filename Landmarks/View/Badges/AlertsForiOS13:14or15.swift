//
//  AlertsForiOS13:14or15.swift
//  Landmarks
//
//  Created by Kennedy Karimi on 09/02/2023.
//

import SwiftUI

struct TVShow: Identifiable {
    var id: String { name }
    let name: String
}

struct AlertsForiOS13_14or15: View {
    
    @State private var showiOS15Alert: Bool = false
    @State private var showiOS13and14Alert: Bool = false
    @State private var selectedShow: TVShow?
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                showiOS15Alert = true
            } label: {
                Text("Alert(iOS 15 and later support).")
            }
            .alert("iOS 15 Alert.", isPresented: $showiOS15Alert){
                Button("OK", role: .cancel) {
                    
                }
            }
            
            Button {
                showiOS13and14Alert = true
            } label: {
                Text("Alert(iOS 13 and 14 support).")
            }
            .alert(isPresented: $showiOS13and14Alert){
                Alert(title: Text("Important Message:"), message: Text("iOS 13 and 14 Alert."), dismissButton: .default(Text("Got it!")))
            }
            
            //Alert(Optional state that binds to identifiable
            VStack {
                Text("What is your favourite TV show?")
                    .font(Font.headline)
                Button("Select Ted Lasso") {
                    selectedShow = TVShow(name: "Ted Lasso")
                }
                Button("Selected Bridgerton") {
                    selectedShow = TVShow(name: "Bridgerton")
                }
            }
            .alert(item: $selectedShow) { show in
                Alert(title: Text(show.name), message: Text("Great choice!"), dismissButton: .cancel())
            }
        }
    }
}

struct AlertsForiOS13_14or15_Previews: PreviewProvider {
    static var previews: some View {
        AlertsForiOS13_14or15()
    }
}
