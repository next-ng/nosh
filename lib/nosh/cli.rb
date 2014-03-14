require "thor"

class Nosh
  class CLI < Thor
    desc "nosh component_path source_release_path detition_release_path", "Runs Nosh"
    def nosh(component_path, source_release_path, detition_release_path)
      require "nosh"

      nosh = Nosh.new(component_path, source_release_path, detition_release_path)
      nosh.run
    end
  end
end
