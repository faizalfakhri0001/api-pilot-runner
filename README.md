# API Pilot Runner Distribution

Public distribution repository for API Pilot local runners.

This repository contains Homebrew formulae and release assets for installing runner binaries without requiring access to the private API Pilot application monorepo.

## Runners

| Binary | Current version | Purpose |
| --- | --- | --- |
| `api-pilot-runner` | `1.0.6` | Local HTTP runner for executing API requests from Collections against localhost, VPN, or private networks. |
| `api-pilot-test-runner` | `1.0.2` | Local browser runner for TestPilot web execution. Requires Node.js and Playwright browser dependencies. |

## Production API Base URL

For API Pilot production, use this API base URL when pairing and starting a runner:

```bash
https://api-apipilot.coopstack.cloud/api/v1
```

Set it as an environment variable before running `pair` or `start`.

macOS/Linux:

```bash
export API_PILOT_BASE_URL="https://api-apipilot.coopstack.cloud/api/v1"
```

Windows PowerShell:

```powershell
$env:API_PILOT_BASE_URL = "https://api-apipilot.coopstack.cloud/api/v1"
```

Do not use the frontend URL `https://apipilot.coopstack.cloud` as `API_PILOT_BASE_URL`. The runner talks to the backend API host.

## macOS Install With Homebrew

Homebrew is the recommended installation method on macOS.

### Install The HTTP Runner

```bash
brew tap faizalfakhri0001/api-pilot-runner https://github.com/faizalfakhri0001/api-pilot-runner.git
brew install api-pilot-runner
api-pilot-runner version
```

### Install The TestPilot Browser Runner

```bash
brew tap faizalfakhri0001/api-pilot-runner https://github.com/faizalfakhri0001/api-pilot-runner.git
brew install api-pilot-test-runner
api-pilot-test-runner version
api-pilot-test-runner doctor
```

The `api-pilot-test-runner` formula installs Node dependencies and Chromium through Playwright during installation.

### Upgrade On macOS

```bash
brew update
brew upgrade api-pilot-runner
brew upgrade api-pilot-test-runner
```

If Homebrew keeps an old tap cache, reset the tap:

```bash
brew uninstall api-pilot-runner || true
brew uninstall api-pilot-test-runner || true
brew untap faizalfakhri0001/api-pilot-runner || true
brew tap faizalfakhri0001/api-pilot-runner https://github.com/faizalfakhri0001/api-pilot-runner.git
brew install api-pilot-runner
```

## Windows Manual Install

Windows binaries are distributed as `.zip` files in GitHub Releases.

### Install The HTTP Runner

1. Download:
   - [api-pilot-runner-windows-amd64.zip](https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-runner-v1.0.6/api-pilot-runner-windows-amd64.zip)
2. Extract the zip.
3. Move `api-pilot-runner.exe` to a permanent folder, for example:

   ```text
   C:\api-pilot\
   ```

4. Add that folder to the Windows `Path` environment variable.
5. Open a new PowerShell window and verify:

   ```powershell
   api-pilot-runner version
   ```

### Install The TestPilot Browser Runner

