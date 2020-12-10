//
//  ViewController.swift
//  猜數字
//
//  Created by 張力元 on 2020/11/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var input: UITextField!
    
    var myGame : game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGame = game()
        historyLabel.text = myGame.showHistory()
    }
    
    @IBAction func tapBtn(_ sender: Any) {
        if let anser = input.text,
           myGame.checkIsLegal(input: anser){
            input.text = ""
            myGame.guess(anser)
            historyLabel.text = myGame.showHistory()
        }else{
            print("請輸入正確的數字")
        }
    }
}

class game{
    private var anser : [Int]
    private var count : Int
    private var history : String
    
    init() {
        //宣告一個0~9的數字範圍
        let num = 0...9
        //透過shuffled()將陣列隨機排序，再透過prefix(n)取出前n個數值
        anser = Array(num.shuffled().prefix(4))
        count = 0
        history = "歷史紀錄：\n"
    }
    
    func checkIsLegal(input:String) -> Bool{
        //檢查是否全部都是數字
        let filtered = input.filter { "0123456789".contains($0) }
        //檢查是否有重複的數字
        var set : Set<String.Element> = []
        for (_,char) in filtered.enumerated(){
            set.insert(char)
        }
        //檢查輸入的字數是否與答案相符
        return input.count == anser.count && filtered == input && input.count == set.count
    }
    
    func guess(_ number:String){
        count += 1
        var guessAns = number.compactMap{Int(String($0))}
        var A = 0
        for index in (0...anser.count-1).reversed(){
            if anser[index] == guessAns[index]{
                A+=1
                guessAns.remove(at: index)
            }
        }
        let common = Set(anser).intersection(Set(guessAns))
        let B = common.count
        var response = "\(count). " + number + ":\(A)A\(B)B\n"
        if A == anser.count{
            response = response + "恭喜你！猜對了！"
        }
        history = history + response
    }
    
    func showHistory() -> String {
        return history
    }
}

