//
//  MyPageCore.swift
//  MyPageFeature
//
//  Created by 김지현 on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import CatFeature
import APIClientInterface
import UserServiceInterface
import CatServiceInterface
import UserDefaultsClientInterface

import ComposableArchitecture

@Reducer
public struct MyPageCore {
  @ObservableState
  public struct State: Equatable {
    public init() { }
    var cat: AnyCat? = nil
    var isTimerAlarmOn: Bool = false
    var isDisturbAlarmOn: Bool = false
    var isInternetConnected: Bool = false
    let feedbackURLString: String = "https://forms.gle/wEUPH9Tvxgua4hCZ9"
    @Presents var myCat: MyCatCore.State?
  }
  
  public enum Action: BindableAction {
    case onAppear
    case myCatDetailTapped
    case _responseUserInfo(UserDTO.Response.GetUserInfoResponseDTO)
    case myCat(PresentationAction<MyCatCore.Action>)
    case binding(BindingAction<State>)
  }

  @Dependency(APIClient.self) var apiClient
  @Dependency(UserService.self) var userService
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  let isTimerAlarmOnKey = "mohanyang_userdefaults_isTimerAlarmOnKey"
  let isDisturbAlarmOnKey = "mohanyang_userdefaults_isDisturmAlarmOnKey"

  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
      .ifLet(\.$myCat, action: \.myCat) {
        MyCatCore()
      }
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      state.isTimerAlarmOn = userDefaultsClient.boolForKey(isTimerAlarmOnKey)
      state.isDisturbAlarmOn = userDefaultsClient.boolForKey(isDisturbAlarmOnKey)
      return .run { send in
        let data = try await userService.getUserInfo(apiClient: apiClient)
        await send(._responseUserInfo(data))
      }

    case .myCatDetailTapped:
      guard let cat = state.cat else { return .none }
      state.myCat = MyCatCore.State(cat: cat)
      return .none

    case ._responseUserInfo(let data):
      state.cat = CatFactory.makeCat(
        type: CatType(rawValue: data.cat.type.camelCased()) ?? .cheese,
        no: data.cat.no,
        name: data.cat.name
      )
      return .none

    case .myCat:
      return .none

    case .binding(\.isTimerAlarmOn):
      return .run { [isTimerAlarmOn = state.isTimerAlarmOn] _ in
        await userDefaultsClient.setBool(isTimerAlarmOn, isTimerAlarmOnKey)
      }

    case .binding(\.isDisturbAlarmOn):
      return .run { [isDisturbAlarmOn = state.isDisturbAlarmOn] _ in
        await userDefaultsClient.setBool(isDisturbAlarmOn, isDisturbAlarmOnKey)
      }

    case .binding:
      return .none
    }
  }
}
