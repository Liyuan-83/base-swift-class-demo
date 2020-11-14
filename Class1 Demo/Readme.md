# AB遊戲介紹
![final](https://github.com/Liyuan-83/swift-class-playground-demo/blob/main/Class1%20Demo/final.png "final")
#### 遊戲規則
* 隨機產生一個0~9的四位數字，其中數字不可重複，例：0815
* 猜測提示：
  * A：數字與位置皆正確
  * B：數字正確，位置不正確
  * 例：猜「0123」，輸出提示1A1B
* 結束條件：4A，猜中全部的數字
-----
#### 設計步驟

1. 使用SwiftUI設計遊戲的介面
```Swift
import SwiftUI
import PlaygroundSupport
import Combine
 
struct ContentView: View {
    @State private var number = ""
    @State private var btnDisable = false
    
    var body: some View {
        VStack(alignment:.leading){
            Text("猜數字遊戲：")
            HStack{
                TextField("請輸入數字", text: $number)
                    .multilineTextAlignment(.center)
                    .onReceive(Just(number)) { newValue in
                        
                    }
                Button("確定"){
                    
                }.disabled(btnDisable)
            }
            Text("歷史紀錄：")
                .multilineTextAlignment(.leading)
        }
        .frame(width: 300, height: 1000, alignment: .top)
        .padding()
    }
}
 
PlaygroundPage.current.setLiveView(ContentView())
```

2. 以物件導向來設計遊戲的物件
```Swift
class game{
    private var anser : [Int]
    private var count : Int
    private var history : String
    
    init() {
        
    }
    
    func checkIsLegal(input:String) -> Bool{
        
    }
       
    func showHistory() -> String {
        
    }
 
    func guess(_ number:String){
        
    }
}
```

3. 遊戲初始化
```Swift
    init() {
        //宣告一個0~9的數字範圍
        let num = 0...9
        //透過shuffled()將陣列隨機排序，再透過prefix(n)取出前n個數值
        anser = Array(num.shuffled().prefix(4))
        count = 0
        history = "歷史紀錄：\n"
    }
```

4. 確認輸入是否符合遊戲規則
```Swift
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
```

5. 顯示歷史紀錄
```Swift
   func showHistory() -> String {
        return history
    }
```

6. 猜
```Swift
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
```

7. 新增Game物件至SwiftUI
```Swift
struct ContentView: View {
    @State private var number = ""
    @State private var btnDisable = false
    private var myGame = game()
```

8. 更新UI
```Swift
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
```

9.完成
