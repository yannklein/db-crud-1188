require "sqlite3"
require "pry-byebug"
DB = SQLite3::Database.new("tasks.db")

require_relative "task"

# create a model of Task with title (String), description (String), done (boolean)
# p Task.new(title: 'Livecode', description: 'code live')

# Implement the READ logic to find a given task (by its id)
# task = Task.find(4)
# p task
# puts "[#{task.done ? "X" : " "}] #{task.title}: #{task.description}"

# Implement the CREATE logic in a save instance method
# new_task = Task.new(title: 'Livecode', description: 'code live')
# new_task.save

# Implement the UPDATE logic in the same method
# task = Task.find(4)
# task.description = "ask your problem to ChatGPT"
# task.done = true
# task.save

# Implement the READ logic to retrieve all tasks (what type of method is it?)
tasks = Task.all
tasks.each { |task| puts "[#{task.done ? "X" : " "}] #{task.title}: #{task.description}"}

# Implement the DESTROY logic on a task
task = Task.find(4)
task.destroy
tasks = Task.all
tasks.each { |task| puts "[#{task.done ? "X" : " "}] #{task.title}: #{task.description}"}
