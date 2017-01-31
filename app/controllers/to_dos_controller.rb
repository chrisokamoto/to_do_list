class ToDosController < ApplicationController
  before_action :set_to_do, only: [:edit, :update, :destroy, :finish]

  def new
    @to_do = ToDo.new
  end

  def create
    @to_do = ToDo.new(to_do_params)

    respond_to do |format|
     if @to_do.save
        format.html { redirect_to to_dos_path, notice: 'Tarefa criada com sucesso.' }
        format.json { render :show, status: :created, location: @to_do }
        else
          format.html { render :new }
          format.json { render json: @to_do.errors, status: :unprocessable_entity }
        end
    end
  end

  def update
      
        if @to_do.update(to_do_params)
          redirect_to to_dos_path, notice: 'Tarefa atualizada com sucesso.'
        else
          render :edit
        end
  end
  
  def finish
    @to_do.status = :finished
    @to_do.finished_at = Date.today.strftime("%m/%d/%Y")
    
    if @to_do.save
      redirect_to to_dos_path      
    else    
      redirect_to to_dos_path, alert: 'Não foi possível finalizar tarefa.'      
    end
  end

  def destroy
    @to_do.destroy
    
    redirect_to to_dos_url
  end

  private
    def set_to_do
      @to_do = ToDo.find(params[:id])
    end

      def to_do_params
        params.require(:to_do).permit(:title, :description, :deadline, :finished_at)            
      end
      
      
      
end
