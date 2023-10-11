//
//  MakeUrl.swift
//  21-HW - HarryPotter-Alamofire
//
//  Created by 1234 on 11.10.2023.
//

import Foundation
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


