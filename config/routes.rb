# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

match 'meeting_room_calendar', :to => 'meeting_room_calendar#index'
match 'meeting_room_calendar/index', :to => 'meeting_room_calendar#index'
match 'meeting_room_calendar/missing_config', :to => 'meeting_room_calendar#missing_config'
match 'meeting_room_calendar/create', :to => 'meeting_room_calendar#create'
match 'meeting_room_calendar/update', :to => 'meeting_room_calendar#update'
match 'meeting_room_calendar/delete', :to => 'meeting_room_calendar#delete'
match 'meeting_room_calendar_to_ical/issue' => 'meeting_room_calendar_to_ical#issue'
