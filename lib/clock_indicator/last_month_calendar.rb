module ClockIndicator
  class LastMonthCalendar
    def calendar
      @calendar ||= Gtk::Calendar.new.tap do |c|
        c.month = 1.month.ago.month - 1
        c.day = 0
        c.set_display_options(OTHER_CALENDAR_OPTIONS)
      end
    end
  end
end
