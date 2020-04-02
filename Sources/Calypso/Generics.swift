//           _____ _                 _ _               _
//          /  __ \ |               | | |             | |
//          | /  \/ | ___  _   _  __| | |__  _   _ ___| |_ ___ _ __ ___
//          | |   | |/ _ \| | | |/ _` | '_ \| | | / __| __/ _ \ '__/ __|
//          | \__/\ | (_) | |_| | (_| | |_) | |_| \__ \ ||  __/ |  \__ \
//           \____/_|\___/ \__,_|\__,_|_.__/ \__,_|___/\__\___|_|  |___/
//

/**   - Generic Templates for Generic Primitive Types -
 
 ----   Generics is a Library to wrap commonly used Primitive Data Types
 ----   Objects are called using the new function rather than using the constructor
 ----   Implement your own version of new for your custom data types
 ----   Creating a Type with the custom Classes GString, GNumber and GBoolean will result in easy casting ability and code clarity
*/

import Foundation
import CloudKit

public class Generics {

    public static func new(n : TrueGeneric) -> GNumber<Double> {
        return GNumber(n.__repr__() as! Double)
    }
    
    public static func new(b : TrueGeneric) -> GBoolean<Bool> {
        return GBoolean(b.__bool__() as! Bool)
    }
    
    public static func new(s : TrueGeneric) -> GString<String> {
        return GString(s.__str__() as! String)
    }
    
    public static func new() -> Obj<Double> {
        return Obj()
    }
    
    public static func new<T: TrueGeneric, O: TrueGeneric>(i: T, o: O.Type) -> Obj<O> {
        let newI = i.__to__(t: O.self) as! O
        return Obj(newI)
    }
    
    public static func newObjectFromRecord(r: CKRecord) -> Obj<String> {
        return Obj.make(r)
    }

    public class GNumber<T : TrueGeneric> : Obj<T> {

        static func NAN() -> GNumber {
            return GNumber.init()
        }
        
        override class func make(from: T) -> GNumber {
            return GNumber(from)
        }
        
        override class func make(_ from: T) -> GNumber {
            return GNumber(from)
        }
    }
    
    public class GBoolean<T: TrueGeneric> : Obj<T> {
        
        override class func make(from: T) -> GBoolean {
            return GBoolean(from)
        }
        
        override class func make(_ from: T) -> GBoolean {
            return GBoolean(from)
        }
    }
    
    public class GString<T: TrueGeneric> : Obj<T> {
        
        override class func make(from: T) -> GString {
            return GString(from)
        }
        
        override class func make(_ from: T) -> GString {
            return GString(from)
        }
    }
    
    public class Obj<T : TrueGeneric> : TrueGeneric {
        
        public func __typ__() -> TrueGeneric.Type {
            return type(of: self)
        }
        
        public func __to__(t: TrueGeneric.Type) -> TrueGeneric {
            return self
        }
        
        var value: T
        
        fileprivate init() {
            self.value = T.__default__().__repr__() as! T
        }
        
        fileprivate init(_ v: T) {
            self.value = v
        }
        
        public func __bool__() -> TrueGeneric {
            return self.value.__bool__()
        }
        
        public func __str__() -> TrueGeneric {
            return self.value.__str__()
        }
        
        public func __repr__() -> TrueGeneric {
            return self.value.__repr__()
        }
        
        public static func __default__() -> TrueGeneric {
            return T.__default__()
        }
        
        class func make(from: T) -> Obj {
            return Obj(from)
        }
        
        class func make(_ from: T) -> Obj {
            return Obj(from)
        }
        
        class func make(from: CKRecord) -> Obj {
            return Obj(from.value(forKey: "value") as! T)
        }
        
        class func make(_ from: CKRecord) -> Obj {
            return Obj(from.value(forKey: "value") as! T)
        }
    }
}

