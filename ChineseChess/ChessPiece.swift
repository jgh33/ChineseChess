//
//  ChessPiece.swift
//  ChineseChess
//
//  Created by jgh on 16/8/30.
//  Copyright © 2016年 jgh. All rights reserved.
//

import UIKit


enum Pcolor {
    case red, black
}

enum Type {
    case ju
    case ma
    case xiang
    case shi
    case shuai
    case pao
    case bing
    
    
}

class ChessPiece: UIButton {
    var point:(x:Int ,y:Int)
    var pcolor:Pcolor?
    var type:Type?
    
    
    
    init(point: (x:Int ,y:Int)) {
        self.point = point
        super.init(frame: CGRect(x: 29 * point.x + 10 , y: 29 * point.y + 10, width: 29, height: 29))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func canMove(piece: ChessPiece, pieceArray: [ChessPiece]) -> Bool {
        let tA = pieceArray.filter { (xx) -> Bool in
            return xx.type != nil
            
        }
        guard self.pcolor != piece.pcolor else {
            return false
        }

        switch (self.pcolor!, self.type!) {
        case (_, .ju):
            if self.point.x == piece.point.x || self.point.y == piece.point.y  {
                for p in tA {
                    if (p.point.x == self.point.x && self.point.x == piece.point.x) {
                        if ((p.point.y > self.point.y && p.point.y < piece.point.y)||(p.point.y < self.point.y && p.point.y > piece.point.y)) {
                            return false
                        }
                    }
                    if (p.point.y == self.point.y && self.point.y == piece.point.y){
                        if ((p.point.x > self.point.x && p.point.x < piece.point.x) || (p.point.x < self.point.x && p.point.x > piece.point.x)) {
                            return false
                        }
                    }
                    
                }
                return true
            }
            return false
        case (_, .ma):
            let x1 = (piece.point.x - self.point.x) * (piece.point.x - self.point.x) == 1
            let x2 = (piece.point.x - self.point.x) * (piece.point.x - self.point.x) == 4
            let y1 = (piece.point.y - self.point.y) * (piece.point.y - self.point.y) == 1
            let y2 = (piece.point.y - self.point.y) * (piece.point.y - self.point.y) == 4
            if (x1 && y2) || (x2 && y1) {
                for p in tA {
                    //上面棋子憋马腿
                    if (p.point.y - self.point.y == -1 && p.point.x - self.point.x == 0) {
                        if (x1 && self.point.y - piece.point.y == 2) {
                            return false
                        }
                    }
                    //下面棋子憋马腿
                    if (p.point.y - self.point.y == 1 && p.point.x - self.point.x == 0) {
                        if (x1 && self.point.y - piece.point.y == -2) {
                            return false
                        }
                    }
                    //左面棋子憋马腿
                    if (p.point.y - self.point.y == 0 && p.point.x - self.point.x == -1) {
                        if (y1 && self.point.x - piece.point.x==2) {
                            return false
                        }
                    }
                    //右面棋子憋马腿
                    if (p.point.y - self.point.y == 0 && p.point.x - self.point.x == 1) {
                        if (y1 && self.point.x - piece.point.x == -2) {
                            return false
                        }
                    }
                }
                return true
            }
            return false

        case (_, .xiang):
            let x2 = (self.point.x-piece.point.x) * (self.point.x-piece.point.x) == 4
            let y2 = (self.point.y-piece.point.y) * (self.point.y-piece.point.y) == 4
            if (x2 && y2 && point.y != 3 && piece.point.y != 6) {
                for p in tA {
                    if (p.point.x == (self.point.x + piece.point.x)/2 && p.point.y == ( self.point.y + piece.point.y)/2) {
                        return false
                    }
                }
                return true
            }
            return false
        case (_, .shi):
            if (piece.point.x >= 3 && piece.point.x <= 5 && (piece.point.y >= 7 || piece.point.y <= 2)) {
                if ((piece.point.x - self.point.x) * (piece.point.x - self.point.x) == 1 && (piece.point.y-self.point.y) * (piece.point.y-self.point.y) == 1) {
                    return true
                }
            }
            return false
            
        case (_, .shuai):
            if (piece.point.x >= 3 && piece.point.x <= 5 && (piece.point.y >= 7 || piece.point.y <= 2)) {
                if (self.point.x == piece.point.x && (self.point.y - piece.point.y) * (self.point.y - piece.point.y) == 1) {
                    return true
                }
                if (self.point.y == piece.point.y && (self.point.x - piece.point.x) * (self.point.x - piece.point.x) == 1) {
                    return true
                }
            }
            return false
            
        case (_, .pao):
            var i = 0
            if self.point.x == piece.point.x || self.point.y == piece.point.y {
                for p in tA {
                    if (p.point.x == self.point.x && self.point.x == piece.point.x) {
                        if ((p.point.y > self.point.y && p.point.y < piece.point.y)||(p.point.y < self.point.y && p.point.y > piece.point.y)) {
                            i = i + 1
                        }
                    }
                    if (p.point.y == self.point.y && self.point.y == piece.point.y){
                        if ((p.point.x > self.point.x && p.point.x < piece.point.x) || (p.point.x < self.point.x && p.point.x > piece.point.x)) {
                            i = i + 1
                        }
                    }
                    
                }
                print("i = \(i)")
                
                if piece.pcolor == nil {
                    return i == 0
                }else{
                    return i == 1
                }
            }
            return false
            
        case (.black, .bing):
            if self.point.y >= 5 {
                if (self.point.y - piece.point.y == -1 && self.point.x == piece.point.x) || ((self.point.x - piece.point.x) * (self.point.x - piece.point.x) == 1 && self.point.y == piece.point.y) {
                    return true
                }
            }else{
                if (self.point.y - piece.point.y == -1 && self.point.x == piece.point.x){
                    return true
                }
                
                
            }
            return false

            
        case (.red, .bing):
            if self.point.y <= 4 {
                if (self.point.y - piece.point.y == 1 && self.point.x == piece.point.x) || ((self.point.x - piece.point.x) * (self.point.x - piece.point.x) == 1 && self.point.y == piece.point.y) {
                    return true
                }
            }else{
                if (self.point.y - piece.point.y == 1 && self.point.x == piece.point.x){
                    return true
                }

                
            }
            return false

        }
    }
    
    
}
