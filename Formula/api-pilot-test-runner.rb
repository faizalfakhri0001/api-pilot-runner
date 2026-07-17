class ApiPilotTestRunner < Formula
  desc "Local TestPilot browser runner for API Pilot"
  homepage "https://github.com/faizalfakhri0001/antasend-runner"
  version "2.4.4"

  if Hardware::CPU.arm?
    url "https://github.com/faizalfakhri0001/antasend-runner/releases/download/api-pilot-test-runner-v2.4.4/api-pilot-test-runner-mac-arm64.tar.gz"
    sha256 "e3214b2ee442e7e7c51f05f8d3193e523da08720f9d508b5cacb569e0dfcf5d5"
  else
    url "https://github.com/faizalfakhri0001/antasend-runner/releases/download/api-pilot-test-runner-v2.4.4/api-pilot-test-runner-mac-amd64.tar.gz"
    sha256 "998289d153a5923dc2b5c826f55b19362889c89e77e341b943dec575ef67b5e3"
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
