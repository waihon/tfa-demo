class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def update
    @todo = Todo.find_by_id(params[:id])
    @todo.update(todo_params)
    @todo.save
    respond_to do |format|
      format.js
    end
  end

private

  def todo_params
    params.require(:todo).permit(:title, :completed)
  end
end
