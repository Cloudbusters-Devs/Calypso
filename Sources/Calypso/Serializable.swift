//           _____ _                 _ _               _
//          /  __ \ |               | | |             | |
//          | /  \/ | ___  _   _  __| | |__  _   _ ___| |_ ___ _ __ ___
//          | |   | |/ _ \| | | |/ _` | '_ \| | | / __| __/ _ \ '__/ __|
//          | \__/\ | (_) | |_| | (_| | |_) | |_| \__ \ ||  __/ |  \__ \
//           \____/_|\___/ \__,_|\__,_|_.__/ \__,_|___/\__\___|_|  |___/
//

import Foundation

public typealias keyPairArrays = (keys: [String], values: [Any])

public protocol Serializable {
    var properties: Array<String> { get }
    func valueForKey(key: String) -> Any?
    func toDictionary() -> [String:Any]
    func disassembleDic() -> (keyPairArrays)
}

public extension Serializable {
    func toDictionary() -> [String:Any] {
        var dict:[String:Any] = [:]

        for prop in self.properties {
            if let val = self.valueForKey(key: prop) as? String {
                dict[prop] = val
            } else if let val = self.valueForKey(key: prop) as? Int {
                dict[prop] = val
            } else if let val = self.valueForKey(key: prop) as? Double {
                dict[prop] = val
            } else if let val = self.valueForKey(key: prop) as? Array<String> {
                dict[prop] = val
            } else if let val = self.valueForKey(key: prop) as? Serializable {
                dict[prop] = val.toDictionary()
            } else if let val = self.valueForKey(key: prop) as? Array<Serializable> {
                var arr = Array<[String:Any]>()
                for item in (val as Array<Serializable>) {
                    arr.append(item.toDictionary())
                }
                dict[prop] = arr
            }
        }
        return dict
    }
    
    func disassembleDic() -> keyPairArrays {
        let dict: [String:Any] = self.toDictionary()
        var sArray: [String] = []
        var aArray: [Any] = []
        
        dict.forEach { sArray.append($0.key)   }
        dict.forEach { aArray.append($0.value) }
        
        return (sArray, aArray)
    }
}
