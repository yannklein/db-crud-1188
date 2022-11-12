class Task
  attr_reader :id
  attr_accessor :description, :title, :done
  def initialize(attributes = {})
    @id = attributes[:id] || attributes['id']
    @title = attributes[:title] || attributes['title']
    @description = attributes[:description] || attributes['description']
    # done is a boolean in the task instance
    # done is an integer in the DB!😈
    @done = attributes[:done] || @done = attributes['done'] || false
  end

  def self.find(id)
    result = DB.execute("SELECT * FROM tasks WHERE id = ?", id).first
    # result is a hash!
    # REFACTOR!! 👇
    result['done'] = result['done'] == 1
    Task.new(result)
  end

  def save
    mark_done = @done ? 1 : 0
    if @id.nil?
      DB.execute("INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)", @title, @description, mark_done)
      @id = DB.last_insert_row_id
    else
      DB.execute("UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?", @title, @description, mark_done, @id)
    end
  end

  def self.all
    query = <<~SQL
      SELECT * FROM tasks
    SQL
    rows = DB.execute(query)
    rows.map { |row| Task.new(row) }
  end

  def destroy
    query = <<~SQL
      DELETE FROM tasks
      WHERE id = ?
    SQL
    DB.execute(query, @id)
  end
end
# where do we turn the 0 into false, before creating our task?