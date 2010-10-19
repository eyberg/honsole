module Heroku::Command
  class App < Base

    def honsole
      console
    end

    def console_session(app)
      heroku.console(app) do |console|
        console_history_read(app)

        display "Ruby console for #{app}.#{heroku.host}"

        mlines = ask( ">>", lambda { |ans| ans} ) do |q|
          q.gather = ""
        end.join(";")

        cmd = mlines

        #while cmd = Readline.readline('>> ')
          unless cmd.nil? || cmd.strip.empty?
            console_history_add(app, cmd)
            break if cmd.downcase.strip == 'exit'
            display console.run(cmd)
          end
        #end

      end

    end

  end
end

=begin
module Heroku::Command

  class App
    # set option to color output
    def console_with_colorize
      puts 'piss your pants'
      console_without_colorize
    end

    alias_method :console_without_colorize, :console
    alias_method :console, :console_with_colorize

  end
end
=end
