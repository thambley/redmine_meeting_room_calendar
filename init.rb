require 'redmine'

Rails.configuration.to_prepare do
  require 'redmine_meeting_room_calendar'
end

Redmine::Plugin.register :redmine_meeting_room_calendar do
  name 'Redmine Meeting Room Calendar plugin'
  author 'QBurst, Tobias Droste, Todd Hambley'
  description 'This is a plugin for Redmine to see meeting rooms on a particular day on the calendar'
  version '2.1.0'
  requires_redmine :version_or_higher => '2.0.0'

  permission :meeting_room_calendar, { :meeting_room_calendar => [:index] }, :public => true
  menu :top_menu, :meeting_room_calendar, { :controller => 'meeting_room_calendar', :action => 'index' }, :caption => :label_name, :after => :help

  settings :default => {"project_id" => "0",
                        "tracker_id" => "0",
                        "time_entry_activity_id" => "0",
                        "custom_field_id_room" => "0",
                        "custom_field_id_start" => "0",
                        "custom_field_id_end" => "0",
                        "custom_field_id_invited" => "0",
                        "custom_field_id_attended" => "0",
                        "custom_field_id_notes" => "0",
                        "show_project_menu" => "1"},
           :partial => "meeting_room_calendar/meeting_room_calendar_settings"
end




