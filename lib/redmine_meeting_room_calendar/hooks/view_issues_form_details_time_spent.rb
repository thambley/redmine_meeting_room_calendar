module RedmineMeetingRoomCalendar
  class TimeSpentHook < Redmine::Hook::ViewListener
    include Redmine::I18n

    render_on :view_issues_form_details_bottom, :partial => 'issues/meeting_room_calendar_time_spent'
  end
end
