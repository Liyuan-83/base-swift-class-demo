import SwiftUI
import PlaygroundSupport
import Combine

//宣告一個0~9的數字陣列
let num = 0...9
//透過shuffled()將陣列隨機排序，再透過prefix(n)取出前n個數值
let correctAnswer = num.shuffled().prefix(4)

struct ContentView: View {
    @State private var number = ""
    @State private var history = ""
    @State private var msg = ""
    @State private var count = 0
    
    var body: some View {
        VStack(alignment:.leading){
            Text("猜數字遊戲：\(msg)")
            HStack{
                TextField("請輸入數字", text: $number)
                    .multilineTextAlignment(.center)
                    .onReceive(Just(number)) { newValue in
                        var filtered = newValue
                        if filtered.count > 4 {
                            filtered = String(filtered.prefix(4))
                        }
                        filtered = filtered.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            number = filtered
                        }
                    }
                Button("確定"){
                    var anser = number.compactMap{Int(String($0))}
                    if anser.count != correctAnswer.count{
                        msg = "格式錯誤"
                        number = ""
                        return
                    }
                    count += 1
                    var A = 0,B = 0
                    for index in (0...correctAnswer.count-1).reversed(){
                        if correctAnswer[index] == anser[index]{
                            A+=1
                            anser.remove(at: index)
                        }
                    }
                    for num in anser{
                        if correctAnswer.contains(num){
                            B+=1
                        }
                    }
                    history = history + "\(count). " + number + ":\(A)A\(B)B\n"
                    number = ""
                    msg = ""
                    if A == correctAnswer.count{
                        history = history + "恭喜你！猜對了！"
                    }
                }
            }
            Text(history)
                .multilineTextAlignment(.leading)
        }
        .frame(width: 300, height: 1000, alignment: .top)
        .padding()
    }
}

PlaygroundPage.current.setLiveView(ContentView())
