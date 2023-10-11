//
//  APIFetch.swift
//  21-HW - HarryPotter-Alamofire
//
//  Created by 1234 on 08.10.2023.
//

import Foundation
import Alamofire

class APIFetchHandler {
    static let sharedInstance = APIFetchHandler()
    
    public func createURL(baseURL: String, path: String?, queryItems: [URLQueryItem]? = nil) -> URL? {
        // Проверяем, есть ли путь (path)
        if let path = path, !path.isEmpty {
            // Если путь существует и не пуст, создаем URL с полным путем
            var components = URLComponents(string: baseURL)
            components?.path = path
            components?.queryItems = queryItems
            return components?.url
        } else {
            // Если путь отсутствует или пуст, используем базовый URL
            return URL(string: baseURL)
        }
    }


    
    func fetchAPIData(queryItemValue: String?, handler: @escaping (([Characters]) -> Void)) {
        let baseURL = "https://hp-api.onrender.com"
        let urlPath = "/api/characters"
        let queryItem = [URLQueryItem(name: ":id", value: queryItemValue)]

        let urlRequest = createURL(baseURL: baseURL, path: urlPath, queryItems: queryItem)

        guard let url = urlRequest else {return}
        
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
        .response{ resp in
            switch resp.result{
              case .success(let data):
                do{
                    if let data = data {
                        let jsonData = try JSONDecoder().decode([Characters].self, from: data)
                      handler(jsonData)
                    }
                    
               } catch {
                  print(error.localizedDescription)
               }
             case .failure(let error):
               print(error.localizedDescription)
             }
        }
   }
}
