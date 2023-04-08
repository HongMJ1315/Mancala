//
//  ContentView.swift
//  Mancala
//
//  Created by Mr.JB on 2023/3/29.
//

import SwiftUI

struct ContentView: View {
    @State var isGameStart : Bool = false;
    @State var isInGuide : Bool = false;
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    isGameStart = true
                } label: {
                    Text("Start")
                }
                .fullScreenCover(isPresented: $isGameStart){
                    Game(isGameStart : $isGameStart)
                }

            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
