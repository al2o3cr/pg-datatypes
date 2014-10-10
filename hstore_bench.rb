require_relative 'connect'
require_relative 'models/pawn'
require 'benchmark'
require 'benchmark/ips'
require 'faker'

ActiveRecord::Base.logger = nil

Pawn.delete_all

N_DOCUMENTS = 10000

keys = %w(thing1 thing2 other_thing wat huh bbq)

Benchmark.bm(15) do |x|
  x.report('loading pawns:') do
    N_DOCUMENTS.times do |n|
      Pawn.create! do |p|
        keys.each do |k|
          p.send("#{k}=", Faker::Lorem.word)
        end
      end
    end
  end
end

Benchmark.ips do |x|
  x.config(time: 15, warmup: 10)

  x.report("find one") { Pawn.where(thing1: 'repellendus').first }
end

