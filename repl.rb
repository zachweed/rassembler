require 'keystone'
require_relative './repl/command'

class REPL
  def initialize
    puts "Starting an ASM REPL...."
  end

  def start
    print "$ "
    command = command_for_cmd(gets.chomp)
    evaluate_command(command)
    print_command(command)
  rescue Command::AsmSyntaxError
    puts "Invalid Command: #{command.value}"
  ensure
    start
  end

  def evaluate_command(command)
    command.execute
  end

  def print_command(command)
    print("%s = [ " % command.value)
    command.encoding.each_char{|i|print("%02x " % i.ord)}
    puts("]")
  end

  private

    def command_for_cmd(cmd)
      exit if cmd[/exit/]
      Command.new(cmd)
    end
end

REPL.new.start if __FILE__==$0


