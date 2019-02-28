

import Foundation

class ParserManager : NSObject {
    
    static let shared = ParserManager()
    
    var currencies: [Currency] = [Currency]()
    
    var parser : XMLParser?
    
    var element = String()
    var currencyModel : Currency = Currency.init()
    
    override init() {
        super.init()
        
        if let url = URL(string: "http://www.nbrb.by/Services/XmlExRates.aspx") {
            parser = XMLParser(contentsOf: url)
            parser?.delegate = self
        }
    }
    
    func parse() {
        
        currencies.removeAll()
        
        parser?.parse()
    }
}

extension ParserManager : XMLParserDelegate {
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        element = elementName
        if element == "Currency" {
            currencyModel = Currency.init()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element == "CharCode" {
            currencyModel.charCode.append(string)
        } else if element == "Scale" {
            currencyModel.scale.append(string)
        } else if element == "Name" {
            currencyModel.name.append(string)
        } else if element == "Rate" {
            currencyModel.rate.append(string)
        }
    }
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        if elementName == "Currency" {
            
            let currency = Currency.init(
                charCode: currencyModel.charCode.replacingOccurrences(of: "\n", with: ""),
                    rate: currencyModel.rate.replacingOccurrences(of: "\n", with: ""),
                   scale: currencyModel.scale.replacingOccurrences(of: "\n", with: ""),
                    name: currencyModel.name.replacingOccurrences(of: "\n", with: ""))

            currencies.append(currency)
        }
    }
    
}
