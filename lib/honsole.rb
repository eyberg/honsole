@banner =<<END
 __                             __        
|  |--.-----.-----.-----.-----.|  |.-----.
|     |  _  |     |__ --|  _  ||  ||  -__|
|__|__|_____|__|__|_____|_____||__||_____|
END

module Heroku::Command
  class App < Base

    def honsole
      puts "\033[1m\033[31m #{@banner} \033[0m"
      console
    end

    def gather_some_shit
      begin
        mlines = HighLine.ask( ">>", lambda { |ans| ans} ) do |q|
          q.gather = ""
        end.join(";")
      rescue
        puts "probably got a ctrl-d -- should exit only on EOF exception"
        exit
      end
    end

    # do not want to override this ... only when you issue the honsole
    # should it override... hrm.
    #
    # overrriding the console session
    # still need to put an enter but better than ctrl-d and better than
    # no support at all
    def console_session(app)
      heroku.console(app) do |console|
        console_history_read(app)

        display "Ruby console for #{app}.#{heroku.host}"

        break_this_shit = false

        while !break_this_shit
          cmd = gather_some_shit
          unless cmd.nil? || cmd.strip.empty?
            console_history_add(app, cmd)
            break if cmd.downcase.strip == 'exit'
            display console.run(cmd)
          end
        end

      end

    end

  end
end
