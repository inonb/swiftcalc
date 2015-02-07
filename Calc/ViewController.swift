
import UIKit

class ViewController: UIViewController {

    /*
     * 変数
     */
    
    var isTypingNumber = false  // 数字をタイプ中か
    var bufferNumber : Int! = 0  // 計算中の数値
    var nextOperation : String?   // 次に演算する操作　+, -
    
    @IBOutlet weak var display: UILabel!    // 結果を表示するラベル
    
    /*
     * メソッド
     */
    
    // 数字キーが押されたとき
    @IBAction func digit(sender: UIButton) {
        // ログに表示
        println("pushed \(sender.currentTitle)")
        
        if isTypingNumber {
            let digit = sender.currentTitle!
            display.text = display.text! + digit
        } else {
            display.text = sender.currentTitle!
            isTypingNumber = true
        }
    }
    
    // 操作キー（+-=C）が押されたとき
    @IBAction func operation(sender: UIButton) {
        // ログに表示
        println("pushed \(sender.currentTitle)")
        
        if sender.currentTitle == "C" {
            bufferNumber = 0
            nextOperation = nil
            
        } else {
            if nextOperation == nil {
            //はじめて演算キーを押したとき
                bufferNumber = displayInt()
            } else if nextOperation == "+" {
            //前回+を押したとき
                bufferNumber = bufferNumber + displayInt()
            } else if nextOperation == "-" {
            //前回-を押したとき
                bufferNumber = bufferNumber - displayInt()
            }
            
            // 実際の計算は次のキーを押した時なので、演算の種類をとっておく
            if (sender.currentTitle == "+" || sender.currentTitle == "-") {
                nextOperation = sender.currentTitle
            }
        }
        
        display.text = "\(bufferNumber)"
        isTypingNumber = false
        
        // =は計算いったん完了
        if (sender.currentTitle == "=") {
            bufferNumber = 0
            nextOperation = nil
        }
    }
    
    // 表示されている結果を数値で返す
    func displayInt() -> Int {
        if let displayInt : Int = display.text?.toInt() {
            return displayInt
        } else {
            return 0
        }
    }
}