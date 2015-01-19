class MeetingRoomCalendarToIcalController < ApplicationController
  unloadable
  
  include ApplicationHelper

  def initialize
    super()

    @tracker_id = Setting["plugin_redmine_meeting_room_calendar"]["tracker_id"].to_i
    @custom_field_id_room = Setting["plugin_redmine_meeting_room_calendar"]["custom_field_id_room"].to_i
    @custom_field_id_start = Setting["plugin_redmine_meeting_room_calendar"]["custom_field_id_start"].to_i
    @custom_field_id_end = Setting["plugin_redmine_meeting_room_calendar"]["custom_field_id_end"].to_i

  end
  
  
  def issue
    issue = Issue.find_by_id(params[:issue_id])

    return render nothing: true if issue.nil?
    
    #validate tracker id, date start / date end

    calendar = Icalendar::Calendar.new
    calendar.publish

    event = issue_event(issue)
    calendar.add_event(event)

    send_data calendar.to_ical, type: :ics, filename: "meeting_#{issue.id}.ics"
  end

  private

  def issue_event(issue)
    Icalendar::Event.new.tap do |e|
      start_time_field = get_custom_field( issue, @custom_field_id_start )
      start_time = (start_time_field)? start_time_field.value.split(':') : [0,0]
      e.dtstart = DateTime.civil(issue.start_date.year, issue.start_date.mon, issue.start_date.mday, start_time[0].to_i, start_time[1].to_i)
      
      end_time_field = get_custom_field( issue, @custom_field_id_end )
      end_time = (end_time_field)? end_time_field.value.split(':') : [0,0]
      e.dtend = DateTime.civil(issue.due_date.year, issue.due_date.mon, issue.due_date.mday, end_time[0].to_i, end_time[1].to_i)
      
      location = get_custom_field( issue, @custom_field_id_room )
      if (location)
        e.location = location.value.kind_of?(Array)? location.value.join(';') : location.value
      end
      
      e.summary = issue.subject
      e.description = issue.description
      e.url = issue_url(issue)
      e.transp = "OPAQUE"
      
      e.append_custom_property("X-ALT-DESC", Icalendar::Values::Text.new(textilizable(issue, :description, :only_path => false), { "FMTTYPE" => "text/html" }))
    end
  end

  def icalendar_date(date)
    Icalendar::Values::Date.new date
  end
  
  def get_custom_field(issue, custom_field_id)
    issue.custom_field_values.select { |cf| cf.custom_field_id == custom_field_id }.first
  end
  
  def check_settings()
    if @tracker_id == nil || @tracker_id.to_s == "0" || @project_id.to_s == ""
      return false
    end
    if @custom_field_id_room == nil || @custom_field_id_room.to_s == "0" || @custom_field_id_room.to_s == ""
      return false
    end
    if @custom_field_id_start == nil || @custom_field_id_start.to_s == "0" || @custom_field_id_start.to_s == ""
      return false
    end
    if @custom_field_id_end == nil || @custom_field_id_end.to_s == "0" || @custom_field_id_end.to_s == ""
      return false
    end

    return true
  end
  
end