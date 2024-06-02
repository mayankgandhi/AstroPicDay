//
//  MemoryDataCache.swift
//
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation
import ComposableArchitecture

public protocol DataCache {
    func getData(for url: URL) -> Data?
    func setData(_ data: Data, for url: URL)
}

public class MemoryDataCache: DataCache {
    private var cache: [URL: Data] = [:]
    private let queue = DispatchQueue(label: "com.AstroPicDay.MemoryDataCache")

    public func getData(for url: URL) -> Data? {
        return queue.sync {
            return cache[url]
        }
    }

    public func setData(_ data: Data, for url: URL) {
        queue.async(flags: .barrier) {
            self.cache[url] = data
        }
    }
}

extension MemoryDataCache: DependencyKey {
    public static var liveValue: MemoryDataCache {
        MemoryDataCache()
    }
    
    public static var testValue: MemoryDataCache {
        MemoryDataCache()
    }
}

public extension DependencyValues {
    var memoryDataCache: MemoryDataCache {
        get { self[MemoryDataCache.self] }
        set { self[MemoryDataCache.self] = newValue }
    }
}
