class ProcedureController < ApplicationController
  
  def index
    @title = 'Procedures'
    @procedures = Procedure.all.order( 'display_order asc' )
  end
  
  def show
    procedure = params[:procedure]
    @procedure = Procedure.find( procedure )
    title = @procedure.name
  end
  
  def flip
    procedure = params[:procedure]
    @procedure = Procedure.find( procedure )
    if @procedure.active
      @procedure.active = false
    else
      @procedure.active = true
    end
    @procedure.save
    redirect_to :procedure_list
  end
end
