require 'pp'

class FileCommandParser
  def execute_commands(file_path:, toy_robot:)
    file_content = read_file_content(file_path: file_path)
    commands = file_content.split("\n")
    commands.each do |command|
      execute_command(command_str: command, toy_robot: toy_robot)
    end
  end

  private
  def execute_command(command_str:, toy_robot:)
    command, command_args = command_str.split

    case command
    when 'PLACE'
      command_args = command_args.split(',')
      toy_robot.place(x: command_args[0].to_i,
                      y: command_args[1].to_i,
                      orientation: command_args[2])
    when 'MOVE'
      toy_robot.move
    when 'LEFT'
      toy_robot.left
    when 'RIGHT'
      toy_robot.right
    when 'REPORT'
      pp toy_robot.report
    end
  end

  def read_file_content(file_path:)
    File.read(file_path)
  end
end
