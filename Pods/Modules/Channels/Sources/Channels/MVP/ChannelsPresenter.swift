//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/22/20
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation
import ChannelReactor
import ChannelStorage
import TeleGuideModel
import ErrorPresenter
import ActivityPresenter

final class ChannelsPresenter {
    weak var view: ChannelsViewInput?
    weak var output: ChannelsModuleOutput?

    init(folder: AnyFolder,
         channelReactor: ChannelReactor,
         channelStorage: ChannelStorage,
         errorPresenter: ErrorPresenter,
         activityPresenter: ActivityPresenter) {
        self.folder = folder
        self.channelReactor = channelReactor
        self.channelStorage = channelStorage
        self.errorPresenter = errorPresenter
        self.activityPresenter = activityPresenter
        self.startObservingChannels()
    }

    deinit {
        self.stopObservingChannels()
    }

    // model
    private let folder: AnyFolder

    // dependencies
    private let channelReactor: ChannelReactor
    private let channelStorage: ChannelStorage
    private let errorPresenter: ErrorPresenter
    private let activityPresenter: ActivityPresenter

    // helpers
    private var channelsToken: ChannelObservationToken?
}

extension ChannelsPresenter: ChannelsModule {
}

extension ChannelsPresenter: ChannelsViewOutput {
    func userWantsToAddChannel() {
        self.output?.channels(module: self, userWantsToAddChannelInside: self.folder)
    }

    func userWantsToOpenChannel(_ channel: AnyChannel) {

    }

    func userWantsToDeleteChannel(_ channel: AnyChannel) {
        self.activityPresenter.increment()
        self.channelStorage.deleteChannel(channel) { [weak self] result in
            self?.activityPresenter.decrement()
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.errorPresenter.present(error)
            }
        }
    }
}

extension ChannelsPresenter {
    private func startObservingChannels() {
    self.stopObservingChannels()
        self.channelsToken = self.channelReactor.observe(folder: self.folder) { [weak self] change in
            switch change {
            case .initial(let channels):
                self?.view?.channels = channels
            case .update(let channels, _, _, _):
                self?.view?.channels = channels
            case .error(let error):
                self?.errorPresenter.present(error)
            }
        }
    }

    private func stopObservingChannels() {
        self.channelsToken?.invalidate()
    }
}
