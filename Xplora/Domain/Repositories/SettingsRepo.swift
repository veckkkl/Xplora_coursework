//
//  SettingsRepo.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

protocol SettingsRepo {
    func loadSettings() async throws -> UserSettings
    func saveSettings(_ settings: UserSettings) async throws
}
