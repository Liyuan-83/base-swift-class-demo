import SwiftUI
import PlaygroundSupport
import Combine

class game{
    private var anser : [Int]
    private var count : Int
    private var history : String
    
    init() {
        //宣告一個0~9的數字陣列
        let num = 0...9
        //透過shuffled()將陣列隨機排序，再透過prefix(n)取出前n個數值
        anser = Array(num.shuffled().prefix(4))
        count = 0
        history = "歷史紀錄：\n"
    }
    
    func getAnserLength() -> Int{
        return anser.count
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

struct ContentView: View {
    @State private var number = ""
    @State private var btnDisable = false
    private var myGame = game()
    
    var body: some View {
        VStack(alignment:.leading){
            Text("猜數字遊戲：")
            HStack{
                TextField("請輸入數字", text: $number)
                    .multilineTextAlignment(.center)
                    .onReceive(Just(number)) { newValue in
                        btnDisable = !myGame.checkIsLegal(input: newValue)
                    }
                Button("確定"){
                    myGame.guess(number)
                    number = ""
                }.disabled(btnDisable)
            }
            Text(myGame.showHistory())
                .multilineTextAlignment(.leading)
        }
        .frame(width: 300, height: 1000, alignment: .top)
        .padding()
    }
}

PlaygroundPage.current.setLiveView(ContentView())
