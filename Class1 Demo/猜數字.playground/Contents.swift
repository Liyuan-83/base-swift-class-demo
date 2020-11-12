import SwiftUI
import PlaygroundSupport
import Combine

class game{
    var anser : [Int]
    var count : Int
    
    init() {
        //宣告一個0~9的數字陣列
        let num = 0...9
        //透過shuffled()將陣列隨機排序，再透過prefix(n)取出前n個數值
        anser = Array(num.shuffled().prefix(4))
        count = 0
    }
    
    func getAnserLength() -> Int{
        return anser.count
    }
    
    func checkIsLegal(input:String) -> Bool{
        var filtered = input
        if filtered.count != anser.count{
            return false
        }
        filtered = filtered.filter { "0123456789".contains($0) }
        if filtered != input{
            return false
        }
        
        return true
    }
    
    func guess(_ number:String) -> String{
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
        return response
    }
}



struct ContentView: View {
    @State private var number = ""
    @State private var history = ""
    @State private var msg = ""
    @State private var btnDisable = false
    private var myGame = game()
    
    var body: some View {
        VStack(alignment:.leading){
            Text("猜數字遊戲：\(msg)")
            HStack{
                TextField("請輸入數字", text: $number)
                    .multilineTextAlignment(.center)
                    .onReceive(Just(number)) { newValue in
                        btnDisable = !myGame.checkIsLegal(input: newValue)
                    }
                Button("確定"){
                    let response = myGame.guess(number)
                    history = history + response
                    number = ""
                    msg = ""
                }.disabled(btnDisable)
            }
            Text(history)
                .multilineTextAlignment(.leading)
        }
        .frame(width: 300, height: 1000, alignment: .top)
        .padding()
    }
}

PlaygroundPage.current.setLiveView(ContentView())
