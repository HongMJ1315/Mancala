//
//  hole.swift
//  Mancala
//
//  Created by Mr.JB on 2023/3/29.
//

import Foundation
import  SwiftUI


struct Hole : View{
    var id : Int
    var jewle : [Jewle];
    var side : String;
    var locX : CGFloat = 0;
    var locY : CGFloat = 0;
    var sizeX : CGFloat = 0;
    var sizeY : CGFloat = 0;
    init(side : String, jewles : Int, id : Int){
        var jewle = [Jewle]()
        for i in 0..<jewles{
            jewle.append(Jewle(img: String(i)))
        }
        self.jewle = jewle
        self.side = side
        self.id = id
    }
    public var body : some View{
        GeometryReader{geometry in
            Circle()
                .frame(width : geometry.size.width , height: geometry.size.height)
                .overlay(
                    Circle()
                        .stroke((self.side == "A" ? Color.blue : Color.red), lineWidth: 3)
                )
                .overlay {
                    ForEach(self.jewle) { jewle in
                        Circle()
                            .frame(width: geometry.size.width/5, height: geometry.size.height/5)
                            .foregroundColor(jewle.color)
                            .offset(x : jewle.locX, y : jewle.locY)
                    }
                }
                .overlay {
                    Text(String(jewle.count))
                        .background(.black)
                        .foregroundColor(.white)
                        .frame(width:geometry.size.width/5, height:geometry.size.height/5)
                        .rotationEffect(Angle(degrees: 180))
                        .clipShape(Circle())
                        .offset(x : -geometry.size.width/4 - 5, y : -geometry.size.height/4 - 5)
                        
                    
                }
                
        }
    }
}

