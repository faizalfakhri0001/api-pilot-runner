class ApiPilotRunner < Formula
  desc "Local runner agent for API Pilot"
  homepage "https://github.com/faizalfakhri0001/api-pilot-runner"
  version "1.2.1"

  if Hardware::CPU.arm?
    url "https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-runner-v1.2.1/api-pilot-runner-mac-arm64.tar.gz"
    sha256 "f4d5d7d1f7293180f5eb921434da837761ecebb9116740cbbe02362ed2b3efe5"
  else
    url "https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-runner-v1.2.1/api-pilot-runner-mac-amd64.tar.gz"
    sha256 "cfff2c4f8dca7cf730cc111724a831ec6e0586fd4143f6e3f330c54f383c61ec"
  end

  def install
    bin.install "api-pilot-runner"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/api-pilot-runner version")
  end
end
