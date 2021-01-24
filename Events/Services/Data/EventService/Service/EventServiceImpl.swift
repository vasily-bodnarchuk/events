//
//  EventServiceImpl.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import Foundation

class EventServiceImpl {
    private weak var dbService: DBService!
    let eventId: Int

    init(eventId: Int, dbService: DBService) {
        self.eventId = eventId
        self.dbService = dbService
    }
}

extension EventServiceImpl: EventService {
    var isFavorite: Bool {
        get { false }
        set (value) {
            dbService.action(value: .favoritedEvents(action: .update(completion: { [weak self] currentValue in
                guard let self = self else { return }
                if currentValue == nil {
                    currentValue = value ? [self.eventId] : []
                } else {
                    if value {
                        currentValue?.append(self.eventId)
                        currentValue?.sort()
                    } else {
                        guard let index = currentValue?.firstIndex(of: self.eventId) else { return }
                        currentValue?.remove(at: index)
                    }
                }
            })))
        }
    }
}
