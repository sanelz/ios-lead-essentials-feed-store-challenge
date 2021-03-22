//
//  InMemoryFeedStore.swift
//  FeedStoreChallenge
//
//  Created by mbp01 on 2021. 03. 22..
//  Copyright © 2021. Essential Developer. All rights reserved.
//

import Foundation

public final class InMemoryFeedStore: FeedStore {

	private struct Cache {
		let feed: [LocalFeedImage]
		let timestamp: Date
	}

	private var inMemoryCache: Cache?

	public init() {}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		deleteCache()
		completion(nil)
	}

	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		inMemoryCache = Cache(feed: feed, timestamp: timestamp)
		completion(nil)
	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		if let cache = inMemoryCache {
			completion(.found(feed: cache.feed, timestamp: cache.timestamp))
		} else {
			completion(.empty)
		}
	}

	// MARK: - Helpers

	private func deleteCache() {
		inMemoryCache = nil
	}
}
