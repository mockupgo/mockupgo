# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
    if $('#page-show').length > 0
        project_id = $('.navigation').data("project-id")
        page_id    = $('.navigation').data("page-id")

        $.ajax '/projects/' + project_id + '/pages/' + page_id + ".json",
            type: 'GET'
            dataType: 'JSON'
            success: (data) -> 
                $('#display-style button.' + data.device).addClass("active")
            error: (data) -> 
                alert("Error retrieving information from server")

        $('#display-style button').click () ->
            $('#display-style button').removeClass("active")
            $(this).addClass("active")

            $.ajax '/projects/' + project_id + '/pages/' + page_id,
                type: 'PUT'
                dataType: 'JSON'
                data:
                    page: 
                        device: $(this).data("display-mode")