return if window?
config = require 'config'
testConfig = require 'testConfig'

describe 'user notifications end to end tests', ->

    check = (triggerFunc, count) ->
        runs ->
            triggerFunc()

        waitsFor ->
            $('.user-notification').size() is count
        , 'notification to appear', testConfig.durations.maxWaitForEvent

        waitsFor ->
            $('.user-notification').size() is 0
        , 'notification to hide', config.durations.notification + 100


    beforeEach ->
        browser().navigateTo '../../app/index.html'


    it 'should exist html code with class ".user-notification" in count of 1', ->
        runs ->
            viewModel = new UserNotificationViewModel()
            viewModel.update [email: "user@mail.tt"]
            setTimeout ->
                viewModel.update []
            , config.durations.notification

        waitsFor ->
            $('.user-notification').size() is 1
        , 'notification to appear', testConfig.durations.maxWaitForEvent

        waitsFor ->
            $('.user-notification').size() is 0
        , 'notification to hide', config.durations.notification + testConfig.durations.maxWaitForEvent



    it 'should exist html code with class ".user-notification" in count of 1 / 2 / 1 / 0', ->
        runs ->
            viewModel = new UserNotificationViewModel()

            [user1, user2] = ["user1@gmail.com", "user2@gmail.com"]

            viewModel.update [email: user1]

            setTimeout ->
                viewModel.update [{email: user1}, {email: user2}]
            , config.durations.notification/2

            setTimeout ->
                viewModel.update [email: user2]
            , config.durations.notification

            setTimeout ->
                viewModel.update []
            , config.durations.notification*3/2

        waitsFor ->
            $('.user-notification').size() is 1
        , '1 notification to appear', testConfig.durations.maxWaitForEvent

        waitsFor ->
            $('.user-notification').size() is 2
        , '2 notifications to appear', config.durations.notification/2 + testConfig.durations.maxWaitForEvent

        waitsFor ->
            $('.user-notification').size() is 1
        , '1 notification to appear, 1 to hide', config.durations.notification + testConfig.durations.maxWaitForEvent

        waitsFor ->
            $('.user-notification').size() is 0
        , 'all notifications to hide', testConfig.durations.maxWaitForEvent*3/2 + testConfig.durations.maxWaitForEvent
