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
        GeometryReader{ geometry in
            NavigationView {
                ZStack{
                    VStack{
                        Text("Please Roatte Your Phone")
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(.white)
                    .opacity(geometry.size.width < geometry.size.height ? 1 : 0)
                    .zIndex(4)
                    VStack{
                        Spacer()
                        Image("IMG_0178")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.7)
                        Spacer()
                        HStack{
                            Button {
                                isGameStartPlayer = true
                            } label: {
                                Text("PVP")
                            }
                            .padding()
                            .background(.blue)
                            .cornerRadius(50)
                            .foregroundColor(.white)
                            .fullScreenCover(isPresented: $isGameStartPlayer){
                                Game(isGameStart : $isGameStartPlayer, player: playerState.player)
                            }
                            Button {
                                isGameStartPc = true
                            } label: {
                                Text("PVE")
                            }
                            .padding()
                            .background(.blue)
                            .cornerRadius(50)
                            .foregroundColor(.white)
                            .fullScreenCover(isPresented: $isGameStartPc){
                                Game(isGameStart : $isGameStartPc, player: playerState.pc)
                            }
                            Button {
                                isInGuide = true
                                print("guide")
                                
                            } label: {
                                Text("Guide")
                            }
                            .padding()
                            .background(.blue)
                            .cornerRadius(50)
                            .foregroundColor(.white)
                        }
                    }
                    .background{
                        NavigationLink(destination: Gudie(isInGuide : $isInGuide), isActive: $isInGuide) {
                            Text("")
                        }
                    }
                }
                .background(.cyan)
            }
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
