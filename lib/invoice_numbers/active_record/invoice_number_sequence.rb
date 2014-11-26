class InvoiceNumberSequence < ActiveRecord::Base
  attr_accessible :name, :next_number
  def self.by_sequence_name( sequence_name )
    InvoiceNumberSequence.where(name: sequence_name).first_or_create!
  end

  def increment!
    transaction do
      lock!
      number = self.next_number
      self.next_number = number + 1
      self.save!
      number
    end
  end
end
