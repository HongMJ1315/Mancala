//
//  hole.swift
//  Mancala
//
//  Created by Mr.JB on 2023/3/29.
//

import Foundation
import  SwiftUI


struct Hole : View{
    @State public var jewle : [Jewle] = [];
    public var sizeX : Int;
    public var sizeY : Int;
    
    init(sizeX: Int, sizeY: Int){
        self.sizeX = sizeX
        self.sizeY = sizeY
        for i in 0...3{
            jewle.append(Jewle(img: String(i)))
        }
    }
    public var body : some View{
        GeometryReader{geometry in
            Circle()
                .frame(width : geometry.size.width, height: geometry.size.height)
                .overlay {
                    ForEach(jewle) { jewle in
                        Image(jewle.img)
                            .offset(x : jewle.locX, y : jewle.locY)
                    }
                }
            
        }
    }
}

