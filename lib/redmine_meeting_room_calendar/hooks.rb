module RedmineMeetingRoomCalendar
  class Hooks < Redmine::Hook::ViewListener
    include Redmine::I18n

    render_on :view_issues_form_details_bottom, :partial => 'issues/add_to_calendar'
  end
end
