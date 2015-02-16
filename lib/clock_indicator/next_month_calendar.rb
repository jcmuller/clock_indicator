module ClockIndicator
  class NextMonthCalendar < OtherMonthCalendar

    private

      def month
        1.month.from_now
      end
  end
end
