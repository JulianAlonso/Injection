import Foundation

func delay(_ time: DispatchTimeInterval, on queue: DispatchQueue = DispatchQueue.main, _ work: @escaping () -> Void) {
    DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + time) {
        queue.async { work() }
    }
}
