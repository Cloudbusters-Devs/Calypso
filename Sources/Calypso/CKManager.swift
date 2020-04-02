//           _____ _                 _ _               _
//          /  __ \ |               | | |             | |
//          | /  \/ | ___  _   _  __| | |__  _   _ ___| |_ ___ _ __ ___
//          | |   | |/ _ \| | | |/ _` | '_ \| | | / __| __/ _ \ '__/ __|
//          | \__/\ | (_) | |_| | (_| | |_) | |_| \__ \ ||  __/ |  \__ \
//           \____/_|\___/ \__,_|\__,_|_.__/ \__,_|___/\__\___|_|  |___/
//

import CloudKit
import CoreData
import Foundation

public class CloudKitManager {
    
    public static let objIdentifier: String = "GenericOBJ"
    public static let bookIndentifier: String = "Book"
    public static let serial: String = "Serialized_Object"
    
    fileprivate var container : CKContainer
    fileprivate var publicDB : CKDatabase
    fileprivate var privateDB : CKDatabase
    
    private init() {
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    public static var CKManagerSharedInstance: CloudKitManager = {
        return CloudKitManager.init()
    }()
    
    public func saveSerializable(item: FullSerializable) {
        let disProps = item.disassembleDic()
        let prop_values = disProps.1
        
        let record = CKRecord(recordType: CloudKitManager.serial)
        
        record.setValue(prop_values, forKey: "values")
        
        publicDB.save(record, completionHandler: { (record, error) -> Void in
            if let e = error {
                print(e)
            } else {
                print("Object stored succefully")
            }
        })
    }
    
    public func saveGeneric(g: Generics.Obj<String>) {
        
        let record = CKRecord(recordType: CloudKitManager.serial)
        
        record.setValue(g.value, forKey: "value")
        
        publicDB.save(record, completionHandler: { (record, error) -> Void in
            if let e = error{
                print(e)
            } else {
                print("Object stored succefully")
            }
        })
    }
    
    public func deleteRecordWithID(_ recordID: CKRecord.ID, completion: ((_ recordID: CKRecord.ID?, _ error: Error?) -> Void)?) {

        publicDB.delete(withRecordID: recordID) { (recordID, error) in
            completion?(recordID, error)
        }
    }

    public func deleteRecordsWithID(_ recordIDs: [CKRecord.ID], completion: ((_ records: [CKRecord]?, _ recordIDs: [CKRecord.ID]?, _ error: Error?) -> Void)?) {

        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: recordIDs)
        operation.savePolicy = .ifServerRecordUnchanged

        operation.modifyRecordsCompletionBlock = completion

        publicDB.add(operation)
    }
    
    public func retrieveStringGenerics(completition: @escaping ([Generics.Obj<String>], Error?) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: CloudKitManager.objIdentifier, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                print(error as Any)
            } else {
                var output : [Generics.Obj<String>] = []
                for record in results! {
                    let item = Generics.newObjectFromRecord(r: record)
                    output.append(item)
                }
                completition(output, error)
            }
        }
    }
    
    public func retrieveDoubleGenerics(completition: @escaping ([Generics.Obj<Double>], Error?) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: CloudKitManager.objIdentifier, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                print(error as Any)
            } else {
                var output : [Generics.Obj<Double>] = []
                for record in results! {
                    let item = Generics.new(n: (record.value(forKey: "value") as! String).__repr__())
                    output.append(item)
                }
                completition(output, error)
            }
        }
    }
    
    public func retrieveBooleanGenerics(completition: @escaping ([Generics.Obj<Bool>], Error?) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: CloudKitManager.objIdentifier, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                print(error as Any)
            } else {
                var output : [Generics.Obj<Bool>] = []
                for record in results! {
                    let item = Generics.new(b: (record.value(forKey: "value") as! String).__bool__())
                    output.append(item)
                }
                completition(output, error)
            }
        }
    }
    
    public func retrieveTrueGeneric<I: TrueGeneric, O: TrueGeneric>
        (types: types_<I, O>, completition: @escaping (types_<I, O>, [Generics.Obj<I>], Error?) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: CloudKitManager.objIdentifier, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                print(error as Any)
            } else {
                var output : [Generics.Obj<I>] = []
                for record in results! {
                    
                    let item: Generics.Obj<I>
                    
                    if I.__default__().__typ__() == Bool.self {
                        item = Generics.new(b: (record.value(forKey: "value") as! String).__bool__()) as! Generics.Obj<I>
                        output.append(item)
                    } else if I.__default__().__typ__() == String.self {
                        item = Generics.new(s: (record.value(forKey: "value") as! String).__str__()) as! Generics.Obj<I>
                        output.append(item)
                    } else {
                        item = Generics.new(n: (record.value(forKey: "value") as! String).__repr__()) as! Generics.Obj<I>
                        output.append(item)
                    }
                }
                completition((types.i, types.o), output, error)
            }
        }
    }
    

    
    public func __fetch__<I : TrueGeneric, O: TrueGeneric>(types: (I, O)) -> [Generics.Obj<O>] {
        
        var objs: [Generics.Obj<O>] = []
        
        self.retrieveTrueGeneric(types: (types), completition: {
            t, els, error  in
            if (error != nil){
                print(error!)
            } else {
                for el in els {
                    print(el.value.__str__())
                    let OB = Generics.new(i: el.value, o: t.o.__typ__() as! O.Type) //t.o.__typ__() as! O.Type
                    print(type(of: t.o))
                    objs.append(OB)
                }
            }
        })
        return objs
    }
}

public typealias types_<I, O> = (i: I, o: O)

