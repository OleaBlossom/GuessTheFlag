//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Olea Blossom on 06.06.22.
//

import SwiftUI

struct ContentView: View {
	@State private var showingAlert = false
	var body: some View {
		ZStack {
			AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
			
			Button("Show Alert") {
				showingAlert = true
			}
			.padding(.vertical, 16)
			.padding(.horizontal, 32)
			.background(.thickMaterial)
			.cornerRadius(40)
			.overlay(
				Capsule(style: .circular)
					.stroke(.white, lineWidth: 3)
			)
			.alert("Important message", isPresented: $showingAlert) {
				Button("OK", role: .cancel) { }
			} message: {
				Text("Please read this!")
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
