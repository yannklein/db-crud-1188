class Task
  attr_reader :id
  attr_accessor :done, :title, :description

  def initialize(attributes = {})
    @id = attributes[:id] || attributes["id"]
    @title = attributes[:title] || attributes["title"]
    @description = attributes[:description] || attributes["description"]
    @done = attributes[:done] || attributes["done"] || false
  end

  def self.find(id)
    # create a SQL query
    query = "SELECT * FROM tasks WHERE id = ?"
    # execute it -> array of one hash with some task info
    DB.results_as_hash = true
    task_info = DB.execute(query, id).first
    # {
    #   "id" => 4, 
    #   "title" => "Coding", 
    #   "description" => "google your problem", 
    #   "done" => 0
    # }

    # if task_info["done"] is 1 
    # task_info["done"] == 1 ===> true
    # if task_info["done"] is 0 
    # task_info["done"] == 1 ===> false

    task_info["done"] = task_info["done"] == 1
    # create an instance of task with the task info
    # return an instance of task
    Task.new(task_info)
  end

  def save
    if @id.nil?
      # create the code
      DB.execute("INSERT INTO tasks(title, description, done) VALUES(?,?,?)",@title, @description, @done ? 1 : 0)
      @id = DB.last_insert_row_id
    else
      # update the code
      query = <<~SQL
        UPDATE tasks
        SET title = ?, description = ?, done = ?
        WHERE id = ?
      SQL
      DB.execute(query, @title, @description, @done ? 1 : 0, @id)
    end
  end


  def destroy
    query = "DELETE FROM tasks WHERE id = ?"
    DB.execute(query, @id)
  end
end