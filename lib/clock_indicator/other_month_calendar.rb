module ClockIndicator
  class OtherMonthCalendar
    def calendar
      @calendar ||= Gtk::Calendar.new.tap do |c|
        c.month = month.month - 1
        c.day = 0
        c.set_display_options(OTHER_CALENDAR_OPTIONS)
      end
    end
  end
end

