class ApiPilotRunner < Formula
  desc "Local runner agent for API Pilot"
  homepage "https://github.com/faizalfakhri0001/api-pilot-runner"
  version "1.1.0"

  if Hardware::CPU.arm?
    url "https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-runner-v1.1.0/api-pilot-runner-mac-arm64.tar.gz"
    sha256 "b8ca9e9d0f64d8c41562f1ecf3afcabfa024ce79a8d2e092e8eba7b7ce1f7cc5"
  else
    url "https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-runner-v1.1.0/api-pilot-runner-mac-amd64.tar.gz"
    sha256 "5b51df37becb9a74fc034ecd298f9bf5f2cce0c8bcff2efbea49a5762972e8d5"
  end

  def install
    bin.install "api-pilot-runner"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/api-pilot-runner version")
  end
end
