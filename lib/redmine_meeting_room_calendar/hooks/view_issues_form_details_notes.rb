module RedmineMeetingRoomCalendar
  class NotesHook < Redmine::Hook::ViewListener
    include Redmine::I18n

    render_on :view_issues_form_details_bottom, :partial => 'issues/meeting_room_calendar_notes'
  end
end
