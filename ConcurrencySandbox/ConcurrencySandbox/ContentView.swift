//
//  ContentView.swift
//  ConcurrencySandbox
//
//  Created by Quoc Dat Nguyen on 16/9/25.
//

import SwiftUI

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
                // However, we'll be back on main after entering `runAsyncCode`, as it is not `nonisolated`
                // and `View` is `@MainActor`.
                print("Before runAsyncCode \(currentThreadID())") // 4203546, main thread
                await runAsyncCode()
            }
        }
    }

    func runAsyncCode() async {
        // This is not `nonisolated` so it is still on main thread
//        print("Before printThreadIDBeforeAndAfterAwait \(currentThreadID())") // 4203546, main thread
//        await printThreadIDBeforeAndAfterAwait()

        try? await loopThroughAsyncSequence()
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
        let handle = FileHandle.standardInput

        for try await line in handle.bytes.lines {
            print(line)
        }
    }
}

#Preview {
    ContentView()
}
