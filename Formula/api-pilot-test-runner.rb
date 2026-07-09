class ApiPilotTestRunner < Formula
  desc "Local TestPilot browser runner for API Pilot"
  homepage "https://github.com/faizalfakhri0001/api-pilot-runner"
  version "2.4.2"

  if Hardware::CPU.arm?
    url "https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-test-runner-v2.4.2/api-pilot-test-runner-mac-arm64.tar.gz"
    sha256 "2eb4523ca0d4cca2e4b421a6da24ad9ba92e2907823183567044860f54483eb1"
  else
    url "https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-test-runner-v2.4.2/api-pilot-test-runner-mac-amd64.tar.gz"
    sha256 "b0a9a1676ebb52230b1e3011a78ed171489f36f2f870087ca91ee2fcfa5e47b6"
  end

  depends_on "node"

  def install
    bin.install "api-pilot-test-runner"
    libexec.install "worker" => "api-pilot-test-runner"

    cd libexec/"api-pilot-test-runner" do
      system "npm", "ci", "--omit=dev"
      system "npx", "playwright", "install", "chromium"
    end
  end

  def caveats
    <<~EOS
      Pair and start this runner separately from api-pilot-runner:
        api-pilot-test-runner pair <PAIRING_TOKEN>
        api-pilot-test-runner doctor
        api-pilot-test-runner start

      The HTTP collection runner remains available as api-pilot-runner.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/api-pilot-test-runner version")
  end
end
