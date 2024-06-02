//
//  NetworkFetcher.swift
//
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation
import Dependencies

protocol NetworkFetching {
    func fetchData(from url: URL) async throws -> Data
    func cancelFetch(for url: URL)
}

public class NetworkFetcher {
    
    private let session: URLSession
    var runningTasks: [URL: URLSessionDataTask] = [:]
    @Dependency(\.memoryDataCache) var cache
    
    private let queue = DispatchQueue(label: "com.AstroPicDay.NetworkFetcher")

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        self.session = URLSession(configuration: configuration)
    }

    public func fetchData(from url: URL) async throws -> Data {
        // Check if data is already in cache
        if let cachedData = cache.getData(for: url) {
            return cachedData
        }
        
        return try await _fetchData(from: url)
        
    }
    
    func _fetchData(from url: URL) async throws -> Data {
        let data = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Data, Error>) in
            let task = session.dataTask(with: url) { [weak self] data, _, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    self?.cache.setData(data, for: url)
                    continuation.resume(returning: data)
                }
            }
            queue.async(flags: .barrier) {
                self.runningTasks[url] = task
            }
            task.resume()
        }
        return data
    }


    public func cancelFetch(for url: URL) {
        runningTasks[url]?.cancel()
        runningTasks[url] = nil
    }
}

extension NetworkFetcher: DependencyKey {
    public static var liveValue: NetworkFetcher {
        NetworkFetcher()
    }
}

public extension DependencyValues {
    var networkFetcher: NetworkFetcher {
        get { self[NetworkFetcher.self] }
        set { self[NetworkFetcher.self] = newValue }
    }
}
