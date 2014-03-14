require "rspec"
require "nosh"

describe Nosh do
  before do
    FileUtils.rm_rf("tmp/generated-boshrelease")
  end

  it "works" do
    nosh = Nosh.new(
      "spec/fixtures/nosh-component",
      "spec/fixtures/source-boshrelease",
      "tmp/generated-boshrelease",
    )
    nosh.run

    expect(expected_boshrelease).to eq(generated_boshrelease)
  end

  def expected_boshrelease
    Dir.chdir("spec/fixtures/expected-boshrelease") { `tree` }
  end

  def generated_boshrelease
    Dir.chdir("tmp/generated-boshrelease") { `tree` }
  end
end
