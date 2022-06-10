//
//  FormState.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

final class FormState<T>: ObservableObject {
    var state: State

    enum State {
        case error(Error = AppError.development)
        case loading
        case warning(Error = AppError.development)
        case idle
        case success(data: T)
    }

    var showError: Bool {
        get {
            if case .error = state {
                return true
            } else {
                return false
            }
        }
        set {
            state = newValue ? .error() : .idle
        }
    }

    var showWarning: Bool {
        get {
            if case .warning = state {
                return true
            } else {
                return false
            }
        }
        set {
            state = newValue ? .warning() : .idle
        }
    }

    var showLoading: Bool {
        get {
            if case .loading = state {
                return true
            } else {
                return false
            }
        }
        set {
            state = newValue ? .loading : .idle
        }
    }

    var showSuccess: Bool {
        get {
            if case .success = state {
                return true
            } else {
                return false
            }
        }
        set {
            if !newValue {
                state = .idle
            }
        }
    }

    var result: ((Result<T, Error>) -> Void)?

    var cancellables = Set<AnyCancellable>()

    init(
        state: State = .idle,
        result:((Result<T, Error>) -> Void)? = nil
    ) {
        self.state = state
        self.result = result
        self.objectWillChange.onValue { [weak self] in
            guard let self = self else { return }
            switch self.state {
            case let .error(error):
                self.result?(.failure(error))
            case .loading: break
            case .warning: break
            case .idle: break
            case .success(data: let data):
                self.result?(.success(data))
            }
        }.store(in: &cancellables)
    }

    var errorText: String? {
        guard case let .error(error) = state else {
            return nil
        }
        return error.localizedDescription
    }

    var warningText: String? {
        guard case let .warning(error) = state else {
            return nil
        }
        return error.localizedDescription
    }

    func result(_ onValue:((T) -> Void)? = nil) -> Self {
        self.result = { result in
            switch result {
            case let .success(value):
               onValue?(value)
            case .failure: break
            }
        }
        return self
    }
}


import Combine

extension FormState {
    var statePublisher: AnyPublisher<FormState, Error> {
        objectWillChange.tryMap { [weak self] in
            guard let self = self else { throw AppError.arc }
            return self
        }
        .eraseToAnyPublisher()
    }
}

extension FormState {
    func onError(error: Error) {
        state = .error(error)
        objectWillChange.send()
    }

    func onWarning(error: Error) {
        state = .warning(error)
        objectWillChange.send()
    }

    func onLoading() {
        state = .loading
        objectWillChange.send()
    }

    func onSuccess(data: T) {
        state = .success(data: data)
        objectWillChange.send()
    }

    func onReady() {
        state = .idle
        objectWillChange.send()
    }
}

import SwiftUI

extension FormState {

    var errorView: some View {
        errorText.flatMap {
            Text($0)
                .foregroundColor(Color.red)
                .padding([.top, .bottom], 16)
        }
    }

    var warningView: some View {
        warningText.flatMap {
            Text($0)
                .foregroundColor(Color.yellow)
                .padding([.top, .bottom], 16)
        }
    }
}
