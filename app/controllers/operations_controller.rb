class OperationsController < ApplicationController
  before_action :set_operation, only: [:show, :update, :destroy]

  # GET /operations
  def index
    
      data = []
      retorno = []
      total_filtrado = 0

      #define nome correspondente ao numero da coluna
      column_names = {	"0" => 'A.id',
                        "1" => 'A.transaction_type_id',
                        "2" => 'A.date',
                        "3" => 'A.value',
                        "4" => 'A.CPF',
                        "5" => 'A.card_number',
                        "6" => 'A.hour',
                        "7" => 'A.owner',
                        "8" => 'A.store_name'}

      #termo
      if params["search"].present?
        term = params["search"]["value"] 
      else
        term = ""
      end
      #replace ' ' to '%' 
      term.gsub! ' ', '%'
     
      #se o termo da busca tiver pelo menos 5 letras
      # if term.length > 5


     sql="select 
              *
              from 
                (
                  select
                      id,
                    transaction_type_id,
                    to_char(\"date\", 'DD/MM/YYYY') as date,
                    (value/100) as value,
                    \"CPF\",
                    card_number,
                    \"hour\",
                    \"owner\",
                    store_name,
                    CONCAT(
                        id
                        ,' ', transaction_type_id
                        ,' ', to_char(\"date\", 'DD/MM/YYYY')
                        ,' ', value
                        ,' ', \"CPF\"
                        ,' ', card_number
                        ,' ', \"hour\"
                        ,' ', \"owner\"
                        ,' ', store_name
                     ) as search_string
                                  from
                              public.operations) A
              where 
                A.search_string like '%"+term+"%'"
                        
                if params['data_nascimento'].present?
                    sql += " AND A.data_nascimento = '"+params['data_nascimento']+"' "
                end
       
      @search = ActiveRecord::Base.connection.execute(sql).values     
      
      @search.each do |tupla| 
        data.push :id=> tupla[0],
        :transaction_type_id=> tupla[1],
        :date=> tupla[2],
        :value=> tupla[3],
        :CPF=> tupla[4],
        :card_number=> tupla[5],
        :hour=> tupla[6],
        :owner=> tupla[7],
        :store_name=> tupla[8]
      end  
    
          # end

      #Quantidade de registros que há no banco de dados
      sql_qtd = "select * from public.operations" 

      qtdRegistros = ActiveRecord::Base.connection.execute(sql_qtd).count 

      sql_qtd_toal_pesquisa = "select 
                                *
                                from 
                                  (
                                    select
                                        id,
                                      transaction_type_id,
                                      to_char(\"date\", 'DD/MM/YYYY') as date,
                                      (value/100) as value,
                                      \"CPF\",
                                      card_number,
                                      \"hour\",
                                      \"owner\",
                                      store_name,
                                      CONCAT(
                                          id
                                          ,' ', transaction_type_id
                                          ,' ', to_char(\"date\", 'DD/MM/YYYY')
                                          ,' ', value
                                          ,' ', \"CPF\"
                                          ,' ', card_number
                                          ,' ', \"hour\"
                                          ,' ', \"owner\"
                                          ,' ', store_name
                                      ) as search_string
                                                    from
                                                public.operations) A
                                where 
                                  A.search_string like '%"+term+"%'"

                                if params['data_nascimento'].present?
                                  sql += " AND A.data_nascimento = '"+params['data_nascimento']+"' "
                                end

                                  
      qtdFiltrada = ActiveRecord::Base.connection.execute(sql_qtd_toal_pesquisa).count
    
      retorno = {
        "draw" => params["draw"], #para cada requisição é enviado um número como parâmetro
        "recordsTotal" => qtdRegistros,  #Quantidade de registros que há no banco de dados
        "recordsFiltered" => qtdFiltrada, #Total de registros quando houver pesquisa
        "data" => data   #Array de dados completo dos dados retornados da tabela   
      }
      
      render json: retorno
  end

  # GET /operations/1
  def show
    render json: @operation
  end

  # POST /operations
  def create
    if params[:file].present?
      if Operation.parser(params[:file])
        render json: {
            message: 'Importado com sucesso'
          }, status: :created
      else
        return render json: {
            message: 'Erro importar aqruivo'
          }, status: :precondition_failed
      end
    else
      @operation = Operation.new(operation_params)

      if @operation.save
        render json: @operation, status: :created, location: @operation
      else
        render json: @operation.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /operations/1
  def update
    if @operation.update(operation_params)
      render json: @operation
    else
      render json: @operation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /operations/1
  def destroy
    @operation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def operation_params
      params.require(:operation).permit(:transaction_type_id, :date, :value, :CPF, :card_number, :hour, :owner, :store_name, :file)
    end
end
