module ClockIndicator
  class LastMonthCalendar < OtherMonthCalendar

    private

      def month
        1.month.ago
      end
  end
end
