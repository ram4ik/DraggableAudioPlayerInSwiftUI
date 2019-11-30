//
//  ContentView.swift
//  DraggableAudioPlayerInSwiftUI
//
//  Created by Ramill Ibragimov on 30.11.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Music().tabItem {
                Image(systemName: "music.note")
            }
            Text("Search").tabItem {
                Image(systemName: "magnifyingglass")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Music: View {
    @State var opacity: Double = 1
    @State var height: CGFloat = 0
    @State var floating = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.orange
                VStack {
                    HStack {
                        Image("swift")
                            .resizable()
                            .frame(width: 60, height: 45)
                            .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text("Love Story")
                                .fontWeight(.heavy)
                            Text("Taylor Swift")
                        }
                        Spacer()
                        Image(systemName: (self.height == geo.size.height - 75 ? "play.fill" :  "square.and.arrow.down.fill"))
                            .resizable()
                            .frame(width: 32, height: 32)
                    }.padding(10)
                    .foregroundColor(.white)
                    
                    // your music player...
                    Spacer()
                }
            }.gesture(DragGesture()
                .onChanged({ (value) in
                    if self.height >= 0 {
                        self.height += value.translation.height / 8
                        self.opacity = 0.5
                    }
                })
                .onEnded({ (value) in
                    if self.height > 100 && !self.floating {
                        self.height = geo.size.height - 75
                        self.opacity = 1
                        self.floating = true
                    } else {
                        if self.height < geo.size.height - 150 {
                            self.height = 0
                            self.opacity = 1
                            self.floating = false
                        } else {
                            self.height = geo.size.height - 75
                            self.opacity = 1
                        }
                    }
                })
            )
            .opacity(self.opacity)
            .offset(y: self.height)
            .animation(.spring())
        }
    }
}
