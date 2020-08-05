//
//  ViewController.swift
//  Concentration
//
//  Created by Ahyeon Gil on 2020/04/02.
//  Copyright © 2020 Ahyeon. All rights reserved.
//


//import는 include와 같은 것
//UIKit는 버튼과 슬라이드 등이 있는 프레임워크
import UIKit


//객체 지향적인 의미에서 클래스의 선언문
//UIViewController는 슈퍼클래스
//제어하는 모든 것을 상속받는다.
class ViewController: UIViewController {
    //스토리보드는 V, 이 코드는 C, 우리는 M(Concentration)이 필요하다.
    //C에서 M으로의 큰 화살표를 생성
    //모든 클래스에서 모든 변수들이 초기화되면 인수가 없는 공짜 initializer을 가지게 된다
    //var game: Concentration = Concentration()
    //swift는 타입추론
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    //카드 수는 물을 수 있지만 set은 불가능
    //읽기전용 속성일때는  get키워드 안써도 됨
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2
    }
    
    
    //카드 뒤집은 횟수
    //var flipCount : Int > 속성은 초기화를 해주어야 함
    //var flipCount : Int = 0
    //swift는 강한 타입 추론 언어
    //option + click으로 설명 볼 수 있음 > Int 인 것 확인 가능
    private(set) var flipCount = 0{
        //property observers
        //속성이 변화하는 것을 감지함
        //flipCount가 바뀔 때마다 didSet을 실행
        //인스턴스변수와 UI의 싱크를 맞추기 위해 자주 사용
        didSet{
            flipCountLabel.text = "Flips : \(flipCount)"
        }
    }

    
    //타입이 UILabel, 이 경우 swift는 타입 추론 할 수 없음
    //weak, ! 가 뭔지는 다음주에 설명
    //@IBOutlet > 지시문
    @IBOutlet weak private var flipCountLabel: UILabel!
    
    //모든 카드에 대해 touchCard 함수를 사용하기 위해 배열 생성
    //ctrl + drag 로 연결 후
    //Connection : Outlet Collection, UI에 있는 것들의 배열
    //Type : UIButton, UIButton의 배열
    //코드와 UI가 연결되어 있는 것의 이름을 수정할 땐 바로 수정하면 연결이 끊길 수 있기 때문에 Cmd + click > rename
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        //flip card with emoji ghost on sender
        //영어처럼 읽히게 작명해야 함
        flipCount += 1
        //"\(변수)" 로 출력 가능
        //flipCountLabel.text = "Flips : \(flipCount)"
        //flipCard(withEmoji : "👻", on : sender)
        
        //var은 에러 뜸 swift에서 상수는 명시해주어야 함 > let으로 수정
        //why? swift는 영어처럼 읽혀야 함
        //let cardNumber equal cardNumber index of sender
        //firstIndex의 return은 Int? > 옵셔널을 의미함
        //옵셔널이란 설정된 것과 설정되지 않은 것 두가지 상태만 존재
        //Swift에서 nil은 설정되지 않은 옵셔널의 상태를 의미한다.
        //옵셔널을 정상적으로 사용하기 위한 방법 1. 해당 타입 뒤에 느낌표를 붙이거나 2.if let 조건문 활용
        if let cardNumber = cardButtons.firstIndex(of: sender){
            // print("cardNumber = \(cardNumber)")
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            //M에게 시키기
            game.chooseCard(at: cardNumber)
            
            //V동기화 시켜주기(뷰는 모델과 동기화가 안되어 있음)
            updateViewFromModel()
            
        } else {
            print("chosen card was not in cardButtons")
        }
       
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMached ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    
    //var emojiChoices: Array<String> = ["🎃","👻","🎃","👻"]
    private var emojiChoices = ["🤡","👻","🎃","💀", "🧟‍♀️", "🕷", "🍭", "🍬"]
    
    //var emoji = Dictionary<Int, String>()
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
        return emoji[card.identifier] ?? "?"
    }
    
    
    
    //touchCard와 반복되는 코드 수정
//    @IBAction func touchSecondCard(_ sender: UIButton) {
//        flipCount += 1
//        //flipCountLabel.text = "Flips : \(flipCount)"
//        flipCard(withEmoji: "🎃", on: sender)
//    }
    
    
    //flip card with emoji ghost on sender
    //영어처럼 읽히게 작명해야 함
    //func flipCard(withEmoji emoji : String, on button : UIButton){
        //무언갈 보냈다고 생각했는데 안될 때, 스토리보드에서 개체 우클릭
        //print("flipCard(withEmoji:\(emoji))")
        
        //내부이름 사용, 외부 이름은 호출자가 사용
        //button.title 까지 치면 자동완성 목록에서 선택 가능
//        if button.currentTitle == emoji{
//            button.setTitle("", for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
//        } else{
//            button.setTitle(emoji, for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        }
    //}
    
}

