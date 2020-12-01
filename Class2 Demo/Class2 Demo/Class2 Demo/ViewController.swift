//
//  ViewController.swift
//  Class2 Demo
//
//  Created by Transcend on 2020/12/1.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let graphNum = Int.random(in: 1...4)
        
        switch graphNum {
        case 1:
            let sideLength = 5
            for _ in 1...sideLength {
                var str = ""
                for _ in 1...sideLength {
                    str = showGraph1Row(str: str)
                }
                print(str)
            }
            
        case 2:
            let sideLength = 5
            for col in 1...sideLength {
                var str = ""
                for row in 1...sideLength {
                    str = showGraph2Row(str: str, length: sideLength, col: col, row: row)
                }
                print(str)
            }
            
        case 3:
            let sideLength = 7
            for col in 1...sideLength {
                var str = ""
                for row in 1...sideLength {
                    str = showGraph3Row(str: str, col: col, row: row)
                }
                print(str)
            }
            
        case 4:
            let sideLength = 7
            for col in 1...sideLength {
                var str = ""
                for row in 1...sideLength {
                    str = showGraph4Row(str: str, length: sideLength, col: col, row: row)
                }
                print(str)
            }
            
        default:
            print("預設沒有圖形喔")
        }
    }
    
    func showGraph1Row(str:String) -> String {
        return str + "*"
    }

    func showGraph2Row(str:String, length:Int, col:Int, row:Int) -> String {
        if col == 1 || col == length || row == 1 || row == length{
            return str + "*"
        }
        return str + "-"
    }
    
    func showGraph3Row(str:String, col:Int, row:Int) -> String {
        if col % 2 == 1 || row % 2 == 1{
            return str + "*"
        }
        return str + "-"
    }
    
    func showGraph4Row(str:String, length:Int, col:Int, row:Int) -> String {
        if col == 1 || col == length || row == 1 || row == length{
            return str + "*"
        }else if col >= 3 && col <= length - 2 && row >= 3 && row <= length - 2{
            if col == row && col == length/2+1{
                return str + "-"
            }
            return str + "*"
        }
        return str + "-"
    }

}

