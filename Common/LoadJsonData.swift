//
//  LoadJsonData.swift
//  Common
//
//  Created by Anderson F Carvalho on 18/08/23.
//

import Foundation

public class LoadJsonData {
    
    public static func loadJsonData(filename: String) ->  Data? {
        if let filePath = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            } catch {
                print("error:\(error)")
                return nil
            }
        }
        return nil
    }
    
    public static func loadJson<T>(filename fileName: String) -> T? where T: Decodable {
        if let data = loadJsonData(filename: fileName) {
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
                return nil
            }
        }
        return nil
    }
}
