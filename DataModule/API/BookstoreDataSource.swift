//
//  BookstoreDataSource.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import UIKit

internal class BookstoreDataSource {
    
    public static let shared = BookstoreDataSource()
    private var token = CancelBag()
    private let url = "volumes?q=ios&maxResults=20&startIndex=%i"
    
    let URLDefault = APIStrings.baseUrl
    var apiCalling: APICalling!
    var apiRequest: APIRequest!
    
    public init(apiCalling: APICalling = APICalling(),
                apiRequest: APIRequest = APIRequest()) {
        self.apiCalling = apiCalling
        self.apiRequest = apiRequest
    }
        
    internal func booksFetch(urlString: String? = nil, _ page: Int, callBack: @escaping (Result<Bookstore, BookError>) -> Void) {
        
        let urlString = urlString ?? String(format: "\(URLDefault)\(url)", page)
        guard let url = URL(string: urlString),
                UIApplication.shared.canOpenURL(url) else {
            return callBack(.failure(BookError.URLError))
        }
        
        apiRequest.updateBaseURL(url)
        
        apiCalling.fetch(apiRequest: apiRequest) { response in
            callBack(response)
        }
    }
}
