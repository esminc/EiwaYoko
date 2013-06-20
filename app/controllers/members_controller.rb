class MembersController < ApplicationController
  def index
  end
  def show
    calendar = @client.discovered_api('calendar', 'v3')

    events = @client.execute(
      :api_method => calendar.events.list,
      :parameters => {'calendarId' => "m-hirata@esm.co.jp", 'timeMax' => '2013-06-19T00:00:00Z', 'timeMin' => '2013-06-18T00:00:00Z'}
    )
    @cal = events.data
  end
end
