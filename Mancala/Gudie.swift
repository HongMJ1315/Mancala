//
//  Gudie.swift
//  Mancala
//
//  Created by Mr.JB on 2023/4/16.
//

import SwiftUI

struct Gudie: View {
    @State private var currentViewIndex = 0
    var page: [AnyView] = [AnyView(ViewA()), AnyView(ViewB()), AnyView(ViewC()), AnyView(ViewD()), AnyView(ViewE())]
    @Binding var isInGuide : Bool
    
    var body: some View {
        GeometryReader{geometry in
            VStack {
                Spacer()

                HStack{
                    Spacer()
                    page[currentViewIndex]
                    Spacer()
                }
                Spacer()

                
                HStack {
                    Button("Previous") {
                        currentViewIndex = (-1 + currentViewIndex + page.count + page.count) % page.count
                    }
                    
                    Spacer()
                    
                    Button("Next") {
                        currentViewIndex = (1 + currentViewIndex + page.count) % page.count
                    }
                }
            }
            .background(.cyan)
        }
    }
}

struct Gudie_Previews: PreviewProvider {
    static var previews: some View {
        Gudie(isInGuide: .constant(true))
    
    }
}
struct ViewA: View {
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer()
                VStack{
                    Image("page1")
                        .resizable()
                        .frame(maxWidth: geometry.size.width * 0.9, maxHeight: geometry.size.height * 0.9)
                    
                    Text("遊戲開始雙方的棋格內都會有四顆子")
                }
                Spacer()
            }
        }
    }
}

struct ViewB: View {
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer()
                VStack{
                    Image("page5")
                        .resizable()
                        .frame(maxWidth: geometry.size.width * 0.9, maxHeight: geometry.size.height * 0.9)
                    
                    Text("移動時將棋子移到後面相應的位置")
                }
                Spacer()
            }
        }
    }
}

struct ViewC: View {
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer()
                VStack{
                    Image("page3")
                        .resizable()
                        .frame(maxWidth: geometry.size.width * 0.9, maxHeight: geometry.size.height * 0.9)
                    
                    Text("如果你的最後一顆棋子移動到自己的得分區可以多一次移動機會")
                }
                Spacer()
            }
        }
    }
}

struct ViewD: View {
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer()
                VStack{
                    Image("page2")
                        .resizable()
                        .frame(maxWidth: geometry.size.width * 0.9, maxHeight: geometry.size.height * 0.9)
                    
                    Text("如果你的最後一顆棋子移動到空的棋格可以將棋格對面的對方棋子全部拿走")
                }
                Spacer()
            }
        }
    }
}

struct ViewE: View {
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer()
                VStack{
                    Image("page4")
                        .resizable()
                        .frame(maxWidth: geometry.size.width * 0.9, maxHeight: geometry.size.height * 0.9)
                    
                    Text("若有一方棋子清空的話，另一方則將自己棋格全部棋子移動到得分區")
                }
                Spacer()
            }
        }
    }
}
