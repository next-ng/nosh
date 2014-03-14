require "rspec"

describe "nosh" do
  before do
    Dir.chdir("..")
    puts Dir.pwd

    FileUtils.rm_rf("generated-boshrelease")
  end

  it "works" do
    nosh

    expect(expected_boshrelease).to eq(generated_boshrelease)
  end

  def system!(cmd)
    system(cmd) or raise "Failed to run: `#{cmd}'"
  end

  def nosh
    # initialize the bosh release from source release
    FileUtils.mkpath("generated-boshrelease")
    FileUtils.mkpath("generated-boshrelease/jobs")
    FileUtils.mkpath("generated-boshrelease/packages")
    FileUtils.mkpath("generated-boshrelease/src")

    system!("cp -r source-boshrelease/ generated-boshrelease")

    component_name = "nosh-component"
    processes = Dir.glob("#{component_name}/.nosh/*").map {|path| File.basename(path)}
    processes.each do |process_name|
      # copy job
      FileUtils.mkpath("generated-boshrelease/jobs/#{component_name}-#{process_name}")
      system!("cp -r #{component_name}/.nosh/#{process_name}/job/ generated-boshrelease/jobs/#{component_name}-#{process_name}/")

      # copy package
      FileUtils.mkpath("generated-boshrelease/packages/#{component_name}-#{process_name}")
      system!("cp -r #{component_name}/.nosh/#{process_name}/package/ generated-boshrelease/packages/#{component_name}-#{process_name}/")
    end

    # copy source
    FileUtils.mkpath("generated-boshrelease/src/#{component_name}")
    system!("cp -r #{component_name}/ generated-boshrelease/src/#{component_name}/")
  end

  def expected_boshrelease
    Dir.chdir("expected-boshrelease") { `tree`}
  end

  def generated_boshrelease
    Dir.chdir("generated-boshrelease") { `tree`}
  end
end
