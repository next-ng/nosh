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
    jobs.each do |jobpath|
      jobname = File.basename(jobpath)
      FileUtils.mkpath("dummy-boshrelease-next/jobs/#{jobname}")
      system("cp -R #{jobpath}/job/ dummy-boshrelease-next/jobs/#{jobname}/")
    end

    packages = Dir.glob("dummy-noshrelease/*")
    packages.each do |jobpath|
      next unless File.exist?("#{jobpath}/package/")

      packagename = File.basename(jobpath)
      FileUtils.mkpath("dummy-boshrelease-next/jobs/#{packagename}")
      system("cp -R #{jobpath}/package/ dummy-boshrelease-next/packages/#{packagename}/")
      FileUtils.mkpath("dummy-boshrelease-next/packages/#{packagename}")
    end

    sources = Dir.glob("dummy-noshrelease/*")
    sources.each do |jobpath|
      next unless File.exist?("#{jobpath}/src/")

      sourcename = File.basename(jobpath)
      FileUtils.mkpath("dummy-boshrelease-next/src/#{sourcename}")
      system("cp -R #{jobpath}/src/ dummy-boshrelease-next/src/#{sourcename}/")
      FileUtils.mkpath("dummy-boshrelease-next/src/#{File.basename(jobpath)}")
    end
  end

  def boshrelease_tree
    Dir.chdir("dummy-boshrelease") { `tree`}
  end

  def noshrelease_tree
    Dir.chdir("dummy-boshrelease-next") { `tree`}
  end
end
