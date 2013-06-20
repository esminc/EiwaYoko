class MembersController < ApplicationController
  before_filter :set_date, only: :show

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])

    calendar = @client.discovered_api('calendar', 'v3')
    @events = @client.execute(
      api_method: calendar.events.list,
      :parameters => {
        calendarId: @member.email,
        timeMin: @date,
        timeMax: @date + 1
      }
    )
    @cal = @events.data
  end

  private

  def set_date
    @date = DateTime.parse(params[:date])
  rescue
    @date = DateTime.now
  end
end
