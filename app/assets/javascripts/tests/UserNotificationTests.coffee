describe 'user notifications end to end tests', ->

    check = (triggerFunc, count) ->
        runs ->
            triggerFunc()

        size = $('.user-notification').size()

        waitsFor ->
            expect(size).toBe count
        , 'notification didnt appear', config.maxWaitForEventDuration

        size = $('.user-notification').size()

        waitsFor ->
            expect(size).toBe 0
        , 'notification didnt hide', config.notificationDuration + 1

    beforeEach ->   browser().navigateTo '../../app/index.html'

    it 'should exist html code with class ".user-notification" in count of 1', ->
        check ->
            # somehow trigger 'user entered' event
        , 1

    it 'should exist html code with class ".user-notification" in count of 1', ->
        check ->
            # somehow trigger 'user exited' event
        , 1

    it 'should exist html code with class ".user-notification" in count of 2', ->
        check ->
            # somehow trigger 'user entered' event two times
        , 2

    it 'should exist html code with class ".user-notification" in count of 2', ->
        check ->
            # somehow trigger 'user exited' event two times
        , 2

    it 'should exist html code with class ".user-notification" in count of 2', ->
        check ->
            # somehow trigger 'user entered' event and then 'user exited' event
        , 2
