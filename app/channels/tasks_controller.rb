class TasksController < ApplicationController
#  require 'byebug'; byebugs
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  
  def index
    @task = current_user.tasks.includes(:labels).latest
    if params[:label_id].present?
      @task = @task.joins(:labels).where(labels: { id: params[:label_id] })
    elsif  params[:sort_priority].present?
      @task =  current_user.tasks.priority 
    elsif params[:sort_expired].present?
      @task = current_user.tasks.expired
    else
      params[:search].present?
      @task = current_user.tasks.search(params)
    end 
    @task = @task.page(params[:page]).per(7)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    # binding.irb
    # @task = Task.create(task_params.merge(user_id: current_user.id))
    if @task.save
      redirect_to task_path(@task.id), notice: "タスクを作成しました!"
    else
      render :new
    end
  end

  def show
    # @labeling = current_task.labelinges.find_by(label_id: @label.id)
  end

  def edit
  end

  def update   
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task.id), notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :time_limit, :status, :priority, label_ids: [])
  end

end

