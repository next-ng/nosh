require "rspec"

describe "nosh" do
  before do
    Dir.chdir("..")
    FileUtils.rm_rf("dummy-boshrelease-next")
    puts Dir.pwd
  end

  it "works" do
    nosh

    expect(boshrelease_tree).to eq(noshrelease_tree)
  end

  def nosh
    FileUtils.mkpath("dummy-boshrelease-next/jobs")
    FileUtils.mkpath("dummy-boshrelease-next/packages")
    FileUtils.mkpath("dummy-boshrelease-next/src")

    jobs = Dir.glob("dummy-noshrelease/*")
    jobs.each do |job|
      FileUtils.mkpath("dummy-boshrelease-next/jobs/#{File.basename(job)}")
    end

    packages = Dir.glob("dummy-noshrelease/*")
    packages.each do |package|
      FileUtils.mkpath("dummy-boshrelease-next/packages/#{File.basename(package)}")
    end

    sources = Dir.glob("dummy-noshrelease/*")
    sources.each do |source|
      FileUtils.mkpath("dummy-boshrelease-next/src/#{File.basename(source)}")
    end
  end

  def boshrelease_tree
    `tree dummy-boshrelease`
  end

  def noshrelease_tree
    `tree dummy-boshrelease-next`
  end
end
