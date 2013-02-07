config = require '../config'
testConfig = require './testConfig'
UserNotification = (require '../UserNotification').UserNotification
UserNotificationViewModel = (require '../angular/UserNotificationViewModel').UserNotificationViewModel

describe 'user notification unit tests', ->

    beforeEach: ->
        PusherMock.toTrigger = {}
        PusherMock.memberAddedHandlers = {}

    fakeLogIn = (userNotification, email) ->
        userNotification.me = {id:1,info:{email:"me@email.as"}}
        userNotification.connectedUsersCount = 1

    it 'should be logged in after login()', ->
        viewModel = new UserNotificationViewModel
        userNotification = new UserNotification viewModel, testConfig.PusherMock(1,"asdasd",[])
        runs ->
            userNotification.login()

        waitsFor ->
            userNotification.me?
        , 'user objects exists', testConfig.timeouts.response

        runs ->
            expect(userNotification.connectedUsersCount).toBe 1
        , 'user logged in', testConfig.timeouts.response


    it 'should know about another user calls login()', ->
        viewModel = new UserNotificationViewModel
        userNotification = new UserNotification viewModel, testConfig.PusherMock(1,"someone1@mail.sa",[])
        anotherUserNotification = new UserNotification viewModel, testConfig.PusherMock(2,"someone2@mail.sa",[{id:1,email:"someone1@mail.sa"}])

        runs ->
            userNotification.login()

        waitsFor ->
            userNotification.me?
        , 'both users logged in', testConfig.timeouts.response

        runs ->
            anotherUserNotification.login()

        waitsFor ->
            anotherUserNotification.me?
        , 'both users logged in', testConfig.timeouts.response


    it 'should update connected users list on member_removed', ->
        viewModel = new UserNotificationViewModel
        pusherMock = testConfig.PusherMock 1,"someone1@mail.sa",[]
        userNotification = new UserNotification viewModel, pusherMock
        fakeLogIn userNotification, 'someuser1@gmail.com'

        runs ->
            pusherMock.send 'member_removed'

