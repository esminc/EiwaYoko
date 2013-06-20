class MembersController < ApplicationController
  before_filter :set_date, only: :show

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])

    calendar = @client.discovered_api('calendar', 'v3')
    events = @client.execute(
      api_method: calendar.events.list,
      :parameters => {
        calendarId: @member.email,
        timeMin: @date,
        timeMax: @date + 1
      }
    )

    @day_items = events.data.items.select{|i|
      i.start.date.present?
    }.sort_by{|i| i.end.date }
    @time_items = events.data.items.select{|i|
      i.start.date.blank? && i.start.dateTime.to_date == @date.to_date
    }.sort_by{|i| i.start.dateTime }
  end

  private

  def set_date
    @date = DateTime.parse(params[:date])
  rescue
    @date = DateTime.now
  end
end
