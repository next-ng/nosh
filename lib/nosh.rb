class Nosh
  def initialize(component_path, source_release_path, dest_release_path)
    @component_name = File.basename(component_path)
    @component_path = component_path
    @source_release_path = source_release_path
    @dest_release_path = dest_release_path
  end

  def run
    # initialize the bosh release from source release
    FileUtils.mkpath("#{@dest_release_path}/jobs")
    FileUtils.mkpath("#{@dest_release_path}/packages")
    FileUtils.mkpath("#{@dest_release_path}/src")

    system!("cp -r #{@source_release_path}/ #{@dest_release_path}")

    processes = Dir.glob("#{@component_path}/.nosh/*").map {|path| File.basename(path)}
    processes.each do |process_name|
      if Dir.exist?("#{@component_path}/.nosh/#{process_name}/job")
        # copy job
        FileUtils.mkpath("#{@dest_release_path}/jobs/#{@component_name}-#{process_name}")
        system!("cp -r #{@component_path}/.nosh/#{process_name}/job/ #{@dest_release_path}/jobs/#{@component_name}-#{process_name}/")
      end

      if Dir.exist?("#{@component_path}/.nosh/#{process_name}/package")
        # copy package
        FileUtils.mkpath("#{@dest_release_path}/packages/#{@component_name}-#{process_name}")
        system!("cp -r #{@component_path}/.nosh/#{process_name}/package/ #{@dest_release_path}/packages/#{@component_name}-#{process_name}/")
      end
    end

    # copy source
    FileUtils.mkpath("#{@dest_release_path}/src/#{@component_name}")
    system!("rsync -a --exclude=\".*\" #{@component_path}/ #{@dest_release_path}/src/#{@component_name}/")
  end

  def system!(cmd)
    system(cmd) or raise "Failed to run: `#{cmd}'"
  end
end
