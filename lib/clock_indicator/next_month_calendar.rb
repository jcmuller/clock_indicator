module ClockIndicator
  class NextMonthCalendar < OtherMonthCalendar

    private

      def date
        i.month.from_now
      end
  end
end
