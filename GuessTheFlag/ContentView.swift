//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Olea Blossom on 06.06.22.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		ZStack() {
			Color(red: 1, green: 0.8, blue: 1)
				.frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
			Text("Your content")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
