class TasksController < ApplicationController
  # require 'byebug'; byebug
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def index
    if  params[:sort_priority]
      @task =  current_user.tasks.priority  
    elsif  params[:sort_expired]
      @task = current_user.tasks.expired
    elsif params[:search]
      @task = current_user.tasks.search(params)
    else
      @task = current_user.tasks.latest
    end 
    @task = @task.page(params[:page]).per(7)
  end

  def create
    @task = Task.create(task_params.merge(user_id: current_user.id))
    if @task.save
    redirect_to task_path(@task.id), notice: "タスクを作成しました!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update   
    @task = Task.find(params[:id])
    if @task.update(task_params)
    redirect_to tasks_path, notice: "タスクを編集しました！"
  else
    render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :time_limit, :sort_expired, :status, :priority)
  end

  def set_task
  @task = current_user.tasks.find(params[:id])
  end

end

