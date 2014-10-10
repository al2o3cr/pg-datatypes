require_relative 'seed'

puts Pawn.where(this_isnt_a_real_column: 'hi there').count
