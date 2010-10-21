module Heroku::Command
  class App < Base

    # we are betting that heroku will keep scope for us -- we just need
    # to ensure our blocks are sent at the same time
    def get_some_shit
      stack = 0

      block = ""

      while true
        print "> "
        code = gets
        break if code.nil?
        begin
          block += code

          ftokens = code.match(/do|\{/)
          if !ftokens.nil? then
            stack += ftokens.size
          end

          etokens = code.match(/end|\}/)
          if !etokens.nil? then
            stack -= etokens.size
          end

          break if stack.eql? 0
        rescue Exception
          puts $!
        end
      end

      # ensure our block of code is stripped of newlines
      return block.gsub("\n", ";")
    end

    def honsole

@banner =<<END
 __                             __        
|  |--.-----.-----.-----.-----.|  |.-----.
|     |  _  |     |__ --|  _  ||  ||  -__|
|__|__|_____|__|__|_____|_____||__||_____|
END

      puts "\033[1m\033[31m #{@banner} \033[0m"
      console
    end

    def gather_some_shit
      begin
        stuff = get_some_shit
      rescue
        puts "probably got a ctrl-d -- should exit only on EOF exception"
        exit
      end

      return stuff
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
