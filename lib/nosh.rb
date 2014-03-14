require 'yaml'

class Nosh
  def initialize(source_release_path, dest_release_path)
    @source_release_path = source_release_path
    @dest_release_path = dest_release_path
  end

  def run
    # initialize the bosh release from source release
    FileUtils.mkpath("#{@dest_release_path}/jobs")
    FileUtils.mkpath("#{@dest_release_path}/packages")
    FileUtils.mkpath("#{@dest_release_path}/src")

    system!("cp -r #{@source_release_path}/ #{@dest_release_path}")

    components.each do |component_name, component_path|
      processes = Dir.glob("#{component_path}/.nosh/*").map {|path| File.basename(path)}
      processes.each do |process_name|
        if Dir.exist?("#{component_path}/.nosh/#{process_name}/job")
          # copy job
          FileUtils.mkpath("#{@dest_release_path}/jobs/#{component_name}-#{process_name}")
          system!("cp -r #{component_path}/.nosh/#{process_name}/job/ #{@dest_release_path}/jobs/#{component_name}-#{process_name}/")
        end

        if Dir.exist?("#{component_path}/.nosh/#{process_name}/package")
          # copy package
          FileUtils.mkpath("#{@dest_release_path}/packages/#{component_name}-#{process_name}")
          system!("cp -r #{component_path}/.nosh/#{process_name}/package/ #{@dest_release_path}/packages/#{component_name}-#{process_name}/")
        end
      end

      # copy source
      FileUtils.mkpath("#{@dest_release_path}/src/#{component_name}")
      system!("rsync -a --exclude=\".*\" #{component_path}/ #{@dest_release_path}/src/#{component_name}/")
    end
  end

  def system!(cmd)
    system(cmd) or raise "Failed to run: `#{cmd}'"
  end

  def components
    @components ||= YAML.load_file(File.join(@source_release_path, 'Releasefile'))
  end
end
