module ClockIndicator
  class OtherMonthCalendar
    def initialize(i = 1)
      @i = i
    end

    def calendar
      @calendar ||= Gtk::Calendar.new.tap do |c|
        c.display_options = OTHER_CALENDAR_OPTIONS
        c.day             = 0
        c.month           = date.month - 1
        c.year            = date.year
      end
    end

    private

      attr_reader :i

      OTHER_CALENDAR_OPTIONS =
        Gtk::CalendarDisplayOptions[:no_month_change] |
        Gtk::CalendarDisplayOptions[:show_day_names] |
        Gtk::CalendarDisplayOptions[:show_heading]
  end
end
