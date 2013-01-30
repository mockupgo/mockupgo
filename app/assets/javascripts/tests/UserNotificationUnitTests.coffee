config = require '../config'
testConfig = require './testConfig'
UserNotification = (require '../UserNotification').UserNotification

describe 'user notification unit tests', ->

    fakeLogIn = (userNotification) -> userNotification.logged = true

    it 'should be logged in after login()', ->
        userNotification = new UserNotification('user1@gmail.com', testConfig.PusherMock)
        runs ->
            userNotification.login()

        waitsFor ->
            userNotification.logged
        , 'user logged in', testConfig.timeouts.response


    # it 'should be logged out after logout()', ->
    #     userNotification = new UserNotification('user1@gmail.com', testConfig.PusherMock)
    #     fakeLogIn(userNotification)

    #     runs ->
    #         userNotification.logout()

    #     waitsFor ->
    #         not userNotification.logged
    #     , 'user logged out', testConfig.timeouts.response


    # it 'should get notification when another user calls login()', ->
    #     userNotification = new UserNotification('user1@gmail.com', testConfig.PusherMock)
    #     fakeLogIn(userNotification)
    #     anotherUserNotification = new UserNotification('user2@gmail.com', testConfig.PusherMock)

    #     runs ->
    #         anotherUserNotification.login()

    #     waitsFor ->
    #         anotherUserNotification.logged
    #     , 'user logged in', testConfig.timeouts.response

    #     runs ->
    #         expect(userNotification.notifications.length).toBe 1

    #     waitsFor ->
    #         userNotification.notifications.length is 0
    #     , 'object deleted from notifications array',


    # it 'should get notification when another user calls logout()', ->
    #     userNotification = new UserNotification('user1@gmail.com', testConfig.PusherMock)
    #     fakeLogIn(userNotification)
    #     anotherUserNotification = new UserNotification('user2@gmail.com', testConfig.PusherMock)
    #     fakeLogIn(anotherUserNotification)

    #     runs ->
    #         userNotification.logout()

    #     waitsFor ->
    #         not anotherUserNotification.logged
    #     , 'user logged out', testConfig.timeouts.response

    #     runs ->
    #         expect(userNotification.notifications.length).toBe 1

    #     waitsFor ->
    #         userNotification.notifications.length is 0
    #     , 'object deleted from notifications array', config.durations.notification