1. Install Node.js LTS from [nodejs.org](https://nodejs.org/).
2. Download:
   - [api-pilot-test-runner-windows-amd64.zip](https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-test-runner-v1.0.2/api-pilot-test-runner-windows-amd64.zip)
3. Extract the zip to a permanent folder, for example:

   ```text
   C:\api-pilot-test-runner\
   ```

4. Add that folder to the Windows `Path` environment variable.
5. Install worker dependencies from the extracted folder:

   ```powershell
   cd C:\api-pilot-test-runner
   npm ci --omit=dev
   npx playwright install chromium
   api-pilot-test-runner doctor
   ```

The extracted folder must keep these files together:

```text
api-pilot-test-runner.exe
testpilot_worker.mjs
package.json
package-lock.json
node_modules\
```

## Linux Manual Install

Linux binaries are distributed as `.tar.gz` files in GitHub Releases.

### Install The HTTP Runner

```bash
curl -L -o api-pilot-runner-linux-amd64.tar.gz \
  https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-runner-v1.0.6/api-pilot-runner-linux-amd64.tar.gz

tar -xzf api-pilot-runner-linux-amd64.tar.gz
chmod +x api-pilot-runner
sudo mv api-pilot-runner /usr/local/bin/api-pilot-runner

api-pilot-runner version
```

### Install The TestPilot Browser Runner

Install Node.js LTS first. Then:

```bash
mkdir -p "$HOME/.local/api-pilot-test-runner"
cd "$HOME/.local/api-pilot-test-runner"

curl -L -o api-pilot-test-runner-linux-amd64.tar.gz \
  https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-test-runner-v1.0.2/api-pilot-test-runner-linux-amd64.tar.gz

tar -xzf api-pilot-test-runner-linux-amd64.tar.gz
chmod +x api-pilot-test-runner
npm ci --omit=dev
npx playwright install chromium

sudo ln -sf "$HOME/.local/api-pilot-test-runner/api-pilot-test-runner" /usr/local/bin/api-pilot-test-runner
api-pilot-test-runner doctor
```

If Playwright reports missing OS packages, install its system dependencies:

```bash
npx playwright install-deps chromium
```

## Pair A Runner

1. Sign in to API Pilot.
2. Open the target workspace.
3. Open the Local Runners page.
4. Create or pair a new runner.
5. Copy the pairing token.
6. Pair the runner from your terminal.

macOS/Linux:

```bash
export API_PILOT_BASE_URL="https://api-apipilot.coopstack.cloud/api/v1"
api-pilot-runner pair <PAIRING_TOKEN>
```

Windows PowerShell:

```powershell
$env:API_PILOT_BASE_URL = "https://api-apipilot.coopstack.cloud/api/v1"
api-pilot-runner pair <PAIRING_TOKEN>
```

For TestPilot browser runner:

```bash
export API_PILOT_BASE_URL="https://api-apipilot.coopstack.cloud/api/v1"
api-pilot-test-runner pair <PAIRING_TOKEN>
api-pilot-test-runner doctor
```

On Windows PowerShell:

```powershell
$env:API_PILOT_BASE_URL = "https://api-apipilot.coopstack.cloud/api/v1"
api-pilot-test-runner pair <PAIRING_TOKEN>
api-pilot-test-runner doctor
```

## Start A Runner

Start the HTTP runner:

```bash
export API_PILOT_BASE_URL="https://api-apipilot.coopstack.cloud/api/v1"
api-pilot-runner start
```

Windows PowerShell:

```powershell
$env:API_PILOT_BASE_URL = "https://api-apipilot.coopstack.cloud/api/v1"
api-pilot-runner start
```

Start the TestPilot browser runner:

```bash
export API_PILOT_BASE_URL="https://api-apipilot.coopstack.cloud/api/v1"
api-pilot-test-runner start
```

Windows PowerShell:

```powershell
$env:API_PILOT_BASE_URL = "https://api-apipilot.coopstack.cloud/api/v1"
api-pilot-test-runner start
```

Leave the runner process open while executing requests or tests.

## Use The HTTP Runner In Collections

1. Start `api-pilot-runner`.
2. Wait until the runner appears as `Online` in API Pilot.
3. Open a request in Collections.
4. Change the execution target from `Cloud` to your local runner.
5. Click `Send`.

Use a local runner for:

- `localhost`
- `127.0.0.1`
- private IPs
- VPN-only services
- internal APIs that the cloud executor cannot access

## Use The TestPilot Browser Runner

1. Install and pair `api-pilot-test-runner`.
2. Run:

   ```bash
   api-pilot-test-runner doctor
   ```

3. Start the runner:

   ```bash
   api-pilot-test-runner start
   ```

4. In TestPilot, select an online local runner with TestPilot Web capability.

## Release Assets

### `api-pilot-runner-v1.0.6`

| Platform | Asset |
| --- | --- |
| macOS Apple Silicon | [api-pilot-runner-mac-arm64.tar.gz](https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-runner-v1.0.6/api-pilot-runner-mac-arm64.tar.gz) |
| macOS Intel | [api-pilot-runner-mac-amd64.tar.gz](https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-runner-v1.0.6/api-pilot-runner-mac-amd64.tar.gz) |
| Windows x64 | [api-pilot-runner-windows-amd64.zip](https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-runner-v1.0.6/api-pilot-runner-windows-amd64.zip) |
| Linux x64 | [api-pilot-runner-linux-amd64.tar.gz](https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-runner-v1.0.6/api-pilot-runner-linux-amd64.tar.gz) |

### `api-pilot-test-runner-v1.0.2`

| Platform | Asset |
| --- | --- |
| macOS Apple Silicon | [api-pilot-test-runner-mac-arm64.tar.gz](https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-test-runner-v1.0.2/api-pilot-test-runner-mac-arm64.tar.gz) |
| macOS Intel | [api-pilot-test-runner-mac-amd64.tar.gz](https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-test-runner-v1.0.2/api-pilot-test-runner-mac-amd64.tar.gz) |
| Windows x64 | [api-pilot-test-runner-windows-amd64.zip](https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-test-runner-v1.0.2/api-pilot-test-runner-windows-amd64.zip) |
| Linux x64 | [api-pilot-test-runner-linux-amd64.tar.gz](https://github.com/faizalfakhri0001/api-pilot-runner/releases/download/api-pilot-test-runner-v1.0.2/api-pilot-test-runner-linux-amd64.tar.gz) |

## Troubleshooting

### Pairing Fails With `404`

Use the backend API URL:

```bash
API_PILOT_BASE_URL=https://api-apipilot.coopstack.cloud/api/v1 api-pilot-runner pair <PAIRING_TOKEN>
```

Do not use:

```bash
API_PILOT_BASE_URL=https://apipilot.coopstack.cloud/api/v1
```

The `apipilot.coopstack.cloud` host serves the frontend and does not expose runner API routes.

### Pairing Token Expired Or Already Claimed

Create a new pairing token in API Pilot and run `pair` again.

### Command Not Found

Make sure the folder containing the runner binary is in your shell `PATH`.

macOS Homebrew usually installs binaries to:

```text
/opt/homebrew/bin
/usr/local/bin
```

Windows users must add the install folder, for example `C:\api-pilot\`, to the system `Path`.

### TestPilot Worker File Not Found

For manual Windows/Linux installs, keep `api-pilot-test-runner`, `testpilot_worker.mjs`, `package.json`, and `package-lock.json` in the same folder.

If needed, set the worker path explicitly:

```bash
export API_PILOT_TEST_RUNNER_WORKER_PATH="$HOME/.local/api-pilot-test-runner/testpilot_worker.mjs"
```

Windows PowerShell:

```powershell
$env:API_PILOT_TEST_RUNNER_WORKER_PATH = "C:\api-pilot-test-runner\testpilot_worker.mjs"
```

### Playwright Or Chromium Missing

Run:

```bash
npm ci --omit=dev
npx playwright install chromium
```

On Linux, if system dependencies are missing:

```bash
npx playwright install-deps chromium
```

### Reset Runner Credentials

HTTP runner credentials:

macOS/Linux:

```bash
rm -f "$HOME/.runner-credentials.json"
```

Windows PowerShell:

```powershell
Remove-Item "$HOME\.runner-credentials.json" -ErrorAction SilentlyContinue
```

TestPilot runner credentials:

macOS/Linux:

```bash
rm -f "$HOME/.api-pilot-test-runner-credentials.json"
```

Windows PowerShell:

```powershell
Remove-Item "$HOME\.api-pilot-test-runner-credentials.json" -ErrorAction SilentlyContinue
```

Then create a new pairing token and run `pair` again.

## Repository Contents

```text
Formula/
  api-pilot-runner.rb
  api-pilot-test-runner.rb
README.md
```

The application source code lives in the private API Pilot monorepo. This repository is only for public runner distribution.

