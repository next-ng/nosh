require "thor"

class Nosh
  class CLI < Thor
    desc "nosh", "Runs Nosh"
    def nosh
      require "nosh"

      nosh = Nosh.new(Dir.pwd)
      nosh.run
    end
  end
end
