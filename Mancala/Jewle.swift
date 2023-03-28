//
//  jewle.swift
//  Mancala
//
//  Created by Mr.JB on 2023/3/29.
//

import Foundation
import SwiftUI

struct Jewle : Identifiable, Hashable{
    public var id = UUID();
    public var color : Color;
    public var img : String;
    public var locX : Double;
    public var locY : Double;
    init(img : String){
        self.img = img + ".circle"
        self.color = Color(red: .random(in: 0...255)/255, green: .random(in: 0...255)/255, blue: .random(in: 0...255)/255)
        self.locX = .random(in: 0...50)
        self.locY = .random(in: 0...50)
    }
}
