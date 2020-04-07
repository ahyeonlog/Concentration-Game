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
    //카드 뒤집은 횟수
    //var flipCount : Int > 속성은 초기화를 해주어야 함
    //var flipCount : Int = 0
    //swift는 강한 타입 추론 언어
    //option + click으로 설명 볼 수 있음 > Int 인 것 확인 가능
    var flipCount = 0{
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
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        //flip card with emoji ghost on sender
        //영어처럼 읽히게 작명해야 함
        flipCount += 1
        //"\(변수)" 로 출력 가능
        //flipCountLabel.text = "Flips : \(flipCount)"
        flipCard(withEmoji : "👻", on : sender)
    }
    
    @IBAction func touchSecondCard(_ sender: UIButton) {
        flipCount += 1
        //flipCountLabel.text = "Flips : \(flipCount)"
        flipCard(withEmoji: "🎃", on: sender)
    }
    
    //flip card with emoji ghost on sender
    //영어처럼 읽히게 작명해야 함
    func flipCard(withEmoji emoji : String, on button : UIButton){
        //무언갈 보냈다고 생각했는데 안될 때, 스토리보드에서 개체 우클릭
        //print("flipCard(withEmoji:\(emoji))")
        
        //내부이름 사용, 외부 이름은 호출자가 사용
        //button.title 까지 치면 자동완성 목록에서 선택 가능
        if button.currentTitle == emoji{
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        } else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
}

