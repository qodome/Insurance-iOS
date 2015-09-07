//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class XML: NSObject, NSXMLParserDelegate {
    
    var dictonary: [String : String] = [:]
    var contentString: String?
    
    func startParse(data: NSData) {
        // xml解析
        let xmlParser = NSXMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
    }
    
    // MARK: - 💜 NSXMLParserDelegate
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        contentString = string
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if contentString != "\n" && elementName != "root" {
            dictonary[elementName] = contentString!.copy() as? String
        }
    }
}
