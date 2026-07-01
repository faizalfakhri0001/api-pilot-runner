class ApiPilotTestMobileRunner < Formula
  desc "Local Appium 3 native mobile runner for API Pilot"
  homepage "https://github.com/faizalfakhri0001/api-pilot-runner"
  version "0.2.5"

  if Hardware::CPU.arm?
    url "https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-test-mobile-runner-v0.2.5/api-pilot-test-mobile-runner-0.2.5-mac-arm64.tar.gz"
    sha256 "af352ef1e900b67504b372b4a9c597939ab200099a844efa3015ad7aaa003bae"
  else
    url "https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-test-mobile-runner-v0.2.5/api-pilot-test-mobile-runner-0.2.5-mac-amd64.tar.gz"
    sha256 "629c543cc252372c7d5ee83396d2a51844a2bfc47b1603295e3ab8475280c76a"
  end

  depends_on "node"

  def install
    libexec.install "api-pilot-test-mobile-runner"
    libexec.install "worker"
    cd libexec/"worker" do
      system "npm", "ci", "--omit=dev"
      system "./node_modules/.bin/appium", "driver", "list", "--installed"
    end
    (bin/"api-pilot-test-mobile-runner").write <<~SH
      #!/bin/bash
      export API_PILOT_APPIUM_PATH="#{libexec}/worker/node_modules/.bin/appium"
      if [ -d "$HOME/Library/Android/sdk/platform-tools" ]; then
        export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
      fi
      if [ -n "$ANDROID_HOME" ] && [ -d "$ANDROID_HOME/platform-tools" ]; then
        export PATH="$ANDROID_HOME/platform-tools:$PATH"
      fi
      if [ -n "$ANDROID_SDK_ROOT" ] && [ -d "$ANDROID_SDK_ROOT/platform-tools" ]; then
        export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
      fi
      exec "#{libexec}/api-pilot-test-mobile-runner" "$@"
    SH
  end

  def caveats
    <<~EOS
      Appium 3 drivers are pinned inside this formula. Android requires the Android SDK/adb.
      iOS requires macOS, Xcode, WebDriverAgent prerequisites, and an explicit signing policy.

      Pair and verify the runtime before starting:
        api-pilot-test-mobile-runner pair <PAIRING_TOKEN>
        api-pilot-test-mobile-runner doctor --json
        api-pilot-test-mobile-runner start
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/api-pilot-test-mobile-runner version")
    assert_match "uiautomator2", shell_output("#{libexec}/worker/node_modules/.bin/appium driver list --installed")
  end
end
