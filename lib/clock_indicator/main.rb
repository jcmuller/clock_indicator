module ClockIndicator
  class Main
    def self.run
      new.run
    end

    def run
      Gtk.init
      ClockIndicator::Clock.new
      trap('SIGINT') { Gtk.main_quit }
      Gtk.main
    end
  end
end
