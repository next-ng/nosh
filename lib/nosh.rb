class Nosh
  def run
    # initialize the bosh release from source release
    FileUtils.mkpath("tmp/generated-boshrelease")
    FileUtils.mkpath("tmp/generated-boshrelease/jobs")
    FileUtils.mkpath("tmp/generated-boshrelease/packages")
    FileUtils.mkpath("tmp/generated-boshrelease/src")

    system!("cp -r spec/fixtures/source-boshrelease/ tmp/generated-boshrelease")

    component_name = "nosh-component"
    processes = Dir.glob("spec/fixtures/#{component_name}/.nosh/*").map {|path| File.basename(path)}
    processes.each do |process_name|
      # copy job
      FileUtils.mkpath("tmp/generated-boshrelease/jobs/#{component_name}-#{process_name}")
      system!("cp -r spec/fixtures/#{component_name}/.nosh/#{process_name}/job/ tmp/generated-boshrelease/jobs/#{component_name}-#{process_name}/")

      # copy package
      FileUtils.mkpath("tmp/generated-boshrelease/packages/#{component_name}-#{process_name}")
      system!("cp -r spec/fixtures/#{component_name}/.nosh/#{process_name}/package/ tmp/generated-boshrelease/packages/#{component_name}-#{process_name}/")
    end

    # copy source
    FileUtils.mkpath("tmp/generated-boshrelease/src/#{component_name}")
    system!("cp -r spec/fixtures/#{component_name}/ tmp/generated-boshrelease/src/#{component_name}/")
  end

  def system!(cmd)
    system(cmd) or raise "Failed to run: `#{cmd}'"
  end
end
