require 'gir_ffi-gtk3'
require 'active_support/time'

GirFFI.setup :Gtkti

module ClockIndicator
  autoload :CalendarWindow,       "clock_indicator/calendar_window"
  autoload :Clock,                "clock_indicator/clock"
  autoload :CurrentMonthCalendar, "clock_indicator/current_month_calendar"
  autoload :LastMonthCalendar,    "clock_indicator/last_month_calendar"
  autoload :Main,                 "clock_indicator/main"
  autoload :NextMonthCalendar,    "clock_indicator/next_month_calendar"
  autoload :SubMenu,              "clock_indicator/sub_menu"
  autoload :VERSION,              "clock_indicator/version"

  OTHER_CALENDAR_OPTIONS = Gtk::CalendarDisplayOptions[:no_month_change] |
    Gtk::CalendarDisplayOptions[:show_day_names] |
    Gtk::CalendarDisplayOptions[:show_heading]
end
