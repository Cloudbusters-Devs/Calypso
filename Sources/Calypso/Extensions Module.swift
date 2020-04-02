//           _____ _                 _ _               _
//          /  __ \ |               | | |             | |
//          | /  \/ | ___  _   _  __| | |__  _   _ ___| |_ ___ _ __ ___
//          | |   | |/ _ \| | | |/ _` | '_ \| | | / __| __/ _ \ '__/ __|
//          | \__/\ | (_) | |_| | (_| | |_) | |_| \__ \ ||  __/ |  \__ \
//           \____/_|\___/ \__,_|\__,_|_.__/ \__,_|___/\__\___|_|  |___/
//

/**   - Generic Templates for Generic Primitive Types -

----   A series of protocols made to make conversion between types easier, faster and generalised
----   The whole goal is to make a C-style kind of conversion in swift with Generic Types
----   Genericable and __default__() Are used to compute the default value for a given newborn Object:
----       false for Bool, 0 for numeric types, an empty string for String
----       Try to return the default contructor (Classname.init()) for a custom implementation of this protocol
----   Numerable and __repr__() Are used to compute the numerical representation of Objects conforming to this protocol:
----       1.0 for true, 0.0 for false, the default conversion for valid Strings otherwise Double.nan, numbers are cast to Double
----       Try to return 0.0 for Objects with no particular use in this protocol, otherwise document your custom implementation
----   Stringable and __srt__() are used to compute the String representation of Objects conforming to this protocol:
----       "1.0" for true and "0.0" for false to allow for chainable conversion, otherwise the interpolated value is returned
----       Try to return a sensible String representation for your Objects, otherwise "0.0" is recommended
----    Booleanable and __bool__() are used to compute the Boolean representation of Objects conforming to this protocol:
----       true is returned for any value that Bool can be converted to, false is returned otherwise
----       Try to return 0.0 for Objects with no particular use in this protocol, otherwise we suggest returning Obj != nil
----    TrueGeneric is a Wrapper for all of the following protocols and we recommend you just implement this and fill the stubs
*/

import Foundation

public protocol Genericable : Codable                       { static func __default__() -> TrueGeneric        }
public protocol Numerable   : Genericable                   { func __repr__() -> TrueGeneric                  }
public protocol Stringable  : Genericable                   { func __str__() ->  TrueGeneric                  }
public protocol Booleanable : Numerable                     { func __bool__() -> TrueGeneric                  }
public protocol TrueGeneric : Booleanable, Stringable       { func __typ__()  -> TrueGeneric.Type
    func __to__(t: TrueGeneric.Type) -> TrueGeneric }
public protocol FullSerializable: TrueGeneric, Serializable {                                                 }

extension Int      : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return Double(self)                        }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1                           }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension Int8     : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return Double(self)                        }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1                           }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension Int16    : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return Double(self)                        }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1                           }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension Int32    : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return Double(self)                        }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1                           }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension Int64    : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return Double(self)                        }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1                           }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension UInt     : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return Double(self)                        }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1                           }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension UInt8    : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return Double(self)                        }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1                           }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension UInt16   : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return Double(self)                        }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1                           }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension UInt32   : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return Double(self)                        }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1                           }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension UInt64   : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return Double(self)                        }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1                           }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension Float    : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return Double(self)                        }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1.0                         }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension Double   : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return self                                }
    public func __str__()                   -> TrueGeneric      { return "\(self)"                           }
    public func __bool__()                  -> TrueGeneric      { return self == 1.0                         }
    public static func __default__()        -> TrueGeneric      { return 0                                   }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__repr__())           }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if type(of: t.__default__()) == Double.self             { return self.__repr__() as! Double          }
        if type(of: t.__default__()) == Bool.self               { return self.__bool__() as! Bool            }
        if type(of: t.__default__()) == String.self             { return self.__str__()  as! String          }
        return false                                                                                         }
}
extension Bool     : TrueGeneric {
    public func __repr__()                  -> TrueGeneric      { return self ? 1.0 : 0.0                     }
    public func __str__()                   -> TrueGeneric      { return "\(self ? 1.0 : 0.0)"                }
    public func __bool__()                  -> TrueGeneric      { return self                                 }
    public static func __default__()        -> TrueGeneric      { return false                                }
    public func __typ__()                   -> TrueGeneric.Type { return type(of: self.__bool__())            }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if t == Double.self                                     { return self.__repr__() as! Double           }
        if t == Bool.self                                       { return self.__bool__() as! Bool             }
        if t == String.self                                     { return self.__str__()  as! String           }
        return false                                                                                          }
}
extension String   : TrueGeneric {
    public func __repr__()           -> TrueGeneric             { return Double(self)?.__repr__() ?? Double.nan.__repr__() }
    public func __str__()            -> TrueGeneric             { return self                                 }
    public func __bool__()           -> TrueGeneric             { return self == true.__str__() as! String    }
    public static func __default__() -> TrueGeneric             { return "0.0"                                }
    public func __typ__()            -> TrueGeneric.Type        { return type(of: self.__str__())             }
    public func __to__(t: TrueGeneric.Type) -> TrueGeneric      {
        if t == Double.self                                     { return self.__repr__() as! Double           }
        if t == Bool.self                                       { return self.__bool__() as! Bool             }
        if t == String.self                                     { return self.__str__()  as! String           }
        return false                                                                                          }
}
