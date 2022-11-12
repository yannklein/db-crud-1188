require "sqlite3"
require "pry-byebug"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# Implement the READ logic to find a given task (by its id)
task = Task.find(3)
puts "#{task.title} [#{task.done ? "X" : " "}] - #{task.description}"

# Implement the CREATE logic in a save instance method
# task = Task.new(title: "Coding", description: "google your problem")
# task.save

# Implement the UPDATE logic in the same method
# task.done = true
# task.save

# Implement the READ logic to retrieve all tasks (what type of method is it?)
p Task.all

# Implement the DESTROY logic on a task
task_to_destroy = Task.find(3)
task_to_destroy.destroy