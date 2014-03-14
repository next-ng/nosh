require 'yaml'

class Nosh
  def initialize(release_path)
    @release_path = release_path
  end

  def run
    # initialize the bosh release from source release
    FileUtils.mkpath("#{@release_path}/jobs")
    FileUtils.mkpath("#{@release_path}/packages")
    FileUtils.mkpath("#{@release_path}/src")

    components.each do |component_name, component_path|
      processes = Dir.glob("#{component_path}/.nosh/*").map {|path| File.basename(path)}
      processes.each do |process_name|
        if Dir.exist?("#{component_path}/.nosh/#{process_name}/job")
          # copy job
          FileUtils.mkpath("#{@release_path}/jobs/#{component_name}-#{process_name}")
          system!("cp -r #{component_path}/.nosh/#{process_name}/job/ #{@release_path}/jobs/#{component_name}-#{process_name}/")
        end

        if Dir.exist?("#{component_path}/.nosh/#{process_name}/package")
          # copy package
          FileUtils.mkpath("#{@release_path}/packages/#{component_name}-#{process_name}")
          system!("cp -r #{component_path}/.nosh/#{process_name}/package/ #{@release_path}/packages/#{component_name}-#{process_name}/")
        end
      end

      # copy source
      FileUtils.mkpath("#{@release_path}/src/#{component_name}")
      system!("rsync -a --exclude=\".*\" #{component_path}/ #{@release_path}/src/#{component_name}/")
    end
  end

  def system!(cmd)
    system(cmd) or raise "Failed to run: `#{cmd}'"
  end

  def components
    @components ||= YAML.load_file(File.join(@release_path, 'Releasefile'))
  end
end
