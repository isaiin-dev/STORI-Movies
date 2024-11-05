//
//  Defaults.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//

import Foundation

class Defaults {
    static let shared = Defaults()

    private let userDefaults = UserDefaults(suiteName: "UtilityDefaults")

    enum UserDefaultsKeys: String, CaseIterable {
        case connectedToInterntet = "CONNECTED_TO_INTERNET"
    }

    private init() {}

    func setValue<T>(value: T, forKey key: UserDefaultsKeys) {
        userDefaults?.setValue(value, forKey: key.rawValue)
    }

    func getValue(forKey key: UserDefaultsKeys) -> Any? {
        return userDefaults?.value(forKey: key.rawValue)
    }


    func clearOnboardingData() {
        for key in UserDefaultsKeys.allCases {
            userDefaults?.removeObject(forKey: key.rawValue)
        }
    }
}
