module ClockIndicator
  class LastMonthCalendar < OtherMonthCalendar

    private

      def date
        i.month.ago
      end
  end
end
