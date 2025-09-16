//
//  ContentView.swift
//  ConcurrencySandbox
//
//  Created by Quoc Dat Nguyen on 16/9/25.
//

import SwiftUI
import AsyncAlgorithms

struct ContentView: View {

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onFirstAppear {
            print("Before Task \(currentThreadID())") // 4203546, main thread
            Task {
                // If we run `Task.detached` instead, we'll get a different thread here.
                // However, we'll be back on main after entering `runAsyncCode`, as it is not
                // `nonisolated` and `View` is `@MainActor`.
                print("Before runAsyncCode \(currentThreadID())") // 4203546, main thread
                await runAsyncCode()
            }
        }
    }

    func runAsyncCode() async {
        // This is not `nonisolated` so it is still on main thread
//        print("Before printThreadIDBeforeAndAfterAwait \(currentThreadID())") // 4203546, main thread
//        await printThreadIDBeforeAndAfterAwait()

//        try? await loopThroughAsyncSequence()

        try? await callAsyncLet()
    }

    nonisolated func printThreadIDBeforeAndAfterAwait() async {
        print("Before sleep \(currentThreadID())") // 4203879
        try? await Task.sleep(for: .seconds(2))
        print("After sleep \(currentThreadID())") // 4203888
    }

    nonisolated func currentThreadID() -> UInt64 {
        var tid: UInt64 = 0
        pthread_threadid_np(nil, &tid)
        return tid
    }

    func loopThroughAsyncSequence() async throws {
        let asyncSequence = [0,1,2,3,4].async

        for try await number in asyncSequence {
            // Main thread
            // 0 4255077
            // 1 4255077
            // 2 4255077
            // 3 4255077
            // 4 4255077
            // Even if we mark this function as `nonisolated`, it still runs all iterations on the
            // same thread.
            print("\(number) \(currentThreadID())")
        }
    }

    // This should be nonisolated otherwise everything is on main thread
    nonisolated func callAsyncLet() async throws {
        async let secondsSlept1 = asyncSleepFunction()
        async let secondsSlept2 = asyncSleepFunction()
        async let secondsSlept3 = asyncSleepFunction()

        // Calling `asyncSleepFunction` triggers one of the three on the same thread, and the other
        // 2 on different threads.
        // One of the three threads ends on the same thread as the post-await thread.
        print("Before awaiting for results \(currentThreadID())") // 4277128
        let results = try await [secondsSlept1, secondsSlept2, secondsSlept3] // 4277141, 4277149, 4277128
        print("After awaiting for results \(currentThreadID())") // 4277141
        print(results)
    }

    // This should be nonisolated otherwise everything is on main thread
    nonisolated func asyncSleepFunction() async throws -> Int {
        let secondsToSleep = Int.random(in: 1...3)
        print("Before sleeping for \(secondsToSleep) seconds... \(currentThreadID())")
        try await Task.sleep(for: .seconds(secondsToSleep))
        print("After sleeping for \(secondsToSleep) seconds... \(currentThreadID())")
        return secondsToSleep
    }
}

#Preview {
    ContentView()
}
