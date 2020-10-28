import SwiftUI
import PlaygroundSupport
import Combine

var correctAnswer : [Int] = []
while correctAnswer.count < 4{
    let num = Int.random(in: 0...9)
    if !correctAnswer.contains(num){
        correctAnswer.append(num)
    }
}

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
                Button("確定"){
                    if number.count != correctAnswer.count{
                        msg = "格式錯誤"
                        number = ""
                        return
                    }
                    for char in number{
                        if !"0123456789".contains(char){
                            msg = "輸入的不是數字"
                            number = ""
                            return
                        }
                    }
                    var anser : [Int] = []
                    let numArr = Array(number)
                    for char in numArr{
                        let num = String(char)
                        anser.append(Int(num)!)
                    }
                    count += 1
                    var A = 0,B = 0
                    for index in 0...correctAnswer.count-1{
                        if correctAnswer[index] == anser[index]{
                            A+=1
                        }
                    }
                    myGuess:for num in anser{
                        theAnser:for correctNum in correctAnswer{
                            if correctNum == num{
                                B+=1
                                break theAnser
                            }
                        }
                    }
                    B = B - A
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
