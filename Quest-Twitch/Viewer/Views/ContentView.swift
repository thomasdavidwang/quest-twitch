//
//  ContentView.swift
//  Quest-Twitch
//
//  Created by Thomas Wang on 12/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { frame in
            TwitchView(url: URL(string: "https://player.twitch.tv/?channel=asianjeff&parent=quest-livestream")!, frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        }
    }
}

#Preview {
    ContentView()
}
