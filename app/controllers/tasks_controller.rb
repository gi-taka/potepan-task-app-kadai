class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(params.require(:task).permit(:title, :start_at, :end_at, :all_day, :memo))
      flash[:notice] = "スケジュールを更新しました"
      redirect_to :tasks
    else
      flash[:alert] = "スケジュールを登録できませんでした"
      render "edit"
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params.require(:task).permit(:title, :start_at, :end_at, :all_day, :memo))
    if @task.save
      flash[:notice] = "スケジュールを登録しました。"
      redirect_to :tasks
    else
      flash[:alert] = "スケジュールを登録できませんでした"
      render "new"
    end
  end

  def destroy
  end
end
