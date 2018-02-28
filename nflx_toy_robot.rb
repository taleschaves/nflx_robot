Dir[File.join(__dir__, "lib", "**", "*.rb")].each do |file|
  require file
end

toy_robot = ToyRobot.new
file_path = './data/commands.txt'
FileCommandParser.new.execute_commands(file_path: file_path,
                                       toy_robot: toy_robot)
