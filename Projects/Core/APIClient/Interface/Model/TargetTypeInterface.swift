//
//  TargetTypeInterface.swift
//  APIClientInterface
//
//  Created by 김지현 on 7/23/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import Dependencies

public protocol TargetType {
  var baseURL: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: RequestParams { get }
  var contentType: ContentType { get }
}

public enum API {
  public static var apiBaseURL: String {
    guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else { fatalError("url missing") }
    return "https://" + baseURL
  }
}

public enum HTTPHeaderField: String {
  case authentication = "Authorization"
  case contentType = "Content-Type"
  case acceptType = "Accept"
}

public enum ContentType: String {
  case json = "application/json"
  case image = "image/jpeg"
}

public enum RequestParams {
  case requestPlain
  case query(_ parameter: Encodable)
  case body(_ parameter: Encodable)
}

public extension TargetType {
  var contentType: ContentType {
    return .json
  }
}
