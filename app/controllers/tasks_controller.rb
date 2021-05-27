class TasksController < ApplicationController
  def index
    if params[:key] && params[:sort]
      @tasks = Task.all.order("#{params[:key]} #{params[:sort]}")
    else
      @tasks = Task.all
    end
  end

  def show
    @task = Task.find(params[:id])
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
      flash[:alert] = "スケジュールを更新できませんでした"
      render "edit"
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params.require(:task).permit(:title, :start_at, :end_at, :all_day, :memo))
    if @task.save
      flash[:notice] = "スケジュールを登録しました"
      redirect_to :tasks
    else
      flash[:alert] = "スケジュールを登録できませんでした"
      render "new"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:alert] = "スケジュールを削除しました"
    redirect_to tasks_path
  end

end
