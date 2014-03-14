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
    system("mkdir dummy-boshrelease-next") or raise "mkdir broke"
    system("cp -R dummy-noshrelease/ dummy-boshrelease-next/") or raise "cp broke"
  end

  def boshrelease_tree
    `tree dummy-boshrelease`
  end

  def noshrelease_tree
    `tree dummy-boshrelease-next`
  end
end
