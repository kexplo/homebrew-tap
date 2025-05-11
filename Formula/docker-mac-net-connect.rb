class DockerMacNetConnect < Formula
  desc "(forked) Connect directly to Docker-for-Mac containers via IP address 🐳 💻"
  homepage "https://github.com/kexplo/docker-mac-net-connect"
  version "v0.1.4-colima"
  url "https://github.com/kexplo/docker-mac-net-connect/archive/refs/tags/#{version}.tar.gz"
  sha256 "efa0a5c42f28bf50f2bf4c93a66b0b33fffe4ad753ae16020317aaab5000db5f"
  license "MIT"

  depends_on "go" => :build

  def install
    if ENV["HOMEBREW_GOPROXY"]
      ENV["GOPROXY"] = ENV["HOMEBREW_GOPROXY"]
    end

    system "make", "VERSION=#{version}", "build-go"
    
    bin.install Dir["*"]
  end

  service do
    keep_alive true
    run opt_bin/"docker-mac-net-connect"
    log_path var/"log/docker-mac-net-connect/std_out.log"
    error_log_path var/"log/docker-mac-net-connect/std_error.log"
    # Keep the home directory of the user who ran sudo.
    environment_variables HOME: ENV["HOME"]
  end
end
