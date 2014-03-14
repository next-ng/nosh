require "thor"

class Nosh
  class CLI < Thor
    desc "nosh SOURCE_RELEASE_PATH DESTINATION_RELEASE_PATH", "Runs Nosh"
    def nosh(source_release_path, destination_release_path)
      require "nosh"

      nosh = Nosh.new(source_release_path, destination_release_path)
      nosh.run
    end
  end
end
