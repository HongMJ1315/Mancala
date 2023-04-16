//
//  ContentView.swift
//  Mancala
//
//  Created by Mr.JB on 2023/3/29.
//

import SwiftUI

enum playerState{
    case pc
    case player
}
struct ContentView: View {
    @State var isGameStartPlayer : Bool = false;
    @State var isGameStartPc : Bool = false;
    @State var isInGuide : Bool = false;
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    isGameStartPlayer = true
                } label: {
                    Text("PVP")
                }
                .fullScreenCover(isPresented: $isGameStartPlayer){
                    Game(isGameStart : $isGameStartPlayer, player: playerState.player)
                }
                Button {
                    isGameStartPc = true
                } label: {
                    Text("PVE")
                }
                .fullScreenCover(isPresented: $isGameStartPc){
                    Game(isGameStart : $isGameStartPc, player: playerState.pc)
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
