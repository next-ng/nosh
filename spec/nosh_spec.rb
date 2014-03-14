require "rspec"
require "nosh"

describe Nosh do
  before do
    FileUtils.rm_rf("tmp/generated-boshrelease")
    FileUtils.cp_r("spec/fixtures/source-boshrelease", "tmp/generated-boshrelease")
  end

  it "works" do
    nosh = Nosh.new("tmp/generated-boshrelease")
    nosh.run

    expect(generated_boshrelease).to eq(expected_boshrelease)
  end

  def expected_boshrelease
    Dir.chdir("spec/fixtures/expected-boshrelease") { `tree -a` }
  end

  def generated_boshrelease
    Dir.chdir("tmp/generated-boshrelease") { `tree -a` }
  end
end
