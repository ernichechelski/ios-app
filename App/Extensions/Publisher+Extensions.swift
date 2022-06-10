//
//  Publisher+Extensions.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI
import Combine

extension Publisher {

    /// - Returns: A publisher that performs actions on the form state when publisher events occur.
    func handleState<T>(formState: FormState<T>, skipping: FormState<T>.State? = nil) -> Publishers.HandleEvents<Self> where T == Self.Output {
        handleEvents(
            receiveOutput: { [weak formState] data in
                if case .idle = skipping {
                    return
                }
                formState?.onSuccess(data: data)
            },
            receiveCompletion: { [weak formState] completion in
                switch completion {
                case let .failure(error):
                    if case .error = skipping {
                        formState?.onReady()
                    } else {
                        formState?.onError(error: error)
                    }
                case .finished: break
                }
            },
            receiveCancel: { [weak formState] in
                formState?.onReady()
            },
            receiveRequest: { [weak formState] _ in
                if case .loading = skipping {
                    return
                }
                formState?.onLoading()
            }
        )
    }

    /// - Returns: A publisher that performs actions on the form state when publisher events occur.
    func handleResult<T>(result: @escaping ((Result<Self.Output, Self.Failure>) -> Void)) -> Publishers.HandleEvents<Self> where T == Self.Output {
        handleEvents(
            receiveOutput: { data in
                result(.success(data))
            },
            receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    result(.failure(error))
                case .finished: break
                }
            }
        )
    }

    func sink<T>(cancellables: inout Set<AnyCancellable>) -> FormState<T> where T == Self.Output {
        with(FormState()) {
            self
                .handleState(formState: $0)
                .sink()
                .store(in: &cancellables)
        }
    }

    func sink<T>(
        cancellables: inout Set<AnyCancellable>,
        result: @escaping ((Result<Self.Output, Self.Failure>) -> Void)
    ) -> FormState<T> where T == Self.Output {
        with(FormState()) {
            self
                .handleState(formState: $0)
                .sink(result: result)
                .store(in: &cancellables)
        }
    }


    /// - Returns:  A single value sink function that coalesces either one `Output` or one `Failure` as a `Result`-type.
    func sink(result: @escaping ((Result<Self.Output, Self.Failure>) -> Void)) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            case .finished:
                break
            }
        }, receiveValue: { output in
            result(.success(output))
        })
    }

    /// - Returns:  A single cancellable empty sink function.
    func sink() -> AnyCancellable {
        sink(result: { _ in })
    }

    func sink(_ onEnd: (() -> Void)?) -> AnyCancellable {
        sink(result: { _ in
            onEnd?()
        })
    }

    /// - Returns:  A single cancellable sink function which passes results.
    func sink(to: PassthroughSubject<Output, Failure>) -> AnyCancellable {
        sink { [weak to] result in
            switch result {
            case let .success(value): to?.send(value)
            case let .failure(error): to?.send(completion: .failure(error))
            }
        }
    }

    /// - Returns:  A single cancellable sink function which passes results.
    func subscribe(to: PassthroughSubject<Output, Failure>) -> AnyCancellable {
        handleEvents { [weak to] subscribtion in
            to?.send(subscription: subscribtion)
        }.sink()
    }

    /// - Returns:  A single cancellable only with receiveCompletion sink function.
    func onCompletion(completion: @escaping (Subscribers.Completion<Self.Failure>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: { output in
            completion(output)
        }, receiveValue: { _ in }
        )
    }

    /// - Returns:  A single cancellable only with receiveValue sink function.
    func onValue(completion: @escaping (Self.Output) -> Void) -> AnyCancellable {
        sink(receiveCompletion: { _ in
        }, receiveValue: { output in
            completion(output)
        })
    }

    /// - Returns:  A single cancellable only with receive sink function. Use then you don't care about value
    func onValue(completion: @escaping () -> Void) -> AnyCancellable {
        sink(receiveCompletion: { _ in
        }, receiveValue: { _ in
            completion()
        })
    }

    /// - Returns: Selected modified published based on condition
    /// Example usage (using different form state based on condition):
    /// ```
    /// .onConditional(
    ///     condition: byPullToRefresh,
    ///     onTrue: {
    ///         $0.handleStateAnimated(
    ///             formState: self.pullToRefreshFormState,
    ///             parents: [self.objectWillChange]
    ///         ).eraseToAnyPublisher()
    ///     },
    ///     onFalse: {
    ///         $0.handleState(
    ///             formState: self.formState,
    ///             parents: [self.objectWillChange]
    ///         ).eraseToAnyPublisher()
    ///     }
    /// )
    /// ```
    func onConditional(
        condition: Bool,
        onTrue: @escaping (Self) -> AnyPublisher<Self.Output, Self.Failure>,
        onFalse: @escaping (Self) -> AnyPublisher<Self.Output, Self.Failure>
    ) -> AnyPublisher<Self.Output, Self.Failure> {
        condition ? onTrue(self) : onFalse(self)
    }

    /// Allows flatMapping with throwing closure.
    func tryFlatMap<Pub: Publisher>(
        maxPublishers: Subscribers.Demand = .unlimited,
        _ transform: @escaping (Output) throws -> Pub
    ) -> Publishers.FlatMap<AnyPublisher<Pub.Output, Error>, Self> {
        flatMap(maxPublishers: maxPublishers) { input -> AnyPublisher<Pub.Output, Error> in
            do {
                return try transform(input)
                    .mapError { $0 as Error }
                    .eraseToAnyPublisher()
            } catch {
                return Fail(outputType: Pub.Output.self, failure: error)
                    .eraseToAnyPublisher()
            }
        }
    }
}

extension AnyPublisher {
    /// Just convenient creation of publishers from static value.
    static func stub<Value: Any, MethodError: Error>(value: Value) -> AnyPublisher<Value, MethodError> {
        Just(value)
            .setFailureType(to: MethodError.self)
            .eraseToAnyPublisher()
    }
}

extension Publisher where Self.Failure == Never, Self.Output == Void {
    func sink(to publisher: ObservableObjectPublisher) -> AnyCancellable {
        sink { [weak publisher] _ in
            publisher?.send()
        }
    }
}
