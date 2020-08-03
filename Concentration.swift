//
//  Concentration.swift
//  Concentration
//
//  Created by Ahyeon Gil on 2020/04/08.
//  Copyright © 2020 Ahyeon. All rights reserved.
//

import Foundation

//이건 모델이고 UI와  완벽히 독립적이다.

class Concentration
{
    //새로운 클래스를 만들고 나면 이것의 공개 API가 무엇인지 생각해야 한다.
    
    
    //var cards = Array<Card>()
    var cards = [Card]()
    
    //
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    //첫번째로 뒤집은 카드라면
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        // 이미 앞면인 카드가 있다면 nil 리턴
                        return nil
                    }
                }
            }
            return foundIndex
        } set {
            //아무것도 쓰지 않는다면 newValue가 지역변수가됨
            for index in cards.indices {
                // index가 어떤 값이라면 참 아니라면 거짓
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isMached {
            // indexOfOneAndOnlyFaceUpCard : 계산 속성으로 요청될때마다 새롭게 계산함
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMached = true
                    cards[index].isMached = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        } else {
//            cards[index].isFaceUp = true
//        }
    }
    
    init(numberOfPairsOfCards : Int){
        //구조체는 클래스와 다르게 모든 변수를 초기화할 수 있는 공짜 이니셜라이저를 받는다
        //c.f) 클래스는 인수가 없는 이니셜라이저 받음
        //for문의 in 뒤에는 시퀀스 사용
        //시퀀스란 범위 안에서 다음, 다음으로 넘어갈 수 있는것
        //for identifier in 1...numberOfPairsOfCards {
        //swift에서 _ 의 의미는 사용하지 않거나 다시 쓰지 않는다는 뜻
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            //짝이 되는 카드
            //let matchingCard = Card(identifier = identifier)
            //구조체를 다른 변수에 할당할 때 복사하기 때문이다. (Card가 구조체)
            //let matchingCard = card
            
//          //cards 배열에 추가
//          cards.append(card)
//          //let matchingCard ~부분도 필요가 없음 배열에 넣거나 뺄 때도 카드를 복사하기 때문
//          //cards.append(matchingCard)
//          //구조체를 주고받을 땐 복사한다는 걸 이해하기!!
//          //같은 카드와 메모리를 가리키는 포인터가 아니라 두 개의 다른 카드가 됨
//          cards.append(card)
            cards += [card, card]
        }
        
        //TODO: Shuffle the cards
        cards.shuffle()
    }
}
