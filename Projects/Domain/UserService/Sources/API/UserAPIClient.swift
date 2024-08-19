//
//  UserAPIClient.swift
//  UserService
//
//  Created by 김지현 on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import APIClientInterface
import UserServiceInterface

import Dependencies

extension UserService: DependencyKey {
  public static let liveValue: UserService = .live()
  private static func live() -> Self {
    return UserService(
      selectCat: { no, apiClient in
        let request = UserAPIrequest.selectCat(no)
        _ = try await apiClient.apiRequest(
          request: request,
          as: EmptyResponse.self
        )
        return
      },

      getUserInfo: { apiClient in
        let request = UserAPIrequest.getUserInfo
        return try await apiClient.apiRequest(
          request: request,
          as: UserDTO.Response.GetUserInfoResponseDTO.self
        )
      }
    )
  }
}
