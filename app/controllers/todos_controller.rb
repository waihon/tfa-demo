class TodosController < ApplicationController
  before_action :require_signin
  before_action :require_correct_user

  def index
    @todos = current_user.todos.all
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

  def require_correct_user
    @user = User.find(params[:user_id])
    redirect_to root_url unless current_user?(@user)
  end
end
