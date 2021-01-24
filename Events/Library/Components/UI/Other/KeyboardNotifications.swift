//
//  KeyboardNotifications.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import UIKit

protocol KeyboardNotificationsDelegate: class {
    func keyboardWillShow(notification: NSNotification)
    func keyboardWillHide(notification: NSNotification)
    func keyboardDidShow(notification: NSNotification)
    func keyboardDidHide(notification: NSNotification)
}

extension KeyboardNotificationsDelegate {
    func keyboardWillShow(notification: NSNotification) {}
    func keyboardWillHide(notification: NSNotification) {}
    func keyboardDidShow(notification: NSNotification) {}
    func keyboardDidHide(notification: NSNotification) {}
}

class KeyboardNotifications {

    fileprivate var _isEnabled: Bool
    fileprivate var notifications: [KeyboardNotificationsType]
    fileprivate weak var delegate: KeyboardNotificationsDelegate?

    init(notifications: [KeyboardNotificationsType], delegate: KeyboardNotificationsDelegate) {
        _isEnabled = false
        self.notifications = notifications
        self.delegate = delegate
    }

    deinit { if isEnabled { isEnabled = false } }
}

// MARK: - enums

extension KeyboardNotifications {

    enum KeyboardNotificationsType {
        case willShow, willHide, didShow, didHide

        var selector: Selector {
            switch self {
            case .willShow: return #selector(keyboardWillShow(notification:))
            case .willHide: return #selector(keyboardWillHide(notification:))
            case .didShow: return #selector(keyboardDidShow(notification:))
            case .didHide: return #selector(keyboardDidHide(notification:))
            }
        }

        var notificationName: NSNotification.Name {
            switch self {
            case .willShow: return UIResponder.keyboardWillShowNotification
            case .willHide: return UIResponder.keyboardWillHideNotification
            case .didShow: return UIResponder.keyboardDidShowNotification
            case .didHide: return UIResponder.keyboardDidHideNotification
            }
        }
    }
}

// MARK: - isEnabled

extension KeyboardNotifications {

    private func addObserver(type: KeyboardNotificationsType) {
        NotificationCenter.default.addObserver(self, selector: type.selector, name: type.notificationName, object: nil)
    }

    var isEnabled: Bool {
        get { return _isEnabled }
        set {
            if newValue {
                for notificaton in notifications { addObserver(type: notificaton) }
            } else {
                NotificationCenter.default.removeObserver(self)
            }
            _isEnabled = newValue
        }
    }
}

// MARK: - Notification functions

extension KeyboardNotifications {

    @objc func keyboardWillShow(notification: NSNotification) {
        delegate?.keyboardWillShow(notification: notification)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        delegate?.keyboardWillHide(notification: notification)
    }

    @objc func keyboardDidShow(notification: NSNotification) {
        delegate?.keyboardDidShow(notification: notification)
    }

    @objc func keyboardDidHide(notification: NSNotification) {
        delegate?.keyboardDidHide(notification: notification)
    }
}
