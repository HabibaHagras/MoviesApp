//
//  DbManager.swift
//  lab1day2swift
//
//  Created by habiba on 4/28/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
import SQLite3
class DbManager{
    static let shared = DbManager() 
    var db:OpaquePointer?
    let path:String? = "database.sqlite"
    
    
    private init() {
        self.db = opendatabase()
        self.createTabel()
    }
    deinit {
      sqlite3_close(db)
    }
    
    
    func opendatabase() -> OpaquePointer? {
        var db: OpaquePointer?
        let filepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = filepath.appendingPathComponent(path!)

        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            print("Success")
            return db
        } else {
            print("Opening database failed")
            return nil
        }
    }

    func createTabel(){
        let statement_create = """
        CREATE TABLE IF NOT EXISTS Movies (
            name TEXT,
            rating REAL,
            genre TEXT,
            releaseYear INTEGER,
            img BLOB
        );
        """
    
        
        
        var createTableStatement: OpaquePointer?
        guard sqlite3_prepare_v2(self.db, statement_create, -1, &createTableStatement, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error preparing create table: \(errmsg)")
            return
        }

        if sqlite3_step(createTableStatement) == SQLITE_DONE {
            print("Table created successfully")
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error creating table: \(errmsg)")
        }

        sqlite3_finalize(createTableStatement)
    }
    func retrieveData() -> [Movie] {
        var result: [Movie] = []
        let query = "SELECT * FROM Movies;"
        var queryStatement: OpaquePointer?
        
        guard sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error preparing select: \(errmsg)")
            return result
        }
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            let name = String(cString: sqlite3_column_text(queryStatement, 0))
            let rating = sqlite3_column_double(queryStatement, 1)
            let genreString = String(cString: sqlite3_column_text(queryStatement, 2))
            let genre = genreString.components(separatedBy: ", ")
            let releaseYear = sqlite3_column_int(queryStatement, 3)
            let img = Data(bytes: sqlite3_column_blob(queryStatement, 4), count: Int(sqlite3_column_bytes(queryStatement, 4)))
            let movie = Movie(name: name, img: img, rating: Float(rating), genre: genre, relaseint: Int(releaseYear))
            result.append(movie)
        }
        
        sqlite3_finalize(queryStatement)
        return result
    }
    
    
    
   func insertMovie(name: String, rating: Double, genre: [String], releaseYear: Int , img: Data) {
        let insertStatementString = "INSERT INTO Movies (name, rating, genre, releaseYear, img) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer?
        
        guard sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error preparing insert: \(errmsg)")
            return
        }
        
        let genreString = genre.joined(separator: ", ")
        
        sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
        sqlite3_bind_double(insertStatement, 2, rating)
        sqlite3_bind_text(insertStatement, 3, (genreString as NSString).utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 4, Int32(releaseYear))
           sqlite3_bind_blob(insertStatement, 5, (img as NSData).bytes, Int32(img.count), nil)

        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error inserting movie: \(errmsg)")
            return
        }
        
        print("Movie inserted successfully.")
        sqlite3_finalize(insertStatement)
    }

    
    func deleteMovie(name: String) {
        let deleteStatementString = "DELETE FROM Movies WHERE name = ?;"
        var deleteStatement: OpaquePointer?
        
        guard sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error preparing delete statement: \(errmsg)")
            return
        }
        
        sqlite3_bind_text(deleteStatement, 1, (name as NSString).utf8String, -1, nil)
        
        guard sqlite3_step(deleteStatement) == SQLITE_DONE else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error deleting movie: \(errmsg)")
            return
        }
        
        print("Movie deleted successfully.")
        sqlite3_finalize(deleteStatement)
    }

 

    
}
