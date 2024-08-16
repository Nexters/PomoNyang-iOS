//
//  UserAPIRequest.swift
//  UserService
//
//  Created by 김지현 on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import APIClientInterface

public enum UserAPIrequest {
  case fetchCatList, selectCat(Int)
}

extension UserAPIrequest: APIBaseRequest {
  public var baseURL: String {
    return API.apiBaseURL
  }

  public var path: String {
    switch self {
    case .fetchCatList:
      return "/api/v1/cats"
    case .selectCat:
      return "/api/v1/users/cats"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .fetchCatList:
      return .get
    case .selectCat:
      return .put
    }
  }

  public var parameters: RequestParams {
    switch self {
    case .fetchCatList:
      return .requestPlain
    case .selectCat(let no):
      let dto = UserDTO.Request.SelectCatRequestDTO(catNo: no)
      return .body(dto)
    }
  }
}
