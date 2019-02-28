

import Foundation

class Currency {
    
    var charCode: String
    var rate: String
    var scale: String
    var name: String
    
    init() {
        
        self.charCode = ""
        self.rate = ""
        self.scale = ""
        self.name = ""
    }
    
    init(charCode: String, rate: String, scale: String, name: String) {
        
        self.charCode = charCode
        self.rate = rate
        self.scale = scale
        self.name = name
    }
}
