//
//  MIELAPPUITests.swift
//  MIELAPPUITests
//
//  Created by Irina on 12/7/25.
//

import XCTest
import XCTest

final class MIELAPPUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    // 1. Проверка загрузки главного экрана и списка кандидатов
    func testCandidateListLoads() throws {
        // Проверяем, что заголовок "Витрина кандидатов" есть
        let title = app.staticTexts["Витрина кандидатов"]
        XCTAssertTrue(title.waitForExistence(timeout: 10))

        // Проверяем, что хотя бы одна ячейка кандидата появилась
        let candidateCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(candidateCell.waitForExistence(timeout: 10))
    }

    // 2. Проверка отправки приглашения кандидату
    func testSendInviteToCandidate() throws {
        // Ждем появления ячеек кандидатов
        let firstCandidate = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCandidate.waitForExistence(timeout: 10))

        // Находим кнопку "Пригласить" в первой ячейке
        let inviteButton = firstCandidate.buttons["Пригласить"]
        XCTAssertTrue(inviteButton.exists)

        // Нажимаем "Пригласить"
        inviteButton.tap()

        // Проверяем, что появилось уведомление об успешной отправке
        let successAlert = app.alerts["Успех"]
        XCTAssertTrue(successAlert.waitForExistence(timeout: 5))
    }

    // 3. Проверка авторизации (если она реализована)
    func testAuthAndCandidateList() throws {
        // Если есть экран логина
        let loginField = app.textFields["Логин"]
        let passwordField = app.secureTextFields["Пароль"]
        let loginButton = app.buttons["Войти"]

        if loginField.exists {
            loginField.tap()
            loginField.typeText("supervisor")
            passwordField.tap()
            passwordField.typeText("supervisor")
            loginButton.tap()
        }

        // Проверяем, что после входа загрузился список кандидатов
        let candidateCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(candidateCell.waitForExistence(timeout: 10))
    }
}
