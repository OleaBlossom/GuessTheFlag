//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Olea Blossom on 06.06.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                Text("A1")
                Text("B1")
                Text("C1")
            }
            HStack(spacing: 20) {
                Text("A2")
                Text("B2")
                Text("C2")

            }
            HStack(spacing: 20) {
                Text("A3")
                Text("B3")
                Text("C3")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
