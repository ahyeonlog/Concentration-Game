//
//  Card.swift
//  Concentration
//
//  Created by Ahyeon Gil on 2020/04/08.
//  Copyright © 2020 Ahyeon. All rights reserved.
//

import Foundation

//구조체와 클래스의 차이
//1. 구조체는 상속성이 없다
//2. 구조체는 값 타입이고 클래스는 참조 타입이다.
//값 타입은 복사된다.
//참조 타입은 포인터 사용


//UI와 독립적이기 때문에 이미지, 색, 이모티콘 같은 것이 있으면 안됨
//이것들은 카드를 "어떻게" 보여주는지와 관련된 내용이다.

struct Card
{
    //앞, 뒷면 구분
    var isFaceUp = false
    var isMached = false
    //식별자
    var identifier: Int
    
    //각각의 카드에 저장되는 변수가 아니라 카드 타입에 저장됨
    static var identifierFactory = 0
    
    //stactic 함수는 Card 타입에게만 메세지를 보냄
    static func getUniqueIdentifier() -> Int {
        //Card.identifierFactory += 1
        //return Card.identifierFactory
        //정적 메소드 안이기때문에 Card.~~ 로 작성하지 않아도 됨
        identifierFactory += 1
        return identifierFactory
    }
    //init(identifier i : Int)
    //내부이름과 외부이름이 같은 경우
    init() {
        //self. > my identifier 즉 이 카드의 식별자를 의미
        //좌변은 카드의 식별자, 우변은 init의 인수
        self.identifier = Card.getUniqueIdentifier()
    }


}
