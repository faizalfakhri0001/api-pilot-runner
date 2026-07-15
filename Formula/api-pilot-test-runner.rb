class ApiPilotTestRunner < Formula
  desc "Local TestPilot browser runner for API Pilot"
  homepage "https://github.com/faizalfakhri0001/antasend-runner"
  version "2.4.3"

  if Hardware::CPU.arm?
    url "https://github.com/faizalfakhri0001/antasend-runner/releases/download/api-pilot-test-runner-v2.4.3/api-pilot-test-runner-mac-arm64.tar.gz"
    sha256 "23770acade43b9da5c5c217e9f8a02ef1d6f7470809f3fd3eb93b82db0c9c0ef"
  else
    url "https://github.com/faizalfakhri0001/antasend-runner/releases/download/api-pilot-test-runner-v2.4.3/api-pilot-test-runner-mac-amd64.tar.gz"
    sha256 "623bf0e6ec00cd97a8931b2336cda60faead87744a1237e4dfe564ca8c9dea8f"
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
