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
			VStack(spacing: 0) {
				Color.mint
				Color.pink
			}
			
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
