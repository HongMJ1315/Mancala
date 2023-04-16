//
//  Game.swift
//  Mancala
//
//  Created by Mr.JB on 2023/3/29.
//

import SwiftUI

enum nextState{
    case END
    case CONTINUE
    
}


struct Game: View {
    @Binding var isGameStart : Bool
    @State var hole : [Hole] = []
    @State var pcSelect : Int = 7
    @State var nowSide : Bool = false{
        willSet{
            print(nowSide)
        }
    }
    @State var isMoving : Double = 1
    @State var movingJewle : Jewle = Jewle(img: String(0)){
        willSet{
            print("Jewle : ", movingJewle.locX, movingJewle.locY)
        }
    }
    @State var isGameOver : Bool = false
    @State var player : playerState = playerState.player
    init(isGameStart : Binding<Bool>, player : playerState){
        if(player == playerState.player){
            print("player")
        }
        else{
            print("pc")
        }
        self._isGameStart = isGameStart
        self.player = player
        self.movingJewle = Jewle(img: String(0))
        movingJewle.locX = 50
        movingJewle.locY = 50
        movingJewle.color = Color(red: .random(in: 0...255)/255, green: .random(in: 0...255)/255, blue: .random(in: 0...255)/255)
        var hole  = [Hole]()
        for i in 0..<6{
            hole.append(Hole(side : "A", jewles: 4, id: i))
        }
        hole.append(Hole(side : "A", jewles: 0, id: 6))
        for i in 7..<13{
            hole.append(Hole(side : "B", jewles: 4, id: i))
        }
        hole.append(Hole(side : "B", jewles: 0, id: 13))
        self._hole = State(initialValue: hole)
    }
    func checkState() -> nextState{
        var isdoneA : Bool = true;
        var isdoneB : Bool = true;
        for i in 0..<6{
            if(hole[i].jewle.count != 0){
                isdoneA = false
                break;
            }
        }
        for i in 7..<13{
            if(hole[i].jewle.count != 0){
                isdoneB = false
                break;
            }
        }
        if(isdoneA || isdoneB){
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                isGameOver = true
            }
            return nextState.END
            
        }
        else {
            return nextState.CONTINUE
        }
    }
    func endGame() -> Void{
        nowSide = false
        for i in 0..<6{
            for j in hole[i].jewle{
                hole[6].jewle.append(j)
            }
            hole[i].jewle.removeAll()
        }
        for i in 7..<13{
            for j in hole[i].jewle{
                hole[13].jewle.append(j)
            }
            hole[i].jewle.removeAll()
        }
        
    }
    
    func tapEvenLeft(i : Int)->Void{
        print("left")
        if nowSide != false{
            return
        }
        let tmpHole = hole[i].jewle
        hole[i].jewle.removeAll()
        for j in 0..<tmpHole.count{
            let tmpJewle = tmpHole[j]
            if((j + i + 1)%14 == 13){
                hole[(i + tmpHole.count + 1) % 14].jewle.append(tmpJewle)
            }
            else{
                hole[(j + i + 1)%14].jewle.append(tmpJewle)
            }
            
        }
        if(i + tmpHole.count == 6){
            if(checkState() == nextState.END){
                endGame()
            }
            return
        }
        guard i + tmpHole.count < 6 else{
            nowSide = true
            if(checkState() == nextState.END){
                endGame()
            }
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
        if(checkState() == nextState.END){
            endGame()
        }
    }
    
    func tapEvenRight(i : Int)->Void{
        print("right")
        if nowSide != true{
            return;
        }
        let tmpHole = hole[i].jewle
        hole[i].jewle.removeAll()
        for j in 0..<tmpHole.count{
            let tmpJewle = tmpHole[j]
            isMoving = 1
//            movingJewle = tmpJewle
//            movingJewle.locX = -tmpJewle.locX + hole[i].locX - hole[i].sizeY / 2.0
//            movingJewle.locY = -tmpJewle.locY + hole[i].locY - hole[i].sizeY / 2.0
            print(hole[i].locX, hole[i].locY, hole[i].sizeX, hole[i].sizeY)
            
            if((j + i + 1)%14 == 6){
                hole[(i + tmpHole.count + 1) % 14].jewle.append(tmpJewle)
            }
            else{
                hole[(j + i + 1)%14].jewle.append(tmpJewle)
            }
        }
        if(i + tmpHole.count == 13){
            if(checkState() == nextState.END){
                endGame()
            }
            return
        }
        guard i + tmpHole.count < 13 else{
            nowSide = false
            if(checkState() == nextState.END){
                endGame()
            }
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
        if(checkState() == nextState.END){
            endGame()
        }
        
    }
    
    func runPc() -> Void{
        print("runPc")
        print(nowSide)
        while(nowSide == true){
            print("run")
            pcSelect = .random(in: 7..<13)
            if(checkState() == nextState.END){
                endGame()
            }
            while(hole[pcSelect].jewle.count == 0){
                print(pcSelect)
                pcSelect = .random(in: 7..<13)
            }
            print(pcSelect)
            tapEvenRight(i: pcSelect)
            
        }
    }
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
//                VStack(spacing : 0){
//                    HStack(spacing : 0){
//                        Circle()
//                            .frame(width: geometry.size.width/5, height: geometry.size.height/35)
//                            .foregroundColor(movingJewle.color)
//                            .overlay{
//                                Text("#")
//                            }
//                            .offset(x : movingJewle.locX, y : movingJewle.locY)
//                            .opacity(isMoving)
//                        Spacer()
//                    }
//                    Spacer()
//
//                }
//                .frame(width: geometry.size.width, height: geometry.size.height)
//                .zIndex(5)
                VStack{
                    Text("Please Roatte Your Phone")
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(.white)
                .opacity(geometry.size.width > geometry.size.height ? 1 : 0)
                .zIndex(4)
                VStack{
                    Button {
                        isGameStart = false
                    } label: {
                        Text("Go Back")
                            .foregroundColor(.black)
                            .font(.system(size : 10))
                        
                    }
                    .frame(width : 50, height : 50)
                    .background(.gray)
                }
                .rotationEffect(Angle(degrees: 90))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal, 10)
                .zIndex(3)
                VStack{
                    
                    let ACount = hole[6].jewle.count
                    let BCount = hole[13].jewle.count
                    HStack{
                        Text(ACount > BCount ? "You Win" : (ACount == BCount ? "Even" : "You Lose"))
                            .rotationEffect(Angle(degrees: 90))
                        Button {
                            var hole  = [Hole]()
                            for i in 0..<6{
                                hole.append(Hole(side : "A", jewles: 4, id: i))
                            }
                            hole.append(Hole(side : "A", jewles: 0, id: 6))
                            for i in 7..<13{
                                hole.append(Hole(side : "B", jewles: 4, id: i))
                            }
                            hole.append(Hole(side : "B", jewles: 0, id: 13))
                            self.hole = hole
                            nowSide = false
                            isGameOver = false
                        
                        } label: {
                            Text("Restart")
                        }

                        Text(ACount > BCount ? "You Lose" : (ACount == BCount ? "Even" : "You Win"))
                            .rotationEffect(Angle(degrees: 270))
                        
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 6 / 8)
                    .background(.white)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .opacity(isGameOver ? 1 : 0)
                .zIndex(2)
                VStack{
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
                .zIndex(1)
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
                                            tapEvenLeft(i: i)
                                            if(player == playerState.pc){
                                                runPc()
                                            }
                                        }
                                        .background(GeometryReader { holeGeometry in
                                           Color.clear.onAppear {
                                               if let holeIndex = self.hole.firstIndex(where: { $0.id == hole[i].id }) {
                                                   self.hole[holeIndex].locX = holeGeometry.frame(in : .global).midX
                                                   self.hole[holeIndex].locY = holeGeometry.frame(in : .global).midY
                                                   self.hole[holeIndex].sizeX = holeGeometry.size.width
                                                   self.hole[holeIndex].sizeY = holeGeometry.size.height

                                               }
                                           }
                                       })
                                }
                            }
                            VStack(spacing : 0){
                                ForEach(7..<13, id : \.self) { i in
                                    hole[i]
                                        .onTapGesture {
                                            if(player == playerState.player){
                                                tapEvenRight(i: i)
                                            }
                                        }
                                        .background(GeometryReader { holeGeometry in
                                           Color.clear.onAppear {
                                               if let holeIndex = self.hole.firstIndex(where: { $0.id == hole[i].id }) {
                                                   self.hole[holeIndex].locX = holeGeometry.frame(in : .global).midX
                                                   self.hole[holeIndex].locY = holeGeometry.frame(in : .global).midY
                                                   self.hole[holeIndex].sizeX = holeGeometry.size.width
                                                   self.hole[holeIndex].sizeY = holeGeometry.size.height

                                               }
                                           }
                                       })
                                    
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
                    .zIndex(0)
                    Spacer()
                }
                
            }
        }
    }
}

//struct Game_Previews: PreviewProvider {
//    static var previews: some View {
//        Game()
//    }
//}
