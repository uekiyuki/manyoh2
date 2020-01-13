class TasksController < ApplicationController
  # require 'byebug'; byebug
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
#  byebug
    if  params[:sort_priority]
      # @tasks = Task.order(priority: :asc)
      @task =  Task.priority  
    elsif  params[:sort_expired]
      # @task = Task.all.order(time_limit: :desc)
      @task = Task.expired
    elsif params[:search]
      # @task = Task.where("title LIKE ? AND status LIKE ?", "%#{ params[:title] }%", "%#{params[:status]}%")
      @task = Task.search(params)
    else
      @task = Task.latest
    end 

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
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
  @task = Task.find(params[:id])
  end


end

