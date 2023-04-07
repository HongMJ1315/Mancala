//
//  Game.swift
//  Mancala
//
//  Created by Mr.JB on 2023/3/29.
//

import SwiftUI

struct Game: View {
    @State var hole : [Hole]{
        willSet{
           print( hole.count )
        }
    }
    @State var nowSide : Bool = false;
    @State var isGameOver : Bool = false
    
    
    init(){
        var hole  = [Hole]()
        for _ in 0..<6{
            hole.append(Hole(side : "A", jewles: 4))
        }
        hole.append(Hole(side : "A", jewles: 0))
        for _ in 7..<13{
            hole.append(Hole(side : "B", jewles: 4))
        }
        hole.append(Hole(side : "B", jewles: 0))
        self.hole = hole
    }
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                ZStack{

                    Text("Your Turn")
                        .rotationEffect(Angle(degrees: 90))
                        .padding()
                        .frame(height: geometry.size.height / 5)
                        .opacity(nowSide ? 0 : 1)
                    Text("Your Turn")
                        .rotationEffect(Angle(degrees: 270))
                        .padding()
                        .frame(height: geometry.size.height / 5)
                        .opacity(nowSide ? 1 : 0)
                    
                }
                HStack{
                    Spacer()
                    VStack(spacing : 0){
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width : geometry.size.width * 2/3, height : geometry.size.height/8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke((hole[13].side == "A" ? Color.blue : Color.red), lineWidth: 3)
                            }
                            .overlay {
                                ForEach(hole[13].jewle) { jewle in
                                    Circle()
                                        .frame(height: geometry.size.height/40)
                                        .foregroundColor(jewle.color)
                                        .offset(x : jewle.locX, y : jewle.locY)
                                }
                            }
                            .overlay {
                                Text(String(hole[13].jewle.count))
                                    .foregroundColor(.white)
                                    .rotationEffect(Angle(degrees: 270))
                                    .offset(x : geometry.size.width / 4)
                            }
                        HStack(spacing : 0){
                            VStack(spacing : 0){
                                ForEach(0..<6, id : \.self) { i in
                                    hole[i]
                                        .onTapGesture {
                                            if nowSide != false{
                                                return
                                            }
                                            let tmpHole = hole[i].jewle
                                            hole[i].jewle.removeAll()
                                            for j in 0..<tmpHole.count{
                                                if((j + i + 1)%14 == 13){
                                                    hole[(i + tmpHole.count + 1) % 14].jewle.append(tmpHole[j])
                                                }
                                                else{
                                                    hole[(j + i + 1)%14].jewle.append(tmpHole[j])
                                                }
                                            }
                                            if(i + tmpHole.count == 6){
                                                return
                                            }
                                            guard i + tmpHole.count < 6 else{
                                                nowSide = true
                                                return
                                            }
                                            let mySide = i + tmpHole.count
                                            let otherSide = 13 - 1 - mySide
                                            if(hole[mySide].jewle.count == 1){
                                                for j in hole[otherSide].jewle{
                                                    hole[6].jewle.append(j)
                                                }
                                                hole[otherSide].jewle.removeAll()
                                            }
                                            nowSide = true
                                        }
                                }
                            }
                            VStack(spacing : 0){
                                ForEach(7..<13, id : \.self) { i in
                                    hole[i]
                                        .onTapGesture {
                                            if nowSide != true{
                                                return;
                                            }
                                            let tmpHole = hole[i].jewle
                                            hole[i].jewle.removeAll()
                                            for j in 0..<tmpHole.count{
                                                if((j + i + 1)%14 == 6){
                                                    hole[(i + tmpHole.count + 1) % 14].jewle.append(tmpHole[j])
                                                }
                                                else{
                                                    hole[(j + i + 1)%14].jewle.append(tmpHole[j])
                                                }
                                            }
                                            if(i + tmpHole.count == 13){
                                                return
                                            }
                                            guard i + tmpHole.count < 13 else{
                                                nowSide = false
                                                return
                                            }
                                            let mySide = i + tmpHole.count
                                            let otherSide = 12 - mySide
                                            if(hole[mySide].jewle.count == 1){
                                                for j in hole[otherSide].jewle{
                                                    hole[13].jewle.append(j)
                                                }
                                                hole[otherSide].jewle.removeAll()
                                            }
                                            nowSide = false
                                        }
                                    
                                }
                            }
                            .rotationEffect(Angle(degrees: 180))
                        }
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width : geometry.size.width * 2/3, height : geometry.size.height/8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke((hole[6].side == "A" ? Color.blue : Color.red), lineWidth: 3)
                            }
                            .overlay {
                                ForEach(hole[6].jewle) { jewle in
                                    Circle()
                                        .frame(height: geometry.size.height/40)
                                        .foregroundColor(jewle.color)
                                        .offset(x : jewle.locX, y : jewle.locY)
                                }
                            }
                            .overlay {
                                Text(String(hole[6].jewle.count))
                                    .foregroundColor(.white)
                                    .rotationEffect(Angle(degrees: 90))
                                    .offset(x : -geometry.size.width / 4)
                            }
                    }
                    Spacer()
                }
                
            }
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
