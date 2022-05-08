class Operation < ApplicationRecord
  belongs_to :transaction_type

  def self.parser(file)
    #file = params[:file]
    @lines = file.read.force_encoding('UTF-8').split("\n")

    @lines.each do |line|
      op = Operation.new

      op.transaction_type_id	= line[0..0]
      op.date = line[1..8]
      op.value = line[9..18]
      op.CPF = line[19..29]
      op.card_number = line[30..42]
      op.hour = line[42..47]
      op.owner = line[48..61]
      op.store_name = line[62..80]
      op.save
    end

    true
  end
end
