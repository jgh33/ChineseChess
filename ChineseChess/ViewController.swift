//
//  ViewController.swift
//  ChineseChess
//
//  Created by jgh on 16/8/30.
//  Copyright © 2016年 jgh. All rights reserved.
//

import UIKit



enum State {
    case noRunning, redC, redT, blackC, blackT, gameover
}

class ViewController: UIViewController {



    @IBOutlet weak var hero: UIImageView!
    @IBOutlet weak var qipan: UIImageView!
    var pieceArray:[ChessPiece] = []
    var selected: ChessPiece?
    var state: State = .noRunning
    let qiPan = UIImage(named: "棋盘.gif")!
    let rJu = UIImage(named: "红车.gif")!
    let bJu = UIImage(named: "黑车.gif")!
    let rMa = UIImage(named: "红马.gif")!
    let bMa = UIImage(named: "黑马.gif")!
    let rXiang = UIImage(named: "红象.gif")!
    let bXiang = UIImage(named: "黑象.gif")!
    let rShi = UIImage(named: "红士.gif")!
    let bShi = UIImage(named: "黑士.gif")!
    let rShuai = UIImage(named: "红帅.gif")!
    let bJiang = UIImage(named: "黑将.gif")!
    let rBing = UIImage(named: "红兵.gif")!
    let bZu = UIImage(named: "黑卒.gif")!
    let rPao = UIImage(named: "红炮.gif")!
    let bPao = UIImage(named: "黒炮.gif")!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.qipan.image = qiPan//  设置期盼图片
        self.qipan.isUserInteractionEnabled = true
        self.hero.frame.size = CGSize(width: 29, height: 29)
        setInfo()//初始化棋子按钮与状态
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setInfo() {
        self.pieceArray = []
        for i in 0..<9 {
            for j in 0..<10 {
                let btn = ChessPiece(point: (i,j))
                self.pieceArray.append(btn)
                self.qipan.addSubview(btn)
                btn.addTarget(self, action: #selector(touch), for: .touchUpInside)
            }
        }

        self.reStart()//设置按钮图片，即棋子图片（标准的开局）
        
        
    }
    
    func touch(sender: ChessPiece) {
        
        switch self.state {
            case .noRunning:
                do1()
            case .redC:
                do2(sender: sender)
            case .redT:
                do3(sender: sender)
            case .blackC:
                do4(sender: sender)
            case .blackT:
                do5(sender: sender)
            case .gameover:
                do6(sender: sender)
        }
        print("state:\(self.state)")
    }
    
    func do1() {
        alertMe(title: "开始游戏", message: "请按开始按钮！")
        
    }
    func do2(sender: ChessPiece) {
        guard sender.pcolor == .red else {
            return
        }
        self.selected = sender
        self.selected!.alpha = 0.5
        self.state = .redT
        
    }

    func do3(sender: ChessPiece) {
        self.selected?.alpha = 1
        guard selected!.canMove(piece: sender, pieceArray: self.pieceArray) else {
            self.state = .redC
            return
        }
        if sender.type == .shuai {
            self.state = .gameover
            alertMe(title: "游戏结束", message: "红方胜！")
            
        }else{
            self.state = .blackC
            self.hero.image = bJiang
        }
        
        sender.type  = selected!.type
        sender.pcolor = selected!.pcolor
        sender.setImage(image(type: selected!.type!, pcolor: selected!.pcolor!), for: .normal)
        
        
        selected!.pcolor = nil
        selected!.type = nil
        selected!.setImage(nil, for: .normal)
        
        
        
        
        
    }

    func do4(sender: ChessPiece) {
        guard sender.pcolor == .black else {
            return
        }
        self.selected = sender
        self.selected!.alpha = 0.5
        self.state = .blackT

    }

    func do5(sender: ChessPiece) {
        self.selected?.alpha = 1
        guard selected!.canMove(piece: sender, pieceArray: self.pieceArray) else {
            self.state = .blackC
            return
        }
        
        if sender.type == .shuai {
            self.state = .gameover
            alertMe(title: "游戏结束", message: "黑方胜！")
        }else{
            self.state = .redC
            self.hero.image = rShuai
        }
        sender.type  = selected!.type
        sender.pcolor = selected!.pcolor
        sender.setImage(image(type: selected!.type!, pcolor: selected!.pcolor!), for: .normal)
        
        selected!.pcolor = nil
        selected!.type = nil
        selected!.setImage(nil, for: .normal)
        
        
    }

    func do6(sender: ChessPiece) {
        alertMe(title: "游戏结束", message: "请重新开始一局")
    }
    
    
    func alertMe(title:String, message:String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    func image(type:Type, pcolor:Pcolor) -> UIImage {
        switch (type, pcolor) {
        case (.ju, .red):
            return rJu
        case (.ma, .red):
            return rMa
        case (.xiang, .red):
            return rXiang
        case (.shi, .red):
            return rShi
        case (.shuai, .red):
            return rShuai
        case (.pao, .red):
            return rPao
        case (.bing, .red):
            return rBing
        case (.ju, .black):
            return bJu
        case (.ma, .black):
            return bMa
        case (.xiang, .black):
            return bXiang
        case (.shi, .black):
            return bShi
        case (.shuai, .black):
            return bJiang
        case (.pao, .black):
            return bPao
        case (.bing, .black):
            return bZu
        }
    }


    @IBAction func sets(_ sender: UIButton) {
        
    }
    @IBAction func start() {
        guard self.state == .noRunning else {
            return
        }
        self.state = .redC
        self.hero.image = rShuai
        print(self.state)
    }

    @IBAction func reStart() {
        for i in 0..<9 {
            for j in 0..<10 {
                let n = i * 10 + j
                switch (j, i) {
                    
                case (0, 0), (0, 8):
                    self.pieceArray[n].pcolor = .black
                    self.pieceArray[n].type = .ju
                    self.pieceArray[n].setImage(bJu, for: .normal)
                case (0, 1), (0, 7):
                    
                    self.pieceArray[n].pcolor = .black
                    self.pieceArray[n].type = .ma
                    self.pieceArray[n].setImage(bMa, for: .normal)
                case (0, 2), (0, 6):
                    
                    self.pieceArray[n].pcolor = .black
                    self.pieceArray[n].type = .xiang
                    self.pieceArray[n].setImage(bXiang, for: .normal)
                case (0, 3), (0, 5):
                    
                    self.pieceArray[n].pcolor = .black
                    self.pieceArray[n].type = .shi
                    self.pieceArray[n].setImage(bShi, for: .normal)
                    
                case (0, 4):
                    
                    self.pieceArray[n].pcolor = .black
                    self.pieceArray[n].type = .shuai
                    self.pieceArray[n].setImage(bJiang, for: .normal)
                case (2, 1), (2, 7):
                    
                    self.pieceArray[n].pcolor = .black
                    self.pieceArray[n].type = .pao
                    self.pieceArray[n].setImage(bPao, for: .normal)
                case (3, 0),(3, 2),(3, 4),(3, 6),(3, 8):
                    
                    self.pieceArray[n].pcolor = .black
                    self.pieceArray[n].type = .bing
                    self.pieceArray[n].setImage(bZu, for: .normal)
                    
                case (9, 0), (9, 8):
                    
                    self.pieceArray[n].pcolor = .red
                    self.pieceArray[n].type = .ju
                    self.pieceArray[n].setImage(rJu, for: .normal)
                case (9, 1), (9, 7):
                    
                    self.pieceArray[n].pcolor = .red
                    self.pieceArray[n].type = .ma
                    self.pieceArray[n].setImage(rMa, for: .normal)
                case (9, 2), (9, 6):
                    
                    self.pieceArray[n].pcolor = .red
                    self.pieceArray[n].type = .xiang
                    self.pieceArray[n].setImage(rXiang, for: .normal)
                case (9, 3), (9, 5):
                    
                    self.pieceArray[n].pcolor = .red
                    self.pieceArray[n].type = .shi
                    self.pieceArray[n].setImage(rShi, for: .normal)
                case (9, 4):
                    
                    self.pieceArray[n].pcolor = .red
                    self.pieceArray[n].type = .shuai
                    self.pieceArray[n].setImage(rShuai, for: .normal)
                case (7, 1), (7,7):
                    
                    self.pieceArray[n].pcolor = .red
                    self.pieceArray[n].type = .pao
                    self.pieceArray[n].setImage(rPao, for: .normal)
                case (6, 0),(6, 2),(6, 4),(6, 6),(6, 8):
                    
                    self.pieceArray[n].pcolor = .red
                    self.pieceArray[n].type = .bing
                    self.pieceArray[n].setImage(rBing, for: .normal)
                    
                default:
                    self.pieceArray[n].pcolor = nil
                    self.pieceArray[n].type = nil
                    self.pieceArray[n].setImage(nil, for: .normal)
            }
            
        }
            self.state = .noRunning
            self.selected = nil
            self.hero.image = nil
    }
        
        
    
    }
}

