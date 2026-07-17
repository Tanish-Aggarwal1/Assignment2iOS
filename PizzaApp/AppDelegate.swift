//
//  AppDelegate.swift
//  PizzaApp
//
//  Created by Tanish Aggarwal on 2026-07-14.
//

import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // variables for database
        var window: UIWindow?
        var databaseName: String? = "PizzaDB.sqlite"
        var databasePath: String?
        var orders: [Order] = []
        var selectedOrder: Order? = nil

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // setup the path for where db file will be accessed from
                // want to use ~/Documents folder on phone
                let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let documentsDir = documentPaths[0]
                databasePath = documentsDir.appending("/" + databaseName!)
                
                checkAndCreateDatabase()
                readDataFromDatabase()
                
                return true
            }
            
            // check if db already on phone; if not, copy from app bundle
            func checkAndCreateDatabase() {
                var success = false
                let fileManager = FileManager.default
                
                success = fileManager.fileExists(atPath: databasePath!)
                
                if success {
                    return
                }
                
                let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
                
                try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
                
                return
            }
            
            // read all rows from Orders table into self.orders
            func readDataFromDatabase() {
                orders.removeAll()
                
                var db: OpaquePointer? = nil
                
                if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
                    print("Successfully opened connection to database at \(self.databasePath!)")
                    
                    var queryStatement: OpaquePointer? = nil
                    let queryStatementString: String = "select * from Orders"
                    
                    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                        
                        // loop through each row
                        while sqlite3_step(queryStatement) == SQLITE_ROW {
                            // col 0 = ID, 1 = DeliveryDate, 2 = Address, 3 = Size,
                            // 4 = MeatToppings, 5 = VegToppings, 6 = Avatar
                            let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                            let cDeliveryDate = sqlite3_column_text(queryStatement, 1)
                            let cAddress = sqlite3_column_text(queryStatement, 2)
                            let size: Int = Int(sqlite3_column_int(queryStatement, 3))
                            let cMeat = sqlite3_column_text(queryStatement, 4)
                            let cVeg = sqlite3_column_text(queryStatement, 5)
                            let cAvatar = sqlite3_column_text(queryStatement, 6)
                            
                            let deliveryDate = String(cString: cDeliveryDate!)
                            let address = String(cString: cAddress!)
                            let meatToppings = String(cString: cMeat!)
                            let vegToppings = String(cString: cVeg!)
                            let avatar = String(cString: cAvatar!)
                            
                            let order: Order = Order.init()
                            order.initWithData(theRow: id, theDeliveryDate: deliveryDate,
                                               theAddress: address, theSize: size,
                                               theMeatToppings: meatToppings,
                                               theVegToppings: vegToppings, theAvatar: avatar)
                            orders.append(order)
                            
                            print("Query Result:")
                            print("\(id) | \(deliveryDate) | \(address) | \(size) | \(meatToppings) | \(vegToppings) | \(avatar)")
                        }
                        sqlite3_finalize(queryStatement)
                    } else {
                        print("SELECT statement could not be prepared")
                    }
                    
                    sqlite3_close(db)
                } else {
                    print("Unable to open database.")
                }
            }
            
            // insert a new Order row - returns true on success
            func insertIntoDatabase(order: Order) -> Bool {
                var db: OpaquePointer? = nil
                var returnCode: Bool = true
                
                if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
                    print("Successfully opened connection to database at \(self.databasePath!)")
                    
                    var insertStatement: OpaquePointer? = nil
                    let insertStatementString: String = "insert into Orders values(NULL, ?, ?, ?, ?, ?, ?)"
                    
                    if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                        
                        // must cast to NSString for utf8String conversion
                        let deliveryDateStr = order.deliveryDate! as NSString
                        let addressStr = order.address! as NSString
                        let meatStr = order.meatToppings! as NSString
                        let vegStr = order.vegToppings! as NSString
                        let avatarStr = order.avatar! as NSString
                        
                        sqlite3_bind_text(insertStatement, 1, deliveryDateStr.utf8String, -1, nil)
                        sqlite3_bind_text(insertStatement, 2, addressStr.utf8String, -1, nil)
                        sqlite3_bind_int (insertStatement, 3, Int32(order.size!))
                        sqlite3_bind_text(insertStatement, 4, meatStr.utf8String, -1, nil)
                        sqlite3_bind_text(insertStatement, 5, vegStr.utf8String, -1, nil)
                        sqlite3_bind_text(insertStatement, 6, avatarStr.utf8String, -1, nil)
                        
                        if sqlite3_step(insertStatement) == SQLITE_DONE {
                            let rowID = sqlite3_last_insert_rowid(db)
                            print("Successfully inserted row. \(rowID)")
                        } else {
                            print("Could not insert row.")
                            returnCode = false
                        }
                        sqlite3_finalize(insertStatement)
                    } else {
                        print("INSERT statement could not be prepared.")
                        returnCode = false
                    }
                    
                    sqlite3_close(db)
                } else {
                    print("Unable to open database.")
                    returnCode = false
                }
                return returnCode
            }
    
    // delete an existing Order row by its ID - same pattern as insertIntoDatabase
    func deleteOrder(order: Order) -> Bool {
        var db: OpaquePointer? = nil
        var returnCode: Bool = true
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(self.databasePath!)")
            
            var deleteStatement: OpaquePointer? = nil
            let deleteStatementString: String = "delete from Orders where ID = ?"
            
            if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
                
                // bind the ID of the order we want to remove
                sqlite3_bind_int(deleteStatement, 1, Int32(order.id ?? 0))
                
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Successfully deleted order with ID \(order.id ?? 0)")
                } else {
                    print("Could not delete order.")
                    returnCode = false
                }
                sqlite3_finalize(deleteStatement)
            } else {
                print("DELETE statement could not be prepared.")
                returnCode = false
            }
            
            sqlite3_close(db)
        } else {
            print("Unable to open database.")
            returnCode = false
        }
        return returnCode
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

