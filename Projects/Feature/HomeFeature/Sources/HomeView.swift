//
//  HomeView.swift
//  HomeFeatureInterface
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct HomeView: View {
  @Bindable var store: StoreOf<HomeCore>
  
  public init(store: StoreOf<HomeCore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      NavigationContainer(
        leading: {
          Spacer()
        },
        trailing: {
          Button(
            icon: Image(systemName: "right"),
            action: {
              store.send(.mypageButtonTappd)
            }
          )
          .buttonStyle(.icon(isFilled: false, level: .primary))
        },
        style: .navigation
      ) {
        VStack(spacing: 40) {
          VStack(spacing: Alias.Spacing.xLarge) {
            Rectangle()
              .fill(Alias.Color.Background.secondary)
              .frame(width: 240, height: 240)
              .setTooltipTarget(tooltip: HomeCatDialogueTooltip.self)
            Text("치즈냥")
              .font(Typography.header4)
              .foregroundStyle(Alias.Color.Text.tertiary)
          }
          VStack(spacing: Alias.Spacing.medium) {
            Button(
              title: "\("기본")",
              leftIcon: Image(systemName: "left"),
              action: {
                store.send(.categoryButtonTapped)
              }
            )
            .buttonStyle(.box(level: .tertiary, size: .small))
            HStack(spacing: Alias.Spacing.medium) {
              HStack(spacing: Alias.Spacing.small) {
                Text("집중")
                  .font(Typography.bodySB)
                  .foregroundStyle(Global.Color.gray500)
                Text("\(0)분")
                  .font(Typography.header3)
                  .foregroundStyle(Alias.Color.Text.secondary)
              }
              .padding(Alias.Spacing.small)
              
              Rectangle()
                .fill(Global.Color.gray200)
                .frame(width: 2, height: Global.Dimension._20f)
              
              HStack(spacing: Alias.Spacing.small) {
                Text("휴식")
                  .font(Typography.bodySB)
                  .foregroundStyle(Global.Color.gray500)
                Text("\(0)분")
                  .font(Typography.header3)
                  .foregroundStyle(Alias.Color.Text.secondary)
              }
              .padding(Alias.Spacing.small)
            }
          }
          Button(
            icon: DesignSystemAsset.Image._32PlayPrimary.swiftUIImage,
            action: {
              store.send(.playButtonTapped)
            }
          )
          .buttonStyle(.round(level: .primary))
        }
      }
    }
    .background(Global.Color.gray50)
    .tooltipDestination(tooltip: $store.homeCatTooltip.sending(\.setHomeCatTooltip))
    .bottomSheet(
      item: $store.scope(
        state: \.categorySelect,
        action: \.categorySelect
      )
    ) { store in
      CategorySelectView(store: store)
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
