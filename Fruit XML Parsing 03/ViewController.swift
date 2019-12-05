//
//  ViewController.swift
//  Fruit XML Parsing 03
//
//  Created by dit02 on 2019. 12. 5..
//  Copyright © 2019년 DIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var item:[String:String] = [:]
    var elements:[[String:String]] = []
    var currentElement = "" //현재 태그저장
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml")
        // 옵셔널 바인딩 체크
        if path != nil {
            
           let myParser = XMLParser(contentsOf: path!)
            myParser?.delegate = self
            if myParser?.parse() != nil {
                print("parsing succed")
            } else {
                print("parsing error")
            }
        } else {
            print("file error")
        }
        
        // 태그를 만날때 호출
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
            
            currentElement = elementName
            print(currentElement)
        }
        //태그 다음에 문자를 만날때
        func parser(_ parser: XMLParser, foundCharacters string: String){
            // 문자 공백 제거
            let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
            if !data.isEmpty{
                item[currentElement] = data
            }
        }
        // 태그가 끝날때 호출
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            if elementName == "item"{
                elements.append(item)
            }
        }
    }
}

