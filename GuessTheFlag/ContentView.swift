//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Olea Blossom on 06.06.22.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		ZStack {
			AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
			
			Text("Your content")
				.foregroundStyle(.secondary)
				.padding(50)
				.background(.ultraThinMaterial)
		}
		.ignoresSafeArea()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
